using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

[assembly: CollectionBehavior(DisableTestParallelization = true)]

namespace SecureRelease.Api.Tests;

public sealed class SecurityCharacterizationTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public SecurityCharacterizationTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
    }

    [Fact]
    public async Task HealthEndpointReturnsOk()
    {
        using var client = _factory.CreateClient();

        var response = await client.GetAsync("/health");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task SessionCanBeCreatedWithOnlyAUserName_CurrentGap()
    {
        using var client = _factory.CreateClient();

        var response = await client.PostAsJsonAsync(
            "/identity/session",
            new { userName = "alice" });
        var body = await response.Content.ReadFromJsonAsync<JsonElement>();

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal("demo-alice-token", body.GetProperty("accessToken").GetString());
    }

    [Fact]
    public async Task CustomerCanReadAnotherCustomersPayment_CurrentGap()
    {
        using var client = CreateAuthenticatedClient("demo-alice-token");

        var response = await client.GetAsync("/payments/pay-200");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task CustomerCanReachAdminUsersEndpoint_CurrentGap()
    {
        using var client = CreateAuthenticatedClient("demo-alice-token");

        var response = await client.GetAsync("/admin/users");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task NegativePaymentIsAccepted_CurrentGap()
    {
        using var client = CreateAuthenticatedClient("demo-alice-token");

        var response = await client.PostAsJsonAsync(
            "/payments",
            new
            {
                accountId = "acct-alice-01",
                amount = -25.00m,
                currency = "USD",
                memo = "Characterization test"
            });

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
    }

    [Fact]
    public async Task UnknownBearerTokenIsRejected()
    {
        using var client = CreateAuthenticatedClient("not-a-valid-token");

        var response = await client.GetAsync("/identity/me");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    private HttpClient CreateAuthenticatedClient(string token)
    {
        var client = _factory.CreateClient();
        client.DefaultRequestHeaders.Authorization =
            new AuthenticationHeaderValue("Bearer", token);
        return client;
    }
}
