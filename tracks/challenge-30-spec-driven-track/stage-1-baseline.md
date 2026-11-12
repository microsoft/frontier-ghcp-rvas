# Stage 1: Establish the baseline

**Duration:** 30 minutes

## Tasks

1. **Prepare a disposable workspace.** If you opened the challenge's
   devcontainer, its setup has already run. Do not repeat cleanup. For native
   Linux or macOS, run the following from the repository root with Bash 4+,
   Node.js 22, and Python 3.12 available:

   ```bash
   bash .devcontainer/challenge-30-spec-driven/setup.sh
   ```

   Setup installs Chromium and may ask permission to install its operating
   system dependencies. On Windows, use the devcontainer.

2. **Check the tool versions.** The devcontainer adds the challenge's tools to
   `PATH`. For a native terminal, first add them explicitly:

   ```bash
   export PATH="$PWD/challenges/challenge-30-spec-driven/.tools/python/bin:$PWD/challenges/challenge-30-spec-driven/.tools/copilot/node_modules/.bin:$PATH"
   ```

   Then check:

   ```bash
   node --version
   specify version
   copilot --version
   ```

   Expect Node.js 22, Spec Kit 1.0.9, and Copilot CLI 1.0.88-1. If another
   version appears, check `PATH` before continuing. The Spec Kit package includes
   its matching templates. Don't replace the pin with an unversioned install.

3. **Run the baseline.** From the repository root:

   ```bash
   npm --prefix challenges/challenge-30-spec-driven test
   npm --prefix challenges/challenge-30-spec-driven run test:ui
   npm --prefix challenges/challenge-30-spec-driven start
   ```

   Open `http://localhost:5080`. In a devcontainer, use the forwarded port and
   keep its visibility private. Native startup binds to `127.0.0.1`; the
   devcontainer sets `HOST=0.0.0.0` for forwarding.

   Create a draft as Alex, submit it, then switch identities. Notice which
   actions disappear. The server also checks who may submit; hiding a button
   isn't enough. While an operation runs, the UI disables refresh and request
   changes so responses can't overwrite newer state. Controls come back when it
   finishes, including after a server error. Stop the app with Ctrl+C.
   Restarting discards all changes and restores the seeded requests.

4. **Inspect the small application.** Read `src/requests.ts`, `src/app.ts`,
   and the tests inside the starter. Follow how `public/app.js` calls the API.
   Record existing behavior worth preserving. All costs use integer USD cents.
   The demo identity header is not authentication.

5. **Initialize Spec Kit after cleanup.** Stop the app while reviewing files.
   Check `git status` and commit the prepared workspace as a baseline. Keep
   credentials and local tool installations out of Git. From the
   repository root:

   ```bash
   specify init --here --force --integration copilot --script sh --non-interactive
   ```

   `--force` merges into a non-empty directory and may overwrite conflicting
   managed files, so review the diff. Expect `.specify/` and skills under
   `.github/skills/speckit-*/`. This doesn't touch application code. Don't rerun
   forced initialization to update your feature specification.

6. **Start Copilot CLI at the same root.**

   ```bash
   copilot
   ```

   Sign in when prompted, then use `/skills` to inspect the installed skills.
   If the session predates initialization, restart it. Use the hyphenated skill
   names, not the older dotted command names.

   Invoke `/speckit-constitution` with principles you can justify from this
   starter and the local exercise boundary. Keep them short. Preserve baseline
   behavior and require executable acceptance evidence. Review the result
   before starting the feature, and write your own project-context
   instructions as described in the overview.

## Verification

- The app runs, and a draft can be created and submitted through the browser.
- Baseline API and browser tests pass before feature work starts.
- Spec Kit 1.0.9 and Copilot CLI 1.0.88-1 are on the active path.
- Copilot CLI discovers the generated Spec Kit skills from the repository root.
- The reviewed constitution contains relevant constraints, not invented
  architecture rules.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Specify the Approval Feature](stage-2-specification.md)
