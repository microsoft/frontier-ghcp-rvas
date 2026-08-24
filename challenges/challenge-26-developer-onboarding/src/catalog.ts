import type { DeveloperProfile } from "./types.js";

export const developerProfiles: DeveloperProfile[] = [
  {
    id: "api",
    name: "API developer",
    audience: "backend",
    description: "Node.js services, contract tests, and local API debugging.",
    tools: ["Node.js 22", "GitHub CLI", "Docker"],
    setupSteps: [
      "corepack enable",
      "npm install",
      "npm test"
    ]
  },
  {
    id: "web",
    name: "Web developer",
    audience: "frontend",
    description: "TypeScript web applications and component testing.",
    tools: ["Node.js 22", "GitHub CLI"],
    setupSteps: [
      "corepack enable",
      "npm install",
      "npm run build"
    ]
  }
];
