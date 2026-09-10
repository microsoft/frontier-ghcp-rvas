using EquipmentBooking.Web.Application;
using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace EquipmentBooking.Web.Pages;

public sealed class ReservationsModel(CatalogStore catalog, ReservationStore reservations, BookingService bookings) : PageModel
{
    [BindProperty(SupportsGet = true)]
    public int EquipmentId { get; set; } = 3;
    [BindProperty]
    public int EmployeeId { get; set; } = 1;
    [BindProperty(SupportsGet = true)]
    public string? Start { get; set; } = "2030-10-10";
    [BindProperty(SupportsGet = true)]
    public string? End { get; set; } = "2030-10-12";
    public IReadOnlyList<Equipment> Equipment { get; private set; } = [];
    public IReadOnlyList<Employee> Employees { get; private set; } = [];
    public IReadOnlyList<Reservation> Reservations { get; private set; } = [];

    public void OnGet() => Load();

    public IActionResult OnPostCreate()
    {
        if (!ModelState.IsValid) return InvalidForm();
        try
        {
            var reservation = bookings.Create(new BookingRequest(EquipmentId, EmployeeId, Start, End));
            TempData["Notice"] = $"Reservation #{reservation.Id} confirmed for {reservation.EquipmentName}.";
            return RedirectToPage();
        }
        catch (BookingException exception)
        {
            return InvalidForm(exception);
        }
    }

    public IActionResult OnPostCancel(int id)
    {
        if (!ModelState.IsValid) return InvalidForm();
        try
        {
            var reservation = bookings.Cancel(id);
            TempData["Notice"] = $"Reservation #{reservation.Id} cancelled.";
            return RedirectToPage();
        }
        catch (BookingException exception)
        {
            return InvalidForm(exception);
        }
    }

    private IActionResult InvalidForm(BookingException? exception = null)
    {
        if (exception is not null) ModelState.AddModelError(string.Empty, exception.Message);
        Response.StatusCode = exception?.StatusCode ?? 400;
        Load();
        return Page();
    }

    private void Load()
    {
        Equipment = catalog.ListEquipment();
        Employees = catalog.ListEmployees();
        Reservations = reservations.List();
    }
}
