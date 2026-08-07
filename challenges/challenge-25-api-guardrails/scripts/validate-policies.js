import { readFile } from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { XMLParser, XMLValidator } from "fast-xml-parser";
import { findFiles } from "./lib/files.js";

const root = process.cwd();
const requestedDirectory = process.argv[2] ?? "policies";
const directory = path.resolve(root, requestedDirectory);
const files = await findFiles(directory, [".xml"]);
const parser = new XMLParser({
  ignoreAttributes: false
});
const requiredSections = ["inbound", "backend", "outbound", "on-error"];

if (files.length === 0) {
  throw new Error(`No XML policies found under ${requestedDirectory}`);
}

for (const file of files) {
  const source = await readFile(file, "utf8");
  const validation = XMLValidator.validate(source);
  if (validation !== true) {
    throw new Error(`${path.relative(root, file)}: ${validation.err.msg}`);
  }

  const parsed = parser.parse(source);
  if (!parsed.policies) {
    throw new Error(`${path.relative(root, file)} must use <policies> as its root element`);
  }
  for (const section of requiredSections) {
    if (!(section in parsed.policies)) {
      throw new Error(`${path.relative(root, file)} is missing <${section}>`);
    }
  }

  console.log(`Valid APIM policy XML: ${path.relative(root, file)}`);
}

console.log(`Validated ${files.length} Azure API Management policy files.`);
