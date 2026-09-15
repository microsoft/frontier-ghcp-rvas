using System.Net;
using System.Net.Http.Json;
using AngleSharp.Html.Parser;
using EquipmentBooking.Web.Domain;

namespace EquipmentBooking.Tests;

public sealed class BrowserTests : BookingTest
{
    [Theory]
    [InlineData("/", "Equipment register")]
    [InlineData("/Reservations", "Reservations")]
    [InlineData("/Admin", "Demo admin")]
    public async Task Pages_are_server_rendered_and_label_the_demo(string route, string expected)
    {
        var response = await Client.GetAsync(route);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains(expected, html, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("NO AUTHENTICATION", html);
        Assert.Contains("Synthetic records", html);
    }

    [Fact]
    public async Task Equipment_page_uses_fixed_sample_dates_and_supports_date_search()
    {
        var html = await Client.GetStringAsync("/");
        Assert.Contains("2030-10-10", html);
        Assert.Contains("2030-10-12", html);
        Assert.Contains("Thermal camera", html);
        var document = await new HtmlParser().ParseDocumentAsync(html);
        Assert.Equal(4, document.QuerySelectorAll(".equipment-card").Length);
        var response = await Client.GetAsync("/?Start=2030-10-12&End=2030-10-14");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        document = await new HtmlParser().ParseDocumentAsync(await response.Content.ReadAsStringAsync());
        Assert.Contains("Available", document.QuerySelector(".equipment-card")!.TextContent);
    }

    [Theory]
    [InlineData("/", "2030-10-10", "2030-10-12")]
    [InlineData("/?Start=2030-10-12&End=2030-10-14", "2030-10-12", "2030-10-14")]
    [InlineData("/?End=2030-10-14", "2030-10-10", "2030-10-14")]
    [InlineData("/?Start=2030-10-09", "2030-10-09", "2030-10-12")]
    public async Task Equipment_page_has_no_validation_errors_for_default_or_valid_dates(
        string route, string start, string end)
    {
        var response = await Client.GetAsync(route);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var document = await new HtmlParser().ParseDocumentAsync(await response.Content.ReadAsStringAsync());
        Assert.Null(document.QuerySelector(".validation-summary-errors"));
        Assert.Equal(start, document.QuerySelector("input[name='Start']")!.GetAttribute("value"));
        Assert.Equal(end, document.QuerySelector("input[name='End']")!.GetAttribute("value"));
    }

    [Theory]
    [InlineData("/?Start=2030-10-12&End=2030-10-10", "The return date must be after the pickup date.")]
    [InlineData("/?Start=&End=", "Enter both dates in YYYY-MM-DD format.")]
    [InlineData("/?Start=", "Enter both dates in YYYY-MM-DD format.")]
    [InlineData("/?End=", "Enter both dates in YYYY-MM-DD format.")]
    [InlineData("/?Start=invalid&End=2030-10-12", "Enter both dates in YYYY-MM-DD format.")]
    public async Task Invalid_date_search_shows_friendly_error(string route, string message)
    {
        var response = await Client.GetAsync(route);
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        var document = await new HtmlParser().ParseDocumentAsync(await response.Content.ReadAsStringAsync());
        Assert.Contains(message, document.QuerySelector(".validation-summary-errors")!.TextContent);
    }

    [Fact]
    public async Task Browser_can_create_then_cancel_a_reservation()
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        var response = await PostCreate(token);
        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        var page = await Client.GetStringAsync("/Reservations");
        Assert.Contains("Reservation #1003 confirmed", page);
        var history = await Client.GetFromJsonAsync<Reservation[]>("/api/reservations");
        var booking = Assert.Single(history!, item => item.EquipmentId == 3);
        token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        response = await Client.PostAsync("/Reservations?handler=Cancel", Form(token, ("id", booking.Id.ToString())));
        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        page = await Client.GetStringAsync("/Reservations");
        Assert.Contains($"Reservation #{booking.Id} cancelled", page);
        var record = await Client.GetFromJsonAsync<Reservation>($"/api/reservations/{booking.Id}");
        Assert.Equal("Cancelled", record!.Status);
    }

