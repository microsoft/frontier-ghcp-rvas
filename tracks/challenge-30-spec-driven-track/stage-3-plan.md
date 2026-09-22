# Stage 3: Plan Against the Existing App

**Duration:** 45 minutes

## Tasks

1. **Use `/speckit-plan` against the reviewed specification.** Give Copilot the
   existing application path and stack. Inspect how it proposes to extend the
   store and HTTP routes. The browser UI already works; keep it.

2. **Review the technical decisions.** Check where the server will enforce
   actor rules and state transitions. Decide how decision history will be
   represented and displayed. Keep costs in integer cents. Reject changes to
   unrelated parts of the application.

3. **Use `/speckit-tasks`.** Check that the tasks include API and UI work.
   Require automated tests for the acceptance scenarios, including forbidden
   operations and preserved baseline behavior. Tests are part of the work
   breakdown, even if the generated task list omits them initially.

4. **Use `/speckit-analyze` before implementation.** Review consistency across
   the specification, plan, and tasks. Resolve material gaps at their source,
   then repeat analysis. A clean report is not proof that a business decision
   is correct; compare it with the brief yourself.

5. **Agree the implementation boundary.** Keep generated feature artifacts in
   the root `specs/` directory and application changes in the starter. Review
   the current feature recorded by Spec Kit before continuing. Do not create
   a second project or assume switching Git branches changes the active
   Spec Kit feature.

## Verification

- The plan extends the existing application without introducing another stack.
- Tasks cover the complete approval flow, including the browser UI and tests.
- Required acceptance scenarios have an identified test or manual check.
- No unresolved specification/plan/task contradiction blocks implementation.

---

Previous: [Stage 2: Specify the Approval Feature](stage-2-specification.md) | Next: [Stage 4: Implement and Verify](stage-4-implementation.md)
