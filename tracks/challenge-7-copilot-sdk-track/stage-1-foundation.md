# Stage 1: Foundation

**Estimated:** 2-3 hours

In this stage you start by researching the SDK and building an accurate instructions file, then set up the SDK, get a working streaming connection, and build the first piece of domain logic: accepting a repository and reference point, then confirming the release scope with the user.

## Tasks

Before you research the SDK, use the full trio: keep your repository instructions open as the baseline you're building toward, bring in the SDK Pairing agent you create locally to help design tool schemas, and run your SDK research skill to turn what you find into that instructions file. That pairing agent helps you build ship-it -- it is not ship-it itself, which is the release notes agent your code creates and runs through the SDK at runtime.

1. **Research the SDK and build your instructions file**
    - Open Copilot Chat and use the `/research` slash command to pull current documentation, API references, and known issues for `@github/copilot-sdk`
    - Cover at minimum: `CopilotClient` initialization and options, session lifecycle, all streaming event types, custom tool schema format, the JSON-RPC communication model between the SDK and Copilot CLI, and any known caveats or version-specific changes
    - Save the output as a document in the project (e.g., `docs/sdk-research.md`)
    - Turn that document into a Copilot instructions file (`.github/copilot-instructions.md` or a scoped `.instructions.md`) so every subsequent Copilot interaction has accurate SDK context baked in
    - The SDK is recent and moves fast; training data lags real-world releases, so skipping this step means risking time lost chasing APIs that changed or never existed

2. **Client setup and first message**
    - Install the SDK: `npm install @github/copilot-sdk tsx`
    - Make sure you have run `gh auth login` before starting -- the SDK uses GitHub CLI credentials by default (`useLoggedInUser: true`). Without this, session creation will fail with "Session was not created with authentication info or custom provider". If you can't use `gh auth login`, pass a `GITHUB_TOKEN` explicitly: `new CopilotClient({ githubToken: process.env.GITHUB_TOKEN })`
    - Create a `CopilotClient` and verify it can connect to the Copilot CLI backend
    - Create a session with `client.createSession({ model: "gpt-4.1" })`
    - Send a simple prompt using `session.sendAndWait()` and print the response
    - Confirm the full round-trip works: prompt in, response out

3. **Streaming responses**
    - Enable streaming by passing `streaming: true` to `createSession()`
    - Subscribe to `assistant.message_delta` events to print response chunks as they arrive
    - Subscribe to `session.idle` to detect when the response is complete
    - Experiment with `session.on()` to observe other event types the SDK emits
    - Build an interactive loop that reads user input from stdin and streams each response

4. **Release scope confirmation**
    - Accept CLI arguments for the target repository (`--repo owner/name`) and a "since" reference (`--since v2.3.0`, a date, or a commit SHA)
    - On startup, have the agent confirm the scope with the user: "I'll analyze changes between v2.3.0 and HEAD for contoso/backend-api. Ready?"
    - Handle multi-turn follow-up so the user can adjust ("Actually, use v2.2.0 as the base") before the agent proceeds
    - Implement clean shutdown: call `client.stop()` and `process.exit(0)` when the user types "exit"
    - Handle errors from the SDK (invalid model, authentication failure) and display clear messages

## Verification

- A `docs/sdk-research.md` (or equivalent) exists and a Copilot instructions file references it or contains its content
- Running `npx tsx index.ts --repo owner/name --since v1.0.0` starts the agent and streams a scope confirmation message
- The agent responds to follow-up messages in the same session, retaining context across turns
- Typing "exit" shuts down cleanly without errors

---

Previous: [Stages](stages.md) | Next: [Stage 2: Core Features](stage-2-core-features.md)
