# Stage 2: Specify the Approval Feature

**Duration:** 60 minutes

## Tasks

1. **Read the request from operations.**

   > We can submit equipment and service requests, but nobody can record a
   > decision. Add approval and rejection so employees can see what happened.
   > Managers should be able to handle requests from the existing register.
   > Keep the current request flow working.

   This brief deliberately leaves policy questions unanswered. Your job is to
   get those answers before the implementation starts.

2. **Use `/speckit-specify` to describe the feature in your own words.**
   Supply the operations brief and distinguish it from the existing starter
   behavior. Focus on the user outcome. Do not specify a replacement framework
   or ask the agent to implement immediately.

3. **Use `/speckit-clarify` and review its questions.** Confirm the fixed
   boundaries below. Agree the remaining policy choices with your partner or
   facilitator and put the answers in the feature's `spec.md`. If working
   alone, act as the product owner and make explicit choices.

   | Fixed boundary | Expected behavior |
   |----------------|-------------------|
   | Who may decide | A demo manager; never the request's own requester |
   | Eligible requests | Only submitted requests can receive a decision |
   | First version | One eligible approval completes approval, regardless of cost |
   | Repeated decisions | No duplicate or contradictory decision on a completed request |
   | Evidence | Record who decided and the decision; show it in the UI |
   | Existing behavior | Preserve request creation, submission, and demo data reset |
   | Scope | No real authentication, notifications, deployment, or database work |

4. **Resolve the open policies.** Decide whether rejection needs a reason and
   whether a rejected request can be resubmitted. Define what happens to
   previous decision history if resubmission is allowed. Avoid adding editing
   or withdrawal features unless a chosen policy truly needs them.

   **Facilitator guide:** ask participants to explain their policy choice and
   how they would test it. If they need a smaller scope, require a rejection
   reason and make rejection final; the requester can create a new request.
   These are suggested decisions, not hidden grading criteria. Record whichever
   policy is agreed before moving on.

5. **Review the specification.** Write acceptance scenarios for the successful
   decision and for forbidden actors. Include draft requests, missing IDs,
   and repeated decisions. Check that manager-created requests cannot be
   self-approved. Make any API failure expectations observable without
   prematurely prescribing the code structure.

   Use the optional Acceptance Reviewer only if it helps find an actual gap.
   A human must approve the business rules.

## Verification

- The feature specification captures the operations request and all fixed
  boundaries.
- Rejection and resubmission policies are explicit, with no unresolved
  questions that affect implementation.
- Acceptance scenarios cover both permitted and denied actions.
- The feature scope fits the existing app; existing functionality is not
  re-specified as a new application.

---

Previous: [Stage 1: Establish the Baseline](stage-1-baseline.md) | Next: [Stage 3: Plan Against the Existing App](stage-3-plan.md)
