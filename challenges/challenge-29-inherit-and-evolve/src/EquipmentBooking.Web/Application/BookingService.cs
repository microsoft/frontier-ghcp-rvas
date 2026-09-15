using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;

namespace EquipmentBooking.Web.Application;

public sealed class BookingService(
    BookingDatabase database, CatalogStore catalog, ReservationStore reservations,
    AllocationStore allocations, AvailabilityPolicy policy)
{
    public Availability CheckAvailability(int equipmentId, string? start, string? end)
    {
        var range = BookingRange.Parse(start, end);
        using var connection = database.Open();
        using var transaction = connection.BeginTransaction(deferred: true);
        return policy.Evaluate(connection, transaction, equipmentId, range);
    }

    public Reservation Create(BookingRequest request)
    {
        var range = BookingRange.Parse(request.Start, request.End);
        if (request.EquipmentId <= 0 || request.EmployeeId <= 0)
        {
            throw new BookingException(400, "Choose an equipment item and an employee.");
        }

        using var connection = database.Open();
        // Take the write lock before checking inventory so competing requests cannot both book it.
        using var transaction = connection.BeginTransaction(deferred: false);
        var availability = policy.Evaluate(connection, transaction, request.EquipmentId, range);
        if (!catalog.EmployeeExists(connection, transaction, request.EmployeeId))
        {
            throw new BookingException(404, "That employee was not found.");
        }

        if (!availability.IsAvailable)
        {
            throw new BookingException(409, availability.Reason + ". Choose another item or date range.");
        }

        var id = reservations.Insert(connection, transaction, request, range);
        allocations.Hold(connection, transaction, id, request.EquipmentId, range);
        transaction.Commit();
        return reservations.Get(id);
    }

    public Reservation Cancel(int id) => reservations.Cancel(id);
}
