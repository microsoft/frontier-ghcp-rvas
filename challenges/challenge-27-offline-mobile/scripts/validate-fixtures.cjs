const fs = require("node:fs");
const path = require("node:path");

const fixtureDirectory = path.join(__dirname, "..", "src", "fixtures");
const jobs = JSON.parse(
  fs.readFileSync(path.join(fixtureDirectory, "jobs.json"), "utf8")
);
const networks = JSON.parse(
  fs.readFileSync(path.join(fixtureDirectory, "network.json"), "utf8")
);
const contract = JSON.parse(
  fs.readFileSync(
    path.join(fixtureDirectory, "azure-functions-contract.json"),
    "utf8"
  )
);

const jobIds = new Set(jobs.map((job) => job.id));
if (jobIds.size !== jobs.length || jobs.some((job) => !job.serverVersion)) {
  throw new Error("Job fixtures need unique IDs and positive server versions.");
}

const networkIds = new Set(networks.map((fixture) => fixture.id));
for (const required of ["online", "offline", "flaky", "conflict"]) {
  if (!networkIds.has(required)) {
    throw new Error(`Missing network fixture: ${required}`);
  }
}

if (
  contract.operations.listJobs.path !== "/api/jobs" ||
  contract.operations.syncAction.conflictStatus !== 409
) {
  throw new Error("Azure Functions contract fixture is incomplete.");
}

console.log(
  `Validated ${jobs.length} jobs, ${networks.length} network fixtures, and ${Object.keys(contract.operations).length} contract operations.`
);
