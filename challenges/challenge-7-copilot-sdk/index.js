// ship-it: Release Notes Agent - Copilot SDK Application
// GitHub Copilot Adoption - Challenge 7
//
// This application uses the GitHub Copilot SDK to build an interactive agent that:
// - Fetches merged PRs between two git refs (tag, date, or commit SHA)
// - Categorizes changes into features, fixes, breaking changes, etc.
// - Generates a structured changelog through conversation
// - Publishes a draft GitHub Release when the user is satisfied

import { CopilotClient } from "@github/copilot-sdk";
import * as readline from "readline";

// TODO: Parse CLI arguments for --repo and --since
// Example: npx tsx index.ts --repo contoso/backend-api --since v2.3.0
const args = process.argv.slice(2);
const repoArg = args.find((_, i) => args[i - 1] === "--repo") || "";
const sinceArg = args.find((_, i) => args[i - 1] === "--since") || "";

const client = new CopilotClient();

const session = await client.createSession({
  model: "gpt-4.1",
  streaming: true,
});

// TODO: Define custom tools for the session
// The SDK lets you register tools that the model can call.
// Start with a PR-fetching tool, then add categorization and publishing tools.
//
// Example tool definition:
// {
//   name: "get_merged_prs",
//   description: "Fetch pull requests merged since a given tag, date, or commit SHA",
//   parameters: {
//     type: "object",
//     properties: {
//       owner: { type: "string", description: "Repository owner" },
//       repo: { type: "string", description: "Repository name" },
//       since: { type: "string", description: "Tag name, date, or commit SHA to start from" },
//     },
//     required: ["owner", "repo", "since"],
//   },
// }

// Stream response chunks to stdout as they arrive
session.on("assistant.message_delta", (event) => {
  process.stdout.write(event.data.deltaContent);
});
session.on("session.idle", () => {
  console.log(); // newline after response
});

// Interactive prompt loop
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

console.log("ship-it: Release Notes Agent (Copilot SDK)");
if (repoArg && sinceArg) {
  console.log(`Target: ${repoArg} since ${sinceArg}`);
}
console.log("Describe your release, or type 'exit' to quit.\n");

// Send initial scope confirmation if args are provided
if (repoArg && sinceArg) {
  await session.sendAndWait({
    prompt: `I want to generate release notes for ${repoArg} covering all changes since ${sinceArg}. Confirm the scope and ask me if I'm ready to proceed.`,
  });
}

function ask() {
  rl.question("> ", async (input) => {
    const trimmed = input.trim();
    if (trimmed.toLowerCase() === "exit") {
      await client.stop();
      rl.close();
      process.exit(0);
    }
    if (!trimmed) {
      ask();
      return;
    }
    await session.sendAndWait({ prompt: trimmed });
    ask();
  });
}

ask();
