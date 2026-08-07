import { developerProfiles } from "./catalog.js";
import type {
  DeveloperProfile,
  ListProfilesOptions,
  SetupPlan,
  Shell
} from "./types.js";

export function listProfiles(
  options: ListProfilesOptions = {}
): DeveloperProfile[] {
  const profiles = options.audience
    ? developerProfiles.filter(
        (profile) => profile.audience === options.audience
      )
    : developerProfiles;

  return profiles.map(copyProfile);
}

export function getProfile(id: string): DeveloperProfile | undefined {
  const profile = developerProfiles.find((candidate) => candidate.id === id);
  return profile ? copyProfile(profile) : undefined;
}

export function createSetupPlan(
  id: string,
  shell: Shell = "bash"
): SetupPlan {
  const profile = getProfile(id);
  if (!profile) {
    throw new Error(`Unknown profile: ${id}`);
  }

  const commands =
    shell === "powershell"
      ? profile.setupSteps.map(toPowerShell)
      : [...profile.setupSteps];

  return { profile, shell, commands };
}

function copyProfile(profile: DeveloperProfile): DeveloperProfile {
  return {
    ...profile,
    tools: [...profile.tools],
    setupSteps: [...profile.setupSteps]
  };
}

function toPowerShell(command: string): string {
  if (command === "corepack enable") {
    return "corepack enable";
  }

  return `& ${command}`;
}
