using EquipmentBooking.Web.Domain;
using Microsoft.Data.Sqlite;

namespace EquipmentBooking.Web.Data;

public sealed class CatalogStore(BookingDatabase database)
{
    public IReadOnlyList<Equipment> ListEquipment()
    {
        using var connection = database.Open();
        using var command = connection.CreateCommand();
        command.CommandText = "SELECT id, name, category, location, is_under_maintenance FROM equipment ORDER BY id;";
        using var reader = command.ExecuteReader();
        var items = new List<Equipment>();
        while (reader.Read()) items.Add(ReadEquipment(reader));
        return items;
    }

    public Equipment? FindEquipment(SqliteConnection connection, SqliteTransaction transaction, int id)
    {
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = "SELECT id, name, category, location, is_under_maintenance FROM equipment WHERE id = $id;";
        command.Parameters.AddWithValue("$id", id);
        using var reader = command.ExecuteReader();
        return reader.Read() ? ReadEquipment(reader) : null;
    }

    public IReadOnlyList<Employee> ListEmployees()
    {
        using var connection = database.Open();
        using var command = connection.CreateCommand();
        command.CommandText = "SELECT id, name, department FROM employees ORDER BY id;";
        using var reader = command.ExecuteReader();
        var items = new List<Employee>();
        while (reader.Read()) items.Add(new Employee(reader.GetInt32(0), reader.GetString(1), reader.GetString(2)));
        return items;
    }

    public bool EmployeeExists(SqliteConnection connection, SqliteTransaction transaction, int id)
    {
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = "SELECT COUNT(*) FROM employees WHERE id = $id;";
        command.Parameters.AddWithValue("$id", id);
        return Convert.ToInt32(command.ExecuteScalar()) == 1;
    }

    public Equipment SetMaintenance(int id, bool isUnderMaintenance)
    {
        using var connection = database.Open();
        using var transaction = connection.BeginTransaction(deferred: false);
        var equipment = FindEquipment(connection, transaction, id)
            ?? throw new BookingException(404, "That equipment was not found.");
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = "UPDATE equipment SET is_under_maintenance = $maintenance WHERE id = $id;";
        command.Parameters.AddWithValue("$maintenance", isUnderMaintenance);
        command.Parameters.AddWithValue("$id", id);
        command.ExecuteNonQuery();
        transaction.Commit();
        return equipment with { IsUnderMaintenance = isUnderMaintenance };
    }

    private static Equipment ReadEquipment(SqliteDataReader reader) =>
        new(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3), reader.GetBoolean(4));
}
