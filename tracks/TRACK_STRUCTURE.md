# Track File Structure

Every track has an overview page under `tracks/`, a contents page in its track
subdirectory, and one file per stage. Tracks with role-specific work
can also have nested role pages. Shared setup content lives in
`tracks/getting-started.md`.

## File Layout

```text
tracks/
  getting-started.md
  challenge-1-web-api-track.md
  challenge-1-web-api-track/
    stages.md
    stage-1-basic-crud.md
    stage-2-auth.md
  challenge-9-team-sprint-track.md
  challenge-9-team-sprint-track/
    stages.md
    stage-1-discovery-planning.md
    stage-1-discovery-planning/
      backend-developer.md
```

Use `stages.md` for every track.

## Overview Page

The overview is the main file at `tracks/<track-name>.md`. Sections marked
**required** must appear in every track. Include sections marked
**if applicable** only when relevant.

```text
1. # Track Title                              (required)
   - Duration, Difficulty, Focus metadata     (required)

2. ## Who Is This For                         (required)
   - Bullet list of target roles

3. ## Prerequisites                           (required)
   - Bullet list of required knowledge

4. ## Technology Stack                        (required)
   - Bullet list of languages, frameworks, tools

5. Track narrative or team guidance           (if applicable)

6. ## Getting Started                         (required)
   - Link to getting-started.md
   - ### Open and Inspect the Challenge
   - ### Repository Instructions for This Track
   - ### Suggested Custom Agents
   - ### Suggested Custom Skills

7. ## Tips for Using Copilot on This Track    (required)

8. ## Resources                               (required)

9. Navigation footer                          (required)
   - Next link to stages.md
```

The overview does not contain the stage summary table, progression
paragraph, short-on-time guidance, or role progression matrices.

## Contents Page

The contents page is `tracks/<track-name>/stages.md`.

```text
1. # Challenge Name: Stages                   (required)

2. ## Stages                                  (required)
   - Summary table with linked names
   - Brief progression paragraph              (if present)
   - "Short on time?" guidance                (if present)

3. ## Follow Your Role                         (if applicable)
   - Role matrices linking to nested pages

4. Navigation footer                           (required)
   - Previous link to the overview
   - Next link to the first stage
```

Links from a contents page to its stage or nested role pages are
relative to the track subdirectory.

## Stage Page

Each top-level stage lives at
`tracks/<track-name>/stage-N-<slug>.md`.

```text
1. # Stage N: Name                             (required)
   - Difficulty and time metadata

2. ## Tasks                                    (required)
   - Early use cue for the customization trio (if applicable)
   - Midpoint refinement cue (if applicable)

3. ## Verification                             (required)

4. ## What Copilot Helps With vs. What Requires Your Judgment
                                                (if applicable)

5. Navigation footer                            (required)
```

Top-level pages navigate numerically across other top-level pages. The first
page links back to the contents page. Intermediate pages link to the previous
and next numeric page. The last page links to the previous page.

## Nested Role Page

Role-specific tasks live at
`tracks/<track-name>/stage-N-<slug>/<role>.md`.

```text
1. # Stage N: Name -- Role Tasks               (required)

2. ## Tasks                                    (required)
   - Early use cue for the role's custom agent (if applicable)
   - Midpoint refinement cue (if applicable)

3. ## Verification                             (required)

4. Navigation footer                            (required)
```

Nested role pages navigate to the same role in the previous or next stage.
The role's first stage links back to `stages.md`. A top-level stage page never
links directly to a nested role page in its footer.

## Navigation Footer Format

Place a horizontal rule before the footer. Use these forms:

```markdown
---

Next: [Stages](challenge-1-web-api-track/stages.md)
```

```markdown
---

Previous: [Track Overview](../challenge-1-web-api-track.md) | Next: [Stage 1: Basic CRUD](stage-1-basic-crud.md)
```

```markdown
---

Previous: [Stage 1: Basic CRUD](stage-1-basic-crud.md) | Next: [Stage 3: Persistent Storage](stage-3-storage.md)
```

## Shared Getting Started File

`tracks/getting-started.md` explains the shared mechanics once:

1. Start from a clean workspace
2. Open and inspect the challenge
3. Draft repository instructions, custom agents, and custom skills
4. Learn from examples, then write original artifacts

This file is the only external Awesome Copilot hub. Track overviews link to it
instead of repeating setup mechanics or external example links.

## Customization Trio

Every overview adds track-specific guidance for three different artifacts:

- **Repository instructions** hold stable project context, conventions, and
  constraints that should apply across the session.
- **Custom agents** provide specialist judgment for a defined role or decision.
- **Custom skills** capture repeatable, multi-step workflows.

List two or three tailored agent briefs and two or three tailored skill briefs.
A brief names the purpose, expected input, useful timing, and boundaries of the
artifact. It must not provide ready-to-paste instructions, agent definitions,
skill files, or prompts. Participants author the artifacts.

Use skills for exercises that produce reusable workflows. Refer to
`.github/skills/<skill-name>/SKILL.md` and reuse a matching skill from setup
before asking participants to create another one. Describe its inputs and
expected results without supplying a completed skill. Ordinary chat examples
can remain; do not require a separate Copilot prompt file for the workflow.

Place early-use cues and midpoint refinement cues in the relevant stage
or nested role page. Keep them inside `## Tasks` or another work section, never
`## Verification`. Verification checks the challenge result, not whether a
participant followed a prescribed customization process.

For team tracks, the team shares repository instructions and at least one
workflow skill. Role pages use tailored custom agents for role-specific
judgment. Do not create separate repository instructions for each role.

In agent-heavy challenges, distinguish a Custom Agent that helps a participant
author or review work from the runtime agent, agent engine, or automated
workflow that the challenge builds or operates.

For BYOC sessions, the facilitator prepares the tailored agent and skill
briefs. Participants use those briefs to author their own artifacts.

Challenge 30 is a narrow exception: participants adopt Spec Kit's supplied
workflow. Keep the required overview subsections, but mark custom agent and
skill briefs as optional. Do not require them to rebuild Spec Kit's workflow.

## Rules

- Do not duplicate content between the overview and contents page.
- Keep verification criteria in each stage file.
- Keep customization use and refinement cues out of `## Verification`.
- Keep one `Getting Started` section in the overview.
- Keep the required Getting Started subsections in this order: `Open and
  Inspect the Challenge`, `Repository Instructions for This Track`, `Suggested
  Custom Agents`, and `Suggested Custom Skills`.
- Link to the challenge folder once, under
  `### Open and Inspect the Challenge`.
- Do not add `Track Overview`, `Learning Outcomes`, or `Recommended Schedule`
  sections.
- Keep tips relevant to the track.
- Use `##` for overview and contents sections and `###` for subsections.
- Use `#` for stage and nested role page titles.
- Link every stage name in the contents table.
- Use the challenge title from `meta.yml` in the contents-page H1:
  `# <Challenge Name>: Stages`.
- Do not include the challenge number or the word `Track` in the contents-page
  H1.
- Keep all external Awesome Copilot links in the shared setup page.
- Do not create README files in challenge folders.

## Outcome Framing

Business outcome framing belongs in the facilitator guide, learning paths, and
website. The overview explains what work gets done and how to execute it.

For customers authoring their own challenges, templates are available under
`byoc/templates/`.

## Writing Style

Follow `.github/copilot-instructions.md`: no emoji in headings, no em dashes,
no hype language, no AI sign-offs, natural phrasing, and markdownlint-compliant
formatting.
