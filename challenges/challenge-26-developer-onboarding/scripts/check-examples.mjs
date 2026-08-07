import { execFileSync } from "node:child_process";
import { readdirSync, readFileSync, statSync } from "node:fs";
import { extname, join, resolve } from "node:path";

const docsRoot = resolve("docs");
const markdownFiles = walk(docsRoot).filter((file) => extname(file) === ".md");
const failures = [];
let checked = 0;

for (const file of markdownFiles) {
  const content = readFileSync(file, "utf8");
  const examples = content.matchAll(
    /<!-- check-example -->\s*```bash\s*\n([\s\S]*?)```/g
  );

  for (const match of examples) {
    const commands = match[1]
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line.length > 0 && !line.startsWith("#"))
      .map((line) => line.startsWith("$ ") ? line.slice(2) : line);

    for (const command of commands) {
      checked += 1;
      try {
        execFileSync("bash", ["-lc", command], {
          cwd: process.cwd(),
          stdio: "pipe"
        });
      } catch {
        failures.push(`${file}: command failed: ${command}`);
      }
    }
  }
}

if (failures.length > 0) {
  console.error(failures.join("\n"));
  process.exitCode = 1;
} else {
  console.log(`Checked ${checked} tagged command example(s).`);
}

function walk(directory) {
  return readdirSync(directory).flatMap((entry) => {
    const path = join(directory, entry);
    return statSync(path).isDirectory() ? walk(path) : [path];
  });
}
