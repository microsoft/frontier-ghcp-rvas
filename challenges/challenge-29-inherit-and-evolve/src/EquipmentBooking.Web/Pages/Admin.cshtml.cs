using EquipmentBooking.Web.Data;
using EquipmentBooking.Web.Domain;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace EquipmentBooking.Web.Pages;

public sealed class AdminModel(CatalogStore catalog) : PageModel
{
    public IReadOnlyList<Equipment> Equipment { get; private set; } = [];
    public void OnGet() => Equipment = catalog.ListEquipment();

    public IActionResult OnPostMaintenance(int id, bool? isUnderMaintenance)
    {
        try
        {
            if (!ModelState.IsValid || isUnderMaintenance is null)
            {
                throw new BookingException(400, "Choose whether the equipment needs maintenance.");
            }

            var equipment = catalog.SetMaintenance(id, isUnderMaintenance.Value);
            TempData["Notice"] = equipment.IsUnderMaintenance
                ? $"{equipment.Name} marked for maintenance."
                : $"{equipment.Name} returned to service.";
            return RedirectToPage();
        }
        catch (BookingException exception)
        {
            ModelState.AddModelError(string.Empty, exception.Message);
            Response.StatusCode = exception.StatusCode;
            Equipment = catalog.ListEquipment();
            return Page();
        }
    }
}
