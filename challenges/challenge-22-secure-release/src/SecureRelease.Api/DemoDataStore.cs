using System.Collections.Concurrent;

namespace SecureRelease.Api;

public sealed class DemoDataStore
{
    private readonly ConcurrentDictionary<string, UserAccount> _users = new(
        new[]
        {
            KeyValuePair.Create(
                "alice",
                new UserAccount("usr-100", "alice", "Alice Chen", "customer", "demo-alice-token")),
            KeyValuePair.Create(
                "bob",
                new UserAccount("usr-200", "bob", "Bob Singh", "customer", "demo-bob-token")),
            KeyValuePair.Create(
                "riley",
                new UserAccount("usr-900", "riley", "Riley Admin", "admin", "demo-riley-token"))
        },
        StringComparer.OrdinalIgnoreCase);

    private readonly ConcurrentDictionary<string, Payment> _payments = new(
        new[]
        {
            KeyValuePair.Create(
                "pay-100",
                new Payment(
                    "pay-100",
                    "usr-100",
                    "acct-alice-01",
                    42.50m,
                    "USD",
                    "Office supplies",
                    DateTimeOffset.Parse("2026-07-28T10:15:00Z"))),
            KeyValuePair.Create(
                "pay-200",
                new Payment(
                    "pay-200",
                    "usr-200",
                    "acct-bob-01",
                    88.10m,
                    "USD",
                    "Training materials",
                    DateTimeOffset.Parse("2026-07-29T14:30:00Z")))
        },
        StringComparer.OrdinalIgnoreCase);

    private readonly ConcurrentQueue<SecurityEvent> _securityEvents = new();

    public IReadOnlyCollection<UserAccount> Users => _users.Values.ToArray();

    public IReadOnlyCollection<SecurityEvent> SecurityEvents => _securityEvents.ToArray();

    public UserAccount? FindUser(string userName) =>
        _users.TryGetValue(userName, out var user) ? user : null;

    public UserAccount? FindUserByToken(string token) =>
        _users.Values.SingleOrDefault(user => user.DemoToken == token);

    public UserAccount? FindUserById(string id) =>
        _users.Values.SingleOrDefault(user => user.Id == id);

    public Payment? FindPayment(string id) =>
        _payments.TryGetValue(id, out var payment) ? payment : null;

    public Payment AddPayment(string ownerUserId, CreatePaymentRequest request)
    {
        var id = $"pay-{Guid.NewGuid():N}";
        var payment = new Payment(
            id,
            ownerUserId,
            request.AccountId,
            request.Amount,
            request.Currency,
            request.Memo,
            DateTimeOffset.UtcNow);

        _payments[id] = payment;
        return payment;
    }

    public void AddSecurityEvent(string eventType, string detail) =>
        _securityEvents.Enqueue(new SecurityEvent(DateTimeOffset.UtcNow, eventType, detail));
}
