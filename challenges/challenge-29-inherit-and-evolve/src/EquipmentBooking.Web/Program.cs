using EquipmentBooking.Web.Api;
using EquipmentBooking.Web.Application;
using EquipmentBooking.Web.Data;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddRazorPages();
builder.Services.AddProblemDetails();
builder.Services.Configure<RouteHandlerOptions>(options => options.ThrowOnBadRequest = false);
builder.Services.AddSingleton<BookingDatabase>();
builder.Services.AddScoped<CatalogStore>();
builder.Services.AddScoped<ReservationStore>();
builder.Services.AddScoped<AllocationStore>();
builder.Services.AddScoped<AvailabilityPolicy>();
builder.Services.AddScoped<BookingService>();

var app = builder.Build();
app.Services.GetRequiredService<BookingDatabase>().Initialize();
app.UseExceptionHandler(error => error.Run(async context =>
{
    context.Response.StatusCode = 500;
    if (context.Request.Path.StartsWithSegments("/api"))
    {
        await Results.Problem(statusCode: 500, title: "The booking desk could not complete that request.")
            .ExecuteAsync(context);
    }
    else
    {
        context.Response.ContentType = "text/html";
        await context.Response.WriteAsync("""
            <!doctype html><html lang="en"><meta charset="utf-8"><title>Booking desk error</title>
            <h1>We could not complete that request.</h1><p>Try again. If it keeps happening, check the application log.</p>
            <a href="/">Return to the equipment desk</a></html>
            """);
    }
}));
app.UseStatusCodePages();
app.UseStaticFiles();
app.MapRazorPages();
app.MapBookingApi();
app.MapGet("/health", (BookingDatabase database) =>
{
    using var connection = database.Open();
    using var command = connection.CreateCommand();
    command.CommandText = "SELECT COUNT(*) FROM equipment;";
    command.ExecuteScalar();
    return Results.Ok(new { status = "healthy" });
});
app.Run();

public partial class Program;
