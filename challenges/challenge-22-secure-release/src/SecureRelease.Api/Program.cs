using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using SecureRelease.Api;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<DemoDataStore>();
builder.Services.Configure<PaymentProviderOptions>(
    builder.Configuration.GetSection(PaymentProviderOptions.SectionName));
builder.Services
    .AddAuthentication("DemoBearer")
    .AddScheme<AuthenticationSchemeOptions, DemoAuthenticationHandler>("DemoBearer", _ => { });
builder.Services.AddAuthorization();

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/health", () => Results.Ok(new { status = "ok" }));

app.MapPost("/identity/session", (
    CreateSessionRequest request,
    DemoDataStore store) =>
{
    var user = store.FindUser(request.UserName);
    return user is null
        ? Results.NotFound(new { message = "Unknown user." })
        : Results.Ok(new
        {
            accessToken = user.DemoToken,
            user = new { user.Id, user.UserName, user.DisplayName, user.Role }
        });
});

app.MapGet("/identity/me", (
    ClaimsPrincipal principal,
    DemoDataStore store) =>
{
    var id = principal.FindFirstValue(ClaimTypes.NameIdentifier);
    var user = id is null ? null : store.FindUserById(id);
    return user is null
        ? Results.NotFound()
        : Results.Ok(new { user.Id, user.UserName, user.DisplayName, user.Role });
}).RequireAuthorization();

app.MapGet("/payments/{id}", (
    string id,
    DemoDataStore store) =>
{
    var payment = store.FindPayment(id);
    return payment is null ? Results.NotFound() : Results.Ok(payment);
}).RequireAuthorization();

app.MapPost("/payments", (
    CreatePaymentRequest request,
    ClaimsPrincipal principal,
    DemoDataStore store,
    ILogger<Program> logger) =>
{
    var userId = principal.FindFirstValue(ClaimTypes.NameIdentifier)!;
    var payment = store.AddPayment(userId, request);

    logger.LogInformation(
        "Payment {PaymentId} created for account {AccountId} with amount {Amount}",
        payment.Id,
        payment.AccountId,
        payment.Amount);
    store.AddSecurityEvent("payment.created", $"Payment {payment.Id} accepted.");

    return Results.Created($"/payments/{payment.Id}", payment);
}).RequireAuthorization();

app.MapGet("/admin/users", (DemoDataStore store) =>
    Results.Ok(store.Users.Select(user => new
    {
        user.Id,
        user.UserName,
        user.DisplayName,
        user.Role
    }))).RequireAuthorization();

app.MapGet("/admin/config", (
    IOptions<PaymentProviderOptions> options) =>
    Results.Ok(new
    {
        paymentProviderApiKey = options.Value.ApiKey,
        source = "application configuration"
    })).RequireAuthorization();

app.MapGet("/admin/security-events", (DemoDataStore store) =>
    Results.Ok(store.SecurityEvents)).RequireAuthorization();

app.Run();

public partial class Program;
