// Meridian Savings Bank -- Console Client
// Demonstrates all three WCF service contracts via BasicHttpBinding.
// Run the service first: dotnet run --project ../Meridian.Banking.Service

using System.ServiceModel;

const string ServiceBase = "http://localhost:5000";

Console.WriteLine("=== Meridian Savings Bank -- WCF Client Demo ===");
Console.WriteLine();

// -- AccountService --
var accountBinding = new BasicHttpBinding();
var accountAddress = new EndpointAddress($"{ServiceBase}/AccountService");
// NOTE: In a real client you would use a generated proxy or ChannelFactory<IAccountService>.
// The service contracts are defined in the server project.
// For this demo, we use raw HTTP to show the SOAP structure.
using var httpClient = new HttpClient();

Console.WriteLine("Fetching customer profile for ID 1001...");
var soapRequest = """
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
                   xmlns:tns="http://meridian.banking.service/2024/01">
        <soap:Body>
            <tns:GetCustomerProfile>
                <tns:customerId>1001</tns:customerId>
            </tns:GetCustomerProfile>
        </soap:Body>
    </soap:Envelope>
    """;

var content = new StringContent(soapRequest, System.Text.Encoding.UTF8, "text/xml");
content.Headers.Add("SOAPAction", "http://meridian.banking.service/2024/01/IAccountService/GetCustomerProfile");

try
{
    var response = await httpClient.PostAsync($"{ServiceBase}/AccountService", content);
    var body = await response.Content.ReadAsStringAsync();
    Console.WriteLine($"HTTP {(int)response.StatusCode}");
    Console.WriteLine(body[..Math.Min(500, body.Length)]);
}
catch (HttpRequestException ex)
{
    Console.WriteLine($"Could not connect to service: {ex.Message}");
    Console.WriteLine("Make sure the service is running: dotnet run --project src/Meridian.Banking.Service");
}

Console.WriteLine();
Console.WriteLine("To explore all operations, start the service and use the REST Client extension");
Console.WriteLine("or any SOAP client (e.g., Postman, SoapUI) pointed at:");
Console.WriteLine($"  {ServiceBase}/AccountService");
Console.WriteLine($"  {ServiceBase}/LoanService");
Console.WriteLine($"  {ServiceBase}/TransactionService");
