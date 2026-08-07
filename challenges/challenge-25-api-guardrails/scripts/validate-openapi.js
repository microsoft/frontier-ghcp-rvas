import path from "node:path";
import process from "node:process";
import validatorPackage from "openapi-schema-validator";
import { findFiles, loadYaml } from "./lib/files.js";

const OpenAPISchemaValidator = validatorPackage.default;
const root = process.cwd();
const requestedDirectory = process.argv[2] ?? "contracts";
const directory = path.resolve(root, requestedDirectory);
const files = await findFiles(directory, [".yaml", ".yml"]);

if (files.length === 0) {
  throw new Error(`No OpenAPI files found under ${requestedDirectory}`);
}

for (const file of files) {
  const document = await loadYaml(file);
  if (!document?.openapi) {
    throw new Error(`${path.relative(root, file)} is YAML but is not an OpenAPI document`);
  }
  const validator = new OpenAPISchemaValidator({
    version: 3
  });
  const result = validator.validate(document);
  if (result.errors.length > 0) {
    throw new Error(`${path.relative(root, file)}:\n${JSON.stringify(result.errors, null, 2)}`);
  }
  console.log(`Valid OpenAPI: ${path.relative(root, file)}`);
}

console.log(`Validated ${files.length} OpenAPI contracts.`);
