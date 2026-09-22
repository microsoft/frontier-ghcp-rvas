export interface DemoUser {
  id: string;
  name: string;
  role: "employee" | "manager";
}

export interface ServiceRequest {
  id: string;
  title: string;
  description: string;
  costCents: number;
  requesterId: string;
  status: "draft" | "submitted";
}

export const demoUsers: readonly DemoUser[] = [
  { id: "employee-1", name: "Alex", role: "employee" },
  { id: "employee-2", name: "Sam", role: "employee" },
  { id: "manager-1", name: "Morgan", role: "manager" },
  { id: "manager-2", name: "Riley", role: "manager" },
  { id: "manager-3", name: "Casey", role: "manager" },
];

export class RequestError extends Error {
  constructor(public readonly status: number, message: string) {
    super(message);
  }
}

export class RequestStore {
  private readonly requests = new Map<string, ServiceRequest>();
  private nextId = 4;

  constructor() {
    const seeds: ServiceRequest[] = [
      {
        id: "SR-001",
        title: "Replacement monitor",
        description: "Replace a flickering monitor at the shared desk.",
        costCents: 24900,
        requesterId: "employee-1",
        status: "draft",
      },
      {
        id: "SR-002",
        title: "Workshop equipment",
        description: "Equipment for the internal training room.",
        costCents: 125000,
        requesterId: "employee-2",
        status: "submitted",
      },
      {
        id: "SR-003",
        title: "Meeting room repair",
        description: "Replace the damaged conference speaker.",
        costCents: 100000,
        requesterId: "manager-1",
        status: "submitted",
      },
    ];
    for (const request of seeds) this.requests.set(request.id, request);
  }

  list(): ServiceRequest[] {
    return [...this.requests.values()].map((request) => ({ ...request }));
  }

  get(id: string): ServiceRequest {
    const request = this.requests.get(id);
    if (!request) throw new RequestError(404, "Request not found.");
    return { ...request };
  }

  create(
    requesterId: string,
    input: { title: string; description: string; costCents: number },
  ): ServiceRequest {
    const request: ServiceRequest = {
      ...input,
      id: `SR-${String(this.nextId++).padStart(3, "0")}`,
      requesterId,
      status: "draft",
    };
    this.requests.set(request.id, request);
    return { ...request };
  }

  submit(id: string, actorId: string): ServiceRequest {
    const request = this.get(id);
    if (request.requesterId !== actorId) {
      throw new RequestError(403, "Only the requester can submit this request.");
    }
    if (request.status !== "draft") {
      throw new RequestError(409, "Only a draft can be submitted.");
    }
    request.status = "submitted";
    this.requests.set(id, request);
    return { ...request };
  }
}
