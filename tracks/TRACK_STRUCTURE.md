# Track File Structure

Every track has an overview page under `tracks/`, a contents page in its track
subdirectory, and one file per stage or phase. Tracks with role-specific work
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
    phases.md
    phase-1-discovery-planning.md
    phase-1-discovery-planning/
      backend-developer.md
```

Use `stages.md` when the track uses Stage terminology and `phases.md` when it
uses Phase terminology.

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
   - ### Custom Instructions for This Track
   - ### Suggested Agents
   - ### Open the Challenge

7. ## Tips for Using Copilot on This Track    (required)

8. ## Resources                               (required)

9. Navigation footer                          (required)
   - Next link to stages.md or phases.md
```

The overview does not contain the stage or phase summary table, progression
paragraph, short-on-time guidance, or role progression matrices.

## Contents Page

The contents page is `tracks/<track-name>/stages.md` or
`tracks/<track-name>/phases.md`.

```text
1. # Track Title: Stages or Phases             (required)

2. ## Stages or ## Phases                      (required)
   - Summary table with linked names
   - Brief progression paragraph              (if present)
   - "Short on time?" guidance                (if present)

3. ## Follow Your Role                         (if applicable)
   - Role matrices linking to nested pages

4. Navigation footer                           (required)
   - Previous link to the overview
   - Next link to the first stage or phase
```

Links from a contents page to its stage, phase, or nested role pages are
relative to the track subdirectory.

## Stage or Phase Page

Each top-level stage or phase lives at
`tracks/<track-name>/stage-N-<slug>.md` or
`tracks/<track-name>/phase-N-<slug>.md`.

```text
1. # Stage or Phase N: Name                    (required)
   - Difficulty and time metadata

2. ## Tasks                                    (required)

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
`tracks/<track-name>/phase-N-<slug>/<role>.md`.

```text
1. # Phase N: Name -- Role Tasks               (required)

2. ## Tasks                                    (required)

3. ## Verification                             (required)

4. Navigation footer                            (required)
```

Nested role pages navigate to the same role in the previous or next phase.
The role's first phase links back to `phases.md`. A top-level phase page never
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

`tracks/getting-started.md` contains the common setup steps:

1. Clean Start
2. Create Custom Instructions
3. Create Custom Agents
4. Open the Challenge

Each overview links to this shared file and adds track-specific agent and
instruction guidance.

## Rules

- Do not duplicate content between the overview and contents page.
- Keep verification criteria in each stage or phase file.
- Keep one `Getting Started` section in the overview.
- Link to the challenge folder once, under `### Open the Challenge`.
- Do not add `Track Overview`, `Learning Outcomes`, or `Recommended Schedule`
  sections.
- Keep tips relevant to the track.
- Use `##` for overview and contents sections and `###` for subsections.
- Use `#` for stage, phase, and nested role page titles.
- Link every stage and phase name in the contents table.
- Reference `awesome-copilot` once, in the shared setup page.
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
