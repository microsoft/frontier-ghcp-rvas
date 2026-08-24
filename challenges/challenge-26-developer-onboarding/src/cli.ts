#!/usr/bin/env node

import { createSetupPlan, getProfile, listProfiles } from "./sdk.js";
import type { Audience, Shell } from "./types.js";

const VERSION = "2.3.0";

export function run(argv: string[]): number {
  if (argv.length === 0 || argv.includes("--help") || argv.includes("-h")) {
    printHelp();
    return 0;
  }

  if (argv.includes("--version") || argv.includes("-v")) {
    console.log(VERSION);
    return 0;
  }

  const [command, action, id] = argv;

  try {
    if (command === "profile" && action === "list") {
      const audience = readOption(argv, "--audience") as Audience | undefined;
      if (audience && audience !== "backend" && audience !== "frontend") {
        return fail("Audience must be backend or frontend.");
      }

      const profiles = listProfiles({ audience });
      if (argv.includes("--json")) {
        console.log(JSON.stringify(profiles, null, 2));
      } else {
        for (const profile of profiles) {
          console.log(`${profile.id}\t${profile.name}\t${profile.audience}`);
        }
      }
      return 0;
    }

    if (command === "profile" && action === "show" && id) {
      const profile = getProfile(id);
      if (!profile) {
        return fail(`Unknown profile: ${id}`);
      }

      if (argv.includes("--json")) {
        console.log(JSON.stringify(profile, null, 2));
      } else {
        console.log(`${profile.name} (${profile.id})`);
        console.log(profile.description);
        console.log(`Tools: ${profile.tools.join(", ")}`);
      }
      return 0;
    }

    if (command === "plan" && action) {
      const shell = (readOption(argv, "--shell") ?? "bash") as Shell;
      if (shell !== "bash" && shell !== "powershell") {
        return fail("Shell must be bash or powershell.");
      }

      const plan = createSetupPlan(action, shell);
      console.log(`# ${plan.profile.name} setup (${plan.shell})`);
      for (const step of plan.commands) {
        console.log(step);
      }
      return 0;
    }
  } catch (error) {
    return fail(error instanceof Error ? error.message : String(error));
  }

  return fail(`Unknown command: ${argv.join(" ")}`);
}

function readOption(argv: string[], name: string): string | undefined {
  const index = argv.indexOf(name);
  return index >= 0 ? argv[index + 1] : undefined;
}

function fail(message: string): number {
  console.error(message);
  console.error("Run launchpad --help for usage.");
  return 1;
}

function printHelp(): void {
  console.log(`Launchpad developer tools ${VERSION}

Usage:
  launchpad profile list [--audience backend|frontend] [--json]
  launchpad profile show <id> [--json]
  launchpad plan <id> [--shell bash|powershell]
  launchpad --version`);
}

if (process.argv[1]?.endsWith("cli.js")) {
  process.exitCode = run(process.argv.slice(2));
}
