using EquipmentBooking.Web.Domain;
using Microsoft.Data.Sqlite;

namespace EquipmentBooking.Web.Data;

public sealed class AllocationStore
{
    public bool HasOverlap(SqliteConnection connection, SqliteTransaction transaction, int equipmentId, BookingRange range)
    {
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = """
            SELECT EXISTS (
                SELECT 1 FROM allocations
                WHERE equipment_id = $equipment AND state = 'Held'
                  AND start_date < $end AND end_date > $start
            );
            """;
        AddRangeParameters(command, equipmentId, range);
        return Convert.ToInt32(command.ExecuteScalar()) == 1;
    }

    public void Hold(SqliteConnection connection, SqliteTransaction transaction, int reservationId,
        int equipmentId, BookingRange range)
    {
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = """
            INSERT INTO allocations (reservation_id, equipment_id, start_date, end_date, state)
            VALUES ($reservation, $equipment, $start, $end, 'Held');
            """;
        command.Parameters.AddWithValue("$reservation", reservationId);
        AddRangeParameters(command, equipmentId, range);
        command.ExecuteNonQuery();
    }

    private static void AddRangeParameters(SqliteCommand command, int equipmentId, BookingRange range)
    {
        command.Parameters.AddWithValue("$equipment", equipmentId);
        command.Parameters.AddWithValue("$start", BookingRange.Format(range.Start));
        command.Parameters.AddWithValue("$end", BookingRange.Format(range.End));
    }
}
