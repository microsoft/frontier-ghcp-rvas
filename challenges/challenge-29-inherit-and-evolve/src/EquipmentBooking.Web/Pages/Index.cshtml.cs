using EquipmentBooking.Web.Application;
using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace EquipmentBooking.Web.Pages;

public sealed class IndexModel(CatalogStore catalog, BookingService bookings) : PageModel
{
    public string? Start { get; set; } = "2030-10-10";
    public string? End { get; set; } = "2030-10-12";
    public IReadOnlyList<Equipment> Equipment { get; private set; } = [];
    public Dictionary<int, Availability> Availability { get; } = [];

    public void OnGet(string? start, string? end)
    {
        if (Request.Query.ContainsKey(nameof(Start))) Start = start;
        if (Request.Query.ContainsKey(nameof(End))) End = end;
        Equipment = catalog.ListEquipment();
        try
        {
            BookingRange.Parse(Start, End);
            foreach (var item in Equipment)
            {
                Availability[item.Id] = bookings.CheckAvailability(item.Id, Start, End);
            }
        }
        catch (BookingException exception)
        {
            ModelState.AddModelError(string.Empty, exception.Message);
            Response.StatusCode = exception.StatusCode;
        }
    }
}
