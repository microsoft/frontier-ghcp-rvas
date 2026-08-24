import { readdir, readFile } from "node:fs/promises";
import path from "node:path";
import { parse } from "yaml";

export async function findFiles(directory, extensions) {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...await findFiles(entryPath, extensions));
    } else if (extensions.includes(path.extname(entry.name).toLowerCase())) {
      files.push(entryPath);
    }
  }

  return files.sort();
}

export async function loadYaml(filePath) {
  return parse(await readFile(filePath, "utf8"));
}
