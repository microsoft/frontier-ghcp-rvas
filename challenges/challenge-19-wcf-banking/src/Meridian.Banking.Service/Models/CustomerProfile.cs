using System.Runtime.Serialization;

namespace Meridian.Banking.Service.Models;

/// <summary>
/// Customer profile containing personal and contact information.
/// Represents a Meridian Savings Bank customer.
/// </summary>
[DataContract(Name = "CustomerProfile", Namespace = "http://meridian.banking.service/2024/01")]
public class CustomerProfile
{
    [DataMember]
    public int CustomerId { get; set; }

    [DataMember]
    public string FirstName { get; set; } = string.Empty;

    [DataMember]
    public string LastName { get; set; } = string.Empty;

    [DataMember]
    public string Email { get; set; } = string.Empty;

    [DataMember]
    public string PhoneNumber { get; set; } = string.Empty;

    /// <summary>Values: Active, Inactive, Suspended.</summary>
    [DataMember]
    public string Status { get; set; } = "Active";

    [DataMember]
    public DateTime CreatedDate { get; set; }
}
