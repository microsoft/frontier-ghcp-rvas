# Repository instructions

Follow [.github/copilot-instructions.md](.github/copilot-instructions.md) for
delivery constraints, track and challenge synchronization, and Markdown formatting.

## Before writing

**Invoke `/humanize-writing` before drafting, editing, or returning repository
prose.** This applies to technical documentation, session kits, runbooks,
Markdown, slide content, and user-facing explanations. The skill's
technical-writing exclusion does not apply here.

Use its `clear-thinker` voice unless the user requests another voice. Load the
skill's voice guidance and AI-pattern dictionary before drafting.

## Drafting

Write for a competent engineer. Lead with the point and include enough detail
for the reader to understand, decide, or act.

- Use ordinary words and concrete verbs. Prefer "validate" to "perform validation".
- Name who does what. Use active voice when the actor matters.
- Keep one main idea per sentence. Split sentences that require rereading.
- Keep explanations that change the reader's understanding or next action.
  Delete repeated points, generic benefits, and introductions that only announce
  what follows.
- Use bold for decisions, warnings, or instructions the reader needs to notice.

Preserve technical facts, Microsoft product names, dates, citations, and
governance terminology exactly.

## Before finishing

1. Review every changed sentence against the drafting rules. Shorten, rewrite,
   or delete sentences that fail them without losing technical meaning.
2. Check every changed passage against the skill's AI-pattern dictionary.
   Revise until both checks pass.
3. For Markdown changes, run `markdownlint` with `.markdownlint.json` and resolve
   violations introduced by the edit.
