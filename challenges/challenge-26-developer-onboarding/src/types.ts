export type Audience = "backend" | "frontend";
export type Shell = "bash" | "powershell";

export interface DeveloperProfile {
  id: string;
  name: string;
  audience: Audience;
  description: string;
  tools: string[];
  setupSteps: string[];
}

export interface ListProfilesOptions {
  audience?: Audience;
}

export interface SetupPlan {
  profile: DeveloperProfile;
  shell: Shell;
  commands: string[];
}
