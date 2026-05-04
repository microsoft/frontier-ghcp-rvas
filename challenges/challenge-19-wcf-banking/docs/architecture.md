# WCF Architecture Reference

A quick reference for WCF concepts you will encounter in this codebase. Read this alongside the service contract files.

## WCF Building Blocks

**ServiceContract** -- An interface decorated with `[ServiceContract]` defines the SOAP service. The `Namespace` parameter sets the XML namespace used in SOAP messages. The `Name` parameter sets the WSDL port type name.

**OperationContract** -- A method on a service contract interface. Each method decorated with `[OperationContract]` becomes a SOAP operation. The method signature defines the SOAP message structure -- inputs become the request, the return value becomes the response.

**DataContract** -- A class decorated with `[DataContract]` is serialized as XML in SOAP messages. Only members decorated with `[DataMember]` are included. Order of members in SOAP can be controlled with `[DataMember(Order = N)]`.

**FaultContract** -- Declares that an operation can return a typed SOAP fault. `[FaultContract(typeof(ServiceFault))]` on an operation means the operation can throw `FaultException<ServiceFault>`. Clients that do not receive this declaration cannot deserialize the fault.

**ServiceBehavior** -- Controls service instance lifecycle. `InstanceContextMode.Single` means one instance of the service class is shared across all requests (singleton). `InstanceContextMode.PerCall` creates a new instance per request.

## BasicHttpBinding

The binding used by all three services. BasicHttpBinding is the simplest WCF binding:

- Transport: HTTP (no HTTPS in this configuration)
- Message encoding: SOAP 1.1 over text/XML
- Security: None (no transport or message security)
- Session: None (stateless)

This is the binding that interoperates most easily with non-.NET SOAP clients.

## SOAP Message Structure

A SOAP request to `GetCustomerProfile` with `customerId = 1001` looks like:

```xml
POST /AccountService HTTP/1.1
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://meridian.banking.service/2024/01/IAccountService/GetCustomerProfile"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
               xmlns:tns="http://meridian.banking.service/2024/01">
  <soap:Body>
    <tns:GetCustomerProfile>
      <tns:customerId>1001</tns:customerId>
    </tns:GetCustomerProfile>
  </soap:Body>
</soap:Envelope>
```

A SOAP fault response looks like:

```xml
<soap:Envelope ...>
  <soap:Body>
    <soap:Fault>
      <faultcode>soap:Client</faultcode>
      <faultstring>Account not found</faultstring>
      <detail>
        <ServiceFault xmlns="http://meridian.banking.service/2024/01">
          <ErrorCode>ACCOUNT_NOT_FOUND</ErrorCode>
          <Message>Account CHK-999999 not found.</Message>
          <Timestamp>2024-01-15T10:30:00Z</Timestamp>
        </ServiceFault>
      </detail>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
```

## CoreWCF vs Classic WCF

This service runs on CoreWCF (https://github.com/CoreWCF/CoreWCF) -- an open-source, cross-platform port of WCF to .NET 5+. The programming model is identical to classic WCF (same attributes, same contracts, same binding names). The difference is in the hosting layer: CoreWCF uses ASP.NET Core's Kestrel server instead of WAS/IIS.

Classic WCF required Windows and .NET Framework. CoreWCF runs on Linux and .NET 8, which is why this service works inside a Linux devcontainer.

The service contracts, data contracts, fault contracts, and bindings are identical to what you would find in a .NET Framework 4.8 WCF project from 2012.
