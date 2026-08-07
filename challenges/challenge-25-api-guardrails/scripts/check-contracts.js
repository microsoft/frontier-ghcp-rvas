import { readFile } from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { pathToFileURL } from "node:url";
import { findFiles, loadYaml } from "./lib/files.js";

const httpMethods = ["get", "put", "post", "delete", "options", "head", "patch", "trace"];
const paginationNames = new Set([
  "cursor",
  "limit",
  "offset",
  "page",
  "page_size",
  "nextToken",
  "maxResults"
]);

function resolveLocalRef(document, value) {
  if (!value?.$ref?.startsWith("#/")) {
    return value;
  }

  return value.$ref
    .slice(2)
    .split("/")
    .reduce((current, segment) => current?.[segment.replaceAll("~1", "/").replaceAll("~0", "~")], document);
}

function addFinding(findings, file, location, rule, message) {
  findings.push({ file, location, rule, message });
}

function checkSchemaProperties(schema, pattern, findings, file, location) {
  const resolved = schema ?? {};
  for (const [name, property] of Object.entries(resolved.properties ?? {})) {
    if (!pattern.test(name)) {
      addFinding(findings, file, `${location}.${name}`, "naming.property", `Property '${name}' does not match ${pattern}`);
    }
    checkSchemaProperties(property, pattern, findings, file, `${location}.${name}`);
  }
  if (resolved.items) {
    checkSchemaProperties(resolved.items, pattern, findings, file, `${location}[]`);
  }
}

function operationSecurityTypes(document, operation) {
  const requirements = operation.security ?? document.security ?? [];
  const types = [];
  for (const requirement of requirements) {
    for (const name of Object.keys(requirement)) {
      types.push(document.components?.securitySchemes?.[name]?.type ?? "unknown");
    }
  }
  return types;
}

export function inspectContract(document, file, rules) {
  const findings = [];
  const semver = /^\d+\.\d+\.\d+$/;

  if (rules.versioning.infoVersion === "semver" && !semver.test(document.info?.version ?? "")) {
    addFinding(findings, file, "info.version", "versioning.info", "Version must use major.minor.patch");
  }

  const propertyPattern = new RegExp(rules.naming.propertyPattern);
  for (const [name, schema] of Object.entries(document.components?.schemas ?? {})) {
    checkSchemaProperties(schema, propertyPattern, findings, file, `components.schemas.${name}`);
  }

  for (const [route, pathItem] of Object.entries(document.paths ?? {})) {
    const serverPath = new URL(document.servers?.[0]?.url ?? "http://local").pathname;
    if (!serverPath.startsWith(rules.versioning.pathPrefix) && !route.startsWith(rules.versioning.pathPrefix)) {
      addFinding(findings, file, route, "versioning.path", `Version must begin the server path or route with '${rules.versioning.pathPrefix}'`);
    }

    for (const method of httpMethods) {
      const operation = pathItem[method];
      if (!operation) {
        continue;
      }
      const location = `${method.toUpperCase()} ${route}`;
      const operationIdPattern = new RegExp(rules.naming.operationIdPattern);
      if (!operation.operationId || !operationIdPattern.test(operation.operationId)) {
        addFinding(findings, file, location, "naming.operationId", `operationId must match ${operationIdPattern}`);
      }

      const parameters = [...(pathItem.parameters ?? []), ...(operation.parameters ?? [])];
      for (const parameter of parameters.filter(item => item.in === "query" && paginationNames.has(item.name))) {
        if (!rules.pagination.approvedQueryParameters.includes(parameter.name)) {
          addFinding(findings, file, `${location} parameter ${parameter.name}`, "pagination.query", "Pagination parameter is not in the approved set");
        }
      }

      const headerNames = parameters
        .filter(item => item.in === "header")
        .map(item => item.name.toLowerCase());
      if (!headerNames.includes(rules.observability.correlationHeader.toLowerCase())) {
        addFinding(findings, file, location, "observability.correlation", `Request must accept '${rules.observability.correlationHeader}'`);
      }

      const securityTypes = operationSecurityTypes(document, operation);
      if (securityTypes.length === 0 || securityTypes.some(type => !rules.identity.allowedSecurityTypes.includes(type))) {
        addFinding(findings, file, location, "identity.scheme", `Security scheme must use one of: ${rules.identity.allowedSecurityTypes.join(", ")}`);
      }

      for (const [status, responseValue] of Object.entries(operation.responses ?? {})) {
        if (!/^[45]/.test(status)) {
          continue;
        }
        const response = resolveLocalRef(document, responseValue);
        const media = response?.content?.[rules.errors.mediaType];
        if (!media) {
          addFinding(findings, file, `${location} response ${status}`, "errors.mediaType", `Error must use ${rules.errors.mediaType}`);
          continue;
        }
        const schema = resolveLocalRef(document, media.schema);
        const required = new Set(schema?.required ?? []);
        for (const field of rules.errors.requiredFields) {
          if (!required.has(field)) {
            addFinding(findings, file, `${location} response ${status}`, "errors.fields", `Error schema must require '${field}'`);
          }
        }
      }
    }
  }

  return findings;
}

function optionValue(name, fallback) {
  const index = process.argv.indexOf(name);
  return index >= 0 ? process.argv[index + 1] : fallback;
}

export async function runChecks({
  contractsDirectory = "contracts/source",
  rulesFile = "standards/draft-rules.json"
} = {}) {
  const root = process.cwd();
  const rules = JSON.parse(await readFile(path.resolve(root, rulesFile), "utf8"));
  const files = await findFiles(path.resolve(root, contractsDirectory), [".yaml", ".yml"]);
  const findings = [];

  for (const filePath of files) {
    const file = path.relative(root, filePath);
    findings.push(...inspectContract(await loadYaml(filePath), file, rules));
  }

  return { files, findings };
}

async function main() {
  const contractsDirectory = optionValue("--contracts-dir", "contracts/source");
  const rulesFile = optionValue("--rules", "standards/draft-rules.json");
  const reportOnly = process.argv.includes("--report-only");
  const { files, findings } = await runChecks({ contractsDirectory, rulesFile });

  for (const finding of findings) {
    console.log(`${finding.file}: ${finding.location} [${finding.rule}] ${finding.message}`);
  }
  console.log(`Checked ${files.length} contracts. Found ${findings.length} guardrail violations.`);

  if (findings.length > 0 && !reportOnly) {
    process.exitCode = 1;
  }
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  await main();
}
