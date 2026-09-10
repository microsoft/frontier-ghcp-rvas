using System.Globalization;

namespace EquipmentBooking.Web.Domain;

public sealed record Equipment(int Id, string Name, string Category, string Location, bool IsUnderMaintenance);
public sealed record Employee(int Id, string Name, string Department);
public sealed record Reservation(
    int Id, int EquipmentId, string EquipmentName, int EmployeeId, string EmployeeName,
    DateOnly Start, DateOnly End, string Status);
public sealed record Availability(int EquipmentId, DateOnly Start, DateOnly End, bool IsAvailable, string Reason);
public sealed record BookingRequest(int EquipmentId, int EmployeeId, string? Start, string? End);
public sealed record MaintenanceRequest(bool? IsUnderMaintenance);

public sealed class BookingException(int statusCode, string message) : Exception(message)
{
    public int StatusCode { get; } = statusCode;
}

public readonly record struct BookingRange(DateOnly Start, DateOnly End)
{
    public static BookingRange Parse(string? start, string? end)
    {
        if (!DateOnly.TryParseExact(start, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                DateTimeStyles.None, out var first)
            || !DateOnly.TryParseExact(end, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                DateTimeStyles.None, out var last))
        {
            throw new BookingException(400, "Enter both dates in YYYY-MM-DD format.");
        }

        if (last <= first)
        {
            throw new BookingException(400, "The return date must be after the pickup date.");
        }

        return new BookingRange(first, last);
    }

    public static string Format(DateOnly date) => date.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
}
