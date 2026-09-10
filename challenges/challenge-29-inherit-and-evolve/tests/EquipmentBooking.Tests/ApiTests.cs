using System.Net;
using System.Net.Http.Json;
using EquipmentBooking.Web.Domain;

namespace EquipmentBooking.Tests;

public sealed class ApiTests : BookingTest
{
    [Fact]
    public async Task Catalog_contains_synthetic_equipment_and_employees()
    {
        var equipment = await Client.GetFromJsonAsync<Equipment[]>("/api/equipment");
        var employees = await Client.GetFromJsonAsync<Employee[]>("/api/employees");
        Assert.Equal(4, equipment!.Length);
        Assert.Equal("Thermal camera", equipment[0].Name);
        Assert.Equal(3, employees!.Length);
        Assert.Equal("Alex Morgan", employees[0].Name);
    }

    [Fact]
    public async Task Health_checks_the_database()
    {
        var response = await Client.GetAsync("/health");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Contains("healthy", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task Available_item_can_be_booked_and_retrieved()
    {
        var available = await Client.GetFromJsonAsync<Availability>(
            "/api/equipment/3/availability?start=2030-10-10&end=2030-10-12");
        Assert.True(available!.IsAvailable);
        var response = await Create();
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var booking = await response.Content.ReadFromJsonAsync<Reservation>();
        Assert.NotNull(booking);
        Assert.Equal("Confirmed", booking.Status);
        Assert.Equal(new DateOnly(2030, 10, 10), booking.Start);
        var retrieved = await Client.GetFromJsonAsync<Reservation>(response.Headers.Location);
        Assert.Equal(booking, retrieved);
        var reservations = await Client.GetFromJsonAsync<Reservation[]>("/api/reservations");
        Assert.Contains(reservations!, item => item.Id == booking.Id);
        available = await Client.GetFromJsonAsync<Availability>(
            "/api/equipment/3/availability?start=2030-10-10&end=2030-10-12");
        Assert.False(available!.IsAvailable);
    }

    [Theory]
    [InlineData("2030-10-10", "2030-10-12")]
    [InlineData("2030-10-09", "2030-10-11")]
    [InlineData("2030-10-11", "2030-10-13")]
    [InlineData("2030-10-09", "2030-10-13")]
    [InlineData("2030-10-10", "2030-10-11")]
    public async Task Confirmed_reservations_block_every_overlap_shape(string start, string end)
    {
        var availability = await Client.GetFromJsonAsync<Availability>(
            $"/api/equipment/1/availability?start={start}&end={end}");
        Assert.False(availability!.IsAvailable);
        var response = await Create(1, start: start, end: end);
        Assert.Equal(HttpStatusCode.Conflict, response.StatusCode);
    }

    [Theory]
    [InlineData("2030-10-08", "2030-10-10")]
    [InlineData("2030-10-12", "2030-10-14")]
    [InlineData("2001-01-01", "2001-01-02")]
    public async Task Adjacent_and_clock_independent_dates_are_allowed(string start, string end)
    {
        var availability = await Client.GetFromJsonAsync<Availability>(
            $"/api/equipment/1/availability?start={start}&end={end}");
        Assert.True(availability!.IsAvailable);
        Assert.Equal(HttpStatusCode.Created, (await Create(1, start: start, end: end)).StatusCode);
    }

    [Theory]
    [InlineData("", "2030-10-12")]
    [InlineData("2030-10-10", "")]
    [InlineData("10/10/2030", "2030-10-12")]
    [InlineData("2030-02-30", "2030-03-01")]
    [InlineData("2030-10-12", "2030-10-12")]
    [InlineData("2030-10-13", "2030-10-12")]
    public async Task Invalid_dates_are_rejected_by_creation_and_availability(string start, string end)
    {
        var response = await Create(start: start, end: end);
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType!.MediaType);
        response = await Client.GetAsync(
            $"/api/equipment/3/availability?start={Uri.EscapeDataString(start)}&end={Uri.EscapeDataString(end)}");
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Missing_dates_and_malformed_json_are_bad_requests()
    {
        Assert.Equal(HttpStatusCode.BadRequest, (await Client.GetAsync("/api/equipment/3/availability")).StatusCode);
        Assert.Equal(HttpStatusCode.BadRequest,
            (await Client.PostAsJsonAsync("/api/reservations", new { equipmentId = 3, employeeId = 1 })).StatusCode);
        using var malformed = new StringContent("{", System.Text.Encoding.UTF8, "application/json");
        Assert.Equal(HttpStatusCode.BadRequest, (await Client.PostAsync("/api/reservations", malformed)).StatusCode);
    }

    [Theory]
    [InlineData(999, 1, HttpStatusCode.NotFound)]
    [InlineData(3, 999, HttpStatusCode.NotFound)]
    [InlineData(0, 1, HttpStatusCode.BadRequest)]
    [InlineData(3, 0, HttpStatusCode.BadRequest)]
    public async Task Creation_validates_identifiers(int equipment, int employee, HttpStatusCode expected)
    {
        Assert.Equal(expected, (await Create(equipment, employee)).StatusCode);
    }

    [Theory]
    [InlineData("/api/reservations/999")]
    [InlineData("/api/equipment/999/availability?start=2030-10-10&end=2030-10-12")]
    public async Task Unknown_identifiers_return_not_found(string route)
    {
        Assert.Equal(HttpStatusCode.NotFound, (await Client.GetAsync(route)).StatusCode);
    }

    [Fact]
    public async Task Cancelling_updates_history_and_is_repeatable()
    {
        var created = await (await Create()).Content.ReadFromJsonAsync<Reservation>();
        var route = $"/api/reservations/{created!.Id}/cancel";
        foreach (var attempt in Enumerable.Range(0, 2))
        {
            var response = await Client.PostAsync(route, null);
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            Assert.Equal("Cancelled", (await response.Content.ReadFromJsonAsync<Reservation>())!.Status);
        }

        var record = await Client.GetFromJsonAsync<Reservation>($"/api/reservations/{created.Id}");
        Assert.Equal("Cancelled", record!.Status);
        Assert.Equal(HttpStatusCode.NotFound, (await Client.PostAsync("/api/reservations/999/cancel", null)).StatusCode);
    }

    [Fact]
    public async Task Maintenance_blocks_creation_and_can_be_toggled()
    {
        var availability = await Client.GetFromJsonAsync<Availability>(
            "/api/equipment/4/availability?start=2030-10-10&end=2030-10-12");
        Assert.False(availability!.IsAvailable);
        Assert.Equal("Under maintenance", availability.Reason);
        Assert.Equal(HttpStatusCode.Conflict, (await Create(4)).StatusCode);
        var response = await Client.PutAsJsonAsync("/api/equipment/4/maintenance", new { isUnderMaintenance = false });
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal(HttpStatusCode.Created, (await Create(4)).StatusCode);
        response = await Client.PutAsJsonAsync("/api/equipment/4/maintenance", new { isUnderMaintenance = true });
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var history = await Client.GetFromJsonAsync<Reservation[]>("/api/reservations");
        Assert.Contains(history!, item => item.EquipmentId == 4 && item.Status == "Confirmed");
        Assert.Equal(HttpStatusCode.Conflict, (await Create(4, start: "2030-11-01", end: "2030-11-02")).StatusCode);
    }

    [Fact]
    public async Task Maintenance_validates_missing_values_and_unknown_equipment()
    {
        Assert.Equal(HttpStatusCode.BadRequest,
            (await Client.PutAsJsonAsync("/api/equipment/3/maintenance", new { })).StatusCode);
        Assert.Equal(HttpStatusCode.NotFound,
            (await Client.PutAsJsonAsync("/api/equipment/999/maintenance", new { isUnderMaintenance = true })).StatusCode);
    }

    [Fact]
    public async Task Competing_requests_create_exactly_one_booking()
    {
        var responses = await Task.WhenAll(Enumerable.Range(0, 8).Select(_ => Task.Run(() => Create())));
        Assert.Single(responses, response => response.StatusCode == HttpStatusCode.Created);
        Assert.Equal(7, responses.Count(response => response.StatusCode == HttpStatusCode.Conflict));
        var history = await Client.GetFromJsonAsync<Reservation[]>("/api/reservations");
        Assert.Single(history!, item => item.EquipmentId == 3);
    }

    [Fact]
    public async Task Restart_preserves_bookings_cancellation_and_maintenance_without_reseeding()
    {
        var created = await (await Create()).Content.ReadFromJsonAsync<Reservation>();
        (await Client.PostAsync("/api/reservations/1001/cancel", null)).EnsureSuccessStatusCode();
        (await Client.PutAsJsonAsync("/api/equipment/4/maintenance", new { isUnderMaintenance = false })).EnsureSuccessStatusCode();
        Client.Dispose();
        App.Dispose();

        using var restarted = new BookingApplication(DatabasePath);
        using var client = restarted.Browser();
        var history = await client.GetFromJsonAsync<Reservation[]>("/api/reservations");
        Assert.Equal(3, history!.Length);
        Assert.Contains(history, item => item.Id == created!.Id && item.Status == "Confirmed");
        Assert.Contains(history, item => item.Id == 1001 && item.Status == "Cancelled");
        var equipment = await client.GetFromJsonAsync<Equipment[]>("/api/equipment");
        Assert.False(equipment!.Single(item => item.Id == 4).IsUnderMaintenance);
        var available = await client.GetFromJsonAsync<Availability>(
            "/api/equipment/3/availability?start=2030-10-10&end=2030-10-12");
        Assert.False(available!.IsAvailable);
    }

    private Task<HttpResponseMessage> Create(int equipment = 3, int employee = 1,
        string start = "2030-10-10", string end = "2030-10-12") =>
        Client.PostAsJsonAsync("/api/reservations", new BookingRequest(equipment, employee, start, end));
}
