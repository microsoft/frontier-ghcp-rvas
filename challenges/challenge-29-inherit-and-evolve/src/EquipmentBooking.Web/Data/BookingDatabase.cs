using Microsoft.Data.Sqlite;

namespace EquipmentBooking.Web.Data;

public sealed class BookingDatabase
{
    private readonly string connectionString;

    public BookingDatabase(IConfiguration configuration, IWebHostEnvironment environment)
    {
        var configuredPath = configuration["Booking:DatabasePath"];
        if (string.IsNullOrWhiteSpace(configuredPath))
        {
            throw new InvalidOperationException("Booking:DatabasePath must name a SQLite database file.");
        }

        var path = Path.GetFullPath(configuredPath, environment.ContentRootPath);
        Directory.CreateDirectory(Path.GetDirectoryName(path)!);
        connectionString = new SqliteConnectionStringBuilder
        {
            DataSource = path,
            ForeignKeys = true,
            DefaultTimeout = 30,
            Pooling = false
        }.ToString();
    }

    public SqliteConnection Open()
    {
        var connection = new SqliteConnection(connectionString);
        connection.Open();
        return connection;
    }

    public void Initialize()
    {
        using var connection = Open();
        using (var journal = connection.CreateCommand())
        {
            journal.CommandText = "PRAGMA journal_mode = WAL;";
            journal.ExecuteNonQuery();
        }

        using var transaction = connection.BeginTransaction(deferred: false);
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = """
            CREATE TABLE IF NOT EXISTS equipment (
                id INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                category TEXT NOT NULL,
                location TEXT NOT NULL,
                is_under_maintenance INTEGER NOT NULL CHECK (is_under_maintenance IN (0, 1))
            );
            CREATE TABLE IF NOT EXISTS employees (
                id INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                department TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS reservations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                equipment_id INTEGER NOT NULL REFERENCES equipment(id),
                employee_id INTEGER NOT NULL REFERENCES employees(id),
                start_date TEXT NOT NULL,
                end_date TEXT NOT NULL CHECK (end_date > start_date),
                status TEXT NOT NULL CHECK (status IN ('Confirmed', 'Cancelled'))
            );
            CREATE TABLE IF NOT EXISTS allocations (
                reservation_id INTEGER PRIMARY KEY REFERENCES reservations(id),
                equipment_id INTEGER NOT NULL REFERENCES equipment(id),
                start_date TEXT NOT NULL,
                end_date TEXT NOT NULL CHECK (end_date > start_date),
                state TEXT NOT NULL CHECK (state IN ('Held', 'Released'))
            );
            CREATE INDEX IF NOT EXISTS ix_allocations_equipment_dates
                ON allocations(equipment_id, state, start_date, end_date);
            CREATE TABLE IF NOT EXISTS seed_history (version INTEGER PRIMARY KEY);
            """;
        command.ExecuteNonQuery();
        command.CommandText = "SELECT COUNT(*) FROM seed_history WHERE version = 1;";
        if (Convert.ToInt32(command.ExecuteScalar()) == 0)
        {
            command.CommandText = """
                INSERT INTO equipment VALUES
                    (1, 'Thermal camera', 'Inspection', 'Cabinet A / 01', 0),
                    (2, 'Laser level', 'Survey', 'Cabinet A / 02', 0),
                    (3, 'Inspection tablet', 'Field computing', 'Charging bay / 03', 0),
                    (4, 'Moisture meter', 'Inspection', 'Service bench / 04', 1);
                INSERT INTO employees VALUES
                    (1, 'Alex Morgan', 'Field operations'),
                    (2, 'Sam Rivera', 'Facilities'),
                    (3, 'Taylor Chen', 'Quality');
                INSERT INTO reservations VALUES
                    (1001, 1, 1, '2030-10-10', '2030-10-12', 'Confirmed'),
                    (1002, 2, 2, '2030-10-10', '2030-10-12', 'Cancelled');
                INSERT INTO allocations VALUES
                    (1001, 1, '2030-10-10', '2030-10-12', 'Held'),
                    (1002, 2, '2030-10-10', '2030-10-12', 'Held');
                INSERT INTO seed_history VALUES (1);
                """;
            command.ExecuteNonQuery();
        }

        transaction.Commit();
    }
}
