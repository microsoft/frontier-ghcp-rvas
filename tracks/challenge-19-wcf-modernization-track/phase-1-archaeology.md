# Phase 1: Contract Archaeology

[Back to Legacy WCF Banking Modernization Track](../challenge-19-wcf-modernization-track.md)

**Duration:** 2-3 hours

**Focus:** Understanding WCF contracts, mapping service operations, documenting business rules and fault conditions

## Objective

Understand the Meridian Savings Bank WCF service well enough to describe every operation, every data contract, and every fault condition to someone who has never worked with WCF. You start with the service contract interfaces, trace through the implementations, and produce a written inventory that will guide every decision in Phase 3.

## Tasks

1. **Get oriented on WCF fundamentals.** Before reading service code, spend 15-20 minutes getting context. Ask Copilot to explain:
   - What `ServiceContract`, `OperationContract`, `DataContract`, `DataMember`, and `FaultContract` attributes do
   - What `BasicHttpBinding` is and what it controls (transport, encoding, security)
   - How SOAP faults work: when `FaultException<T>` is thrown, what does the SOAP message look like?
   - What `ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)` means for state
   - Create a brief reference document in the challenge folder

2. **Map the service contracts.** Read each interface in `src/Meridian.Banking.Service/Contracts/`. For each service, document every `OperationContract` method:
   - What it does in plain English
   - Its input parameters (name, type, what values are valid)
   - Its return type and what it represents
   - Which `FaultContract` types are declared and under what conditions each fault is thrown
   - Any unusual patterns or legacy conventions in the signature

3. **Extract the data model.** Study all `DataContract` classes in `src/Meridian.Banking.Service/Models/`. For each class:
   - List all `DataMember` properties with types and valid values
   - Note relationships between contracts (e.g., which field is a foreign key to another contract)
   - Identify fields that are status enums masquerading as strings (and what the known values are)
   - Draw a simple entity relationship diagram

4. **Catalog all fault conditions.** `ServiceFault` is the only fault type, but the `ErrorCode` field distinguishes them. For each service operation:
   - List all `ErrorCode` values that can be returned
   - Document the exact condition that triggers each code
   - Decide what HTTP status code each should map to in a REST API -- write down your reasoning

5. **Trace three workflows end-to-end.** Pick three operations and trace from the caller through the service implementation to the data store:
   - A `Deposit` with sufficient funds
   - A `Withdraw` that triggers `INSUFFICIENT_FUNDS`
   - A `GetAmortizationSchedule` -- trace the calculation and verify the formula

6. **Identify technical debt.** The service implementations contain intentional legacy patterns and bugs (some documented in `docs/system-context.md`, some not). Find and document:
   - Validation gaps
   - Non-atomic operations
   - Calculation bugs or approximations
   - Business logic that does not belong in the service layer
   - Hardcoded values that should be configurable
   - Missing error handling

7. **Write a service inventory document.** Create `docs/service-inventory.md` in the challenge folder with:
   - All three service contracts, all operations, all data contracts
   - Fault catalog: each `ErrorCode`, when it occurs, proposed HTTP mapping
   - Business rules discovered in the implementations
   - Technical debt list with severity

## Verification

- [ ] WCF reference document created (ServiceContract, DataContract, FaultContract, BasicHttpBinding, SOAP fault structure)
- [ ] All three service contracts documented with every operation, parameter, return type, and fault
- [ ] Data model extracted: entity diagram plus description of all `DataContract` types
- [ ] Fault catalog complete: every `ErrorCode`, the condition that triggers it, the proposed HTTP status code
- [ ] Three workflows traced end-to-end with data flows, validation steps, and calculations
- [ ] At least five items of technical debt identified and documented
- [ ] Service inventory document written and saved to `docs/service-inventory.md`

---

Next: [Phase 2: Characterization Tests](phase-2-testing.md)
