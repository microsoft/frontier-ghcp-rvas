import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, extname, join, resolve } from "node:path";

const docsRoot = resolve("docs");
const markdownFiles = walk(docsRoot).filter((file) => extname(file) === ".md");
const failures = [];
let checked = 0;

for (const file of markdownFiles) {
  const content = readFileSync(file, "utf8");
  const links = content.matchAll(/(?<!!)\[[^\]]+\]\(([^)]+)\)/g);

  for (const match of links) {
    const destination = match[1].trim();
    if (
      destination.startsWith("http://") ||
      destination.startsWith("https://") ||
      destination.startsWith("mailto:") ||
      destination.startsWith("#")
    ) {
      continue;
    }

    checked += 1;
    const filePart = destination.split("#", 1)[0];
    const target = resolve(dirname(file), decodeURIComponent(filePart));
    if (!existsSync(target)) {
      failures.push(`${file}: missing ${destination}`);
    }
  }
}

if (failures.length > 0) {
  console.error(failures.join("\n"));
  process.exitCode = 1;
} else {
  console.log(`Checked ${checked} local links across ${markdownFiles.length} files.`);
}

function walk(directory) {
  return readdirSync(directory).flatMap((entry) => {
    const path = join(directory, entry);
    return statSync(path).isDirectory() ? walk(path) : [path];
  });
}
