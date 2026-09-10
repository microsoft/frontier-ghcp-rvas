using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;
using Microsoft.Data.Sqlite;

namespace EquipmentBooking.Web.Application;

public sealed class AvailabilityPolicy(CatalogStore catalog, AllocationStore allocations)
{
    public Availability Evaluate(SqliteConnection connection, SqliteTransaction transaction, int equipmentId, BookingRange range)
    {
        var equipment = catalog.FindEquipment(connection, transaction, equipmentId)
            ?? throw new BookingException(404, "That equipment was not found.");
        if (equipment.IsUnderMaintenance)
        {
            return new Availability(equipmentId, range.Start, range.End, false, "Under maintenance");
        }

        return allocations.HasOverlap(connection, transaction, equipmentId, range)
            ? new Availability(equipmentId, range.Start, range.End, false, "Reserved for these dates")
            : new Availability(equipmentId, range.Start, range.End, true, "Available");
    }
}
