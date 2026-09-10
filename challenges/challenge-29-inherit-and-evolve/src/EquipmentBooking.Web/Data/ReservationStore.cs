using System.Globalization;
using EquipmentBooking.Web.Domain;
using Microsoft.Data.Sqlite;

namespace EquipmentBooking.Web.Data;

public sealed class ReservationStore(BookingDatabase database)
{
    private const string Select = """
        SELECT r.id, r.equipment_id, e.name, r.employee_id, p.name, r.start_date, r.end_date, r.status
        FROM reservations r
        JOIN equipment e ON e.id = r.equipment_id
        JOIN employees p ON p.id = r.employee_id
        """;

    public IReadOnlyList<Reservation> List()
    {
        using var connection = database.Open();
        using var command = connection.CreateCommand();
        command.CommandText = Select + " ORDER BY r.id DESC;";
        using var reader = command.ExecuteReader();
        var items = new List<Reservation>();
        while (reader.Read()) items.Add(ReadReservation(reader));
        return items;
    }

    public Reservation Get(int id)
    {
        using var connection = database.Open();
        using var command = connection.CreateCommand();
        command.CommandText = Select + " WHERE r.id = $id;";
        command.Parameters.AddWithValue("$id", id);
        using var reader = command.ExecuteReader();
        return reader.Read() ? ReadReservation(reader)
            : throw new BookingException(404, "That reservation was not found.");
    }

    public int Insert(SqliteConnection connection, SqliteTransaction transaction, BookingRequest request, BookingRange range)
    {
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = """
            INSERT INTO reservations (equipment_id, employee_id, start_date, end_date, status)
            VALUES ($equipment, $employee, $start, $end, 'Confirmed');
            SELECT last_insert_rowid();
            """;
        command.Parameters.AddWithValue("$equipment", request.EquipmentId);
        command.Parameters.AddWithValue("$employee", request.EmployeeId);
        command.Parameters.AddWithValue("$start", BookingRange.Format(range.Start));
        command.Parameters.AddWithValue("$end", BookingRange.Format(range.End));
        return checked((int)(long)command.ExecuteScalar()!);
    }

    public Reservation Cancel(int id)
    {
        using var connection = database.Open();
        using var command = connection.CreateCommand();
        command.CommandText = "UPDATE reservations SET status = 'Cancelled' WHERE id = $id;";
        command.Parameters.AddWithValue("$id", id);
        if (command.ExecuteNonQuery() == 0)
        {
            throw new BookingException(404, "That reservation was not found.");
        }

        return Get(id);
    }

    private static Reservation ReadReservation(SqliteDataReader reader) =>
        new(reader.GetInt32(0), reader.GetInt32(1), reader.GetString(2), reader.GetInt32(3), reader.GetString(4),
            DateOnly.ParseExact(reader.GetString(5), "yyyy-MM-dd", CultureInfo.InvariantCulture),
            DateOnly.ParseExact(reader.GetString(6), "yyyy-MM-dd", CultureInfo.InvariantCulture), reader.GetString(7));
}
