using EquipmentBooking.Web.Application;
using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;

namespace EquipmentBooking.Web.Api;

public static class BookingEndpoints
{
    public static void MapBookingApi(this WebApplication app)
    {
        var api = app.MapGroup("/api");
        api.AddEndpointFilter(async (context, next) =>
        {
            try
            {
                return await next(context);
            }
            catch (BookingException exception)
            {
                return Results.Problem(statusCode: exception.StatusCode, title: exception.Message);
            }
        });

        api.MapGet("/equipment", (CatalogStore catalog) => catalog.ListEquipment());
        api.MapGet("/employees", (CatalogStore catalog) => catalog.ListEmployees());
        api.MapGet("/equipment/{id:int}/availability", (int id, string? start, string? end, BookingService bookings) =>
            bookings.CheckAvailability(id, start, end));
        api.MapPut("/equipment/{id:int}/maintenance", (int id, MaintenanceRequest request, CatalogStore catalog) =>
        {
            if (request.IsUnderMaintenance is not bool maintenance)
            {
                throw new BookingException(400, "Supply isUnderMaintenance as true or false.");
            }

            return catalog.SetMaintenance(id, maintenance);
        });
        api.MapGet("/reservations", (ReservationStore reservations) => reservations.List());
        api.MapGet("/reservations/{id:int}", (int id, ReservationStore reservations) => reservations.Get(id));
        api.MapPost("/reservations", (BookingRequest request, BookingService bookings) =>
        {
            var reservation = bookings.Create(request);
            return Results.Created($"/api/reservations/{reservation.Id}", reservation);
        });
        api.MapPost("/reservations/{id:int}/cancel", (int id, BookingService bookings) => bookings.Cancel(id));
    }
}