    [Fact]
    public async Task Browser_can_toggle_maintenance()
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Admin");
        var response = await Client.PostAsync("/Admin?handler=Maintenance",
            Form(token, ("id", "3"), ("isUnderMaintenance", "true")));
        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        Assert.Contains("Inspection tablet marked for maintenance", await Client.GetStringAsync("/Admin"));
        var equipment = await Client.GetFromJsonAsync<Equipment[]>("/api/equipment");
        Assert.True(equipment!.Single(item => item.Id == 3).IsUnderMaintenance);
    }

    [Theory]
    [InlineData("1", "2030-10-10", "2030-10-12", HttpStatusCode.Conflict, "Reserved for these dates")]
    [InlineData("4", "2030-10-10", "2030-10-12", HttpStatusCode.Conflict, "Under maintenance")]
    [InlineData("3", "2030-10-12", "2030-10-12", HttpStatusCode.BadRequest, "return date must be after")]
    [InlineData("999", "2030-10-10", "2030-10-12", HttpStatusCode.NotFound, "equipment was not found")]
    public async Task Browser_shows_booking_errors(string equipment, string start, string end, HttpStatusCode expected, string message)
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        var response = await Client.PostAsync("/Reservations?handler=Create",
            Form(token, ("EquipmentId", equipment), ("EmployeeId", "1"), ("Start", start), ("End", end)));
        Assert.Equal(expected, response.StatusCode);
        Assert.Contains(message, await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task Browser_rejects_missing_booking_dates()
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        var response = await Client.PostAsync("/Reservations?handler=Create",
            Form(token, ("EquipmentId", "3"), ("EmployeeId", "1"), ("Start", ""), ("End", "")));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Contains("Enter both dates", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task Browser_shows_unknown_cancellation_and_maintenance_errors()
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        var response = await Client.PostAsync("/Reservations?handler=Cancel", Form(token, ("id", "999")));
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        Assert.Contains("reservation was not found", await response.Content.ReadAsStringAsync());
        token = await BookingApplication.AntiforgeryToken(Client, "/Admin");
        response = await Client.PostAsync("/Admin?handler=Maintenance",
            Form(token, ("id", "999"), ("isUnderMaintenance", "true")));
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        Assert.Contains("equipment was not found", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task Razor_forms_require_antiforgery_tokens()
    {
        var response = await PostCreate("");
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        response = await Client.PostAsync("/Reservations?handler=Cancel", Form("", ("id", "1001")));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        response = await Client.PostAsync("/Admin?handler=Maintenance",
            Form("", ("id", "3"), ("isUnderMaintenance", "true")));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Browser_encodes_invalid_input()
    {
        var token = await BookingApplication.AntiforgeryToken(Client, "/Reservations");
        var response = await Client.PostAsync("/Reservations?handler=Create",
            Form(token, ("EquipmentId", "3"), ("EmployeeId", "1"),
                ("Start", "\"><script>alert(1)</script>"), ("End", "2030-10-12")));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.DoesNotContain("<script>alert(1)</script>", html);
        Assert.Contains("&lt;script&gt;", html);
    }

    [Fact]
    public async Task Stylesheet_is_served_locally()
    {
        var response = await Client.GetAsync("/css/site.css");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal("text/css", response.Content.Headers.ContentType!.MediaType);
    }

    private Task<HttpResponseMessage> PostCreate(string token) =>
        Client.PostAsync("/Reservations?handler=Create", Form(token,
            ("EquipmentId", "3"), ("EmployeeId", "1"), ("Start", "2030-10-10"), ("End", "2030-10-12")));

    private static FormUrlEncodedContent Form(string token, params (string Key, string Value)[] fields) =>
        new(fields.Select(field => new KeyValuePair<string, string>(field.Key, field.Value))
            .Append(new KeyValuePair<string, string>("__RequestVerificationToken", token)));
}
