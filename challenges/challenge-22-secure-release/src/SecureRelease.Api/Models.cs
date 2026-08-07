namespace SecureRelease.Api;

public sealed record UserAccount(
    string Id,
    string UserName,
    string DisplayName,
    string Role,
    string DemoToken);

public sealed record Payment(
    string Id,
    string OwnerUserId,
    string AccountId,
    decimal Amount,
    string Currency,
    string Memo,
    DateTimeOffset CreatedAt);

public sealed record CreateSessionRequest(string UserName);

public sealed record CreatePaymentRequest(
    string AccountId,
    decimal Amount,
    string Currency,
    string Memo);

public sealed record SecurityEvent(
    DateTimeOffset Timestamp,
    string EventType,
    string Detail);

public sealed class PaymentProviderOptions
{
    public const string SectionName = "PaymentProvider";

    public string ApiKey { get; init; } = string.Empty;
}
