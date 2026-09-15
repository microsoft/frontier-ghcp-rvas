using AngleSharp.Html.Parser;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;

namespace EquipmentBooking.Tests;

public sealed class BookingApplication(string databasePath) : WebApplicationFactory<Program>
{
    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.UseEnvironment("Testing");
        builder.UseSetting("Booking:DatabasePath", databasePath);
    }

    public HttpClient Browser() => CreateClient(new WebApplicationFactoryClientOptions
    {
        AllowAutoRedirect = false
    });

    public static async Task<string> AntiforgeryToken(HttpClient client, string page)
    {
        var response = await client.GetAsync(page);
        response.EnsureSuccessStatusCode();
        var document = await new HtmlParser().ParseDocumentAsync(await response.Content.ReadAsStringAsync());
        var input = document.QuerySelector("input[name='__RequestVerificationToken']");
        Assert.NotNull(input);
        return input.GetAttribute("value")!;
    }
}

public abstract class BookingTest : IDisposable
{
    private readonly string directory = Path.Combine(Path.GetTempPath(), "equipment-booking-tests", Guid.NewGuid().ToString("N"));
    protected string DatabasePath => Path.Combine(directory, "booking.db");
    protected BookingApplication App { get; }
    protected HttpClient Client { get; }

    protected BookingTest()
    {
        App = new BookingApplication(DatabasePath);
        Client = App.Browser();
    }

    public void Dispose()
    {
        Client.Dispose();
        App.Dispose();
        if (Directory.Exists(directory)) Directory.Delete(directory, recursive: true);
        GC.SuppressFinalize(this);
    }
}
