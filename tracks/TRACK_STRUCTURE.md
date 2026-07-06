# Track File Structure

Every track has a **main file** under `tracks/` and a **subdirectory** containing one file per stage/phase. Shared setup content lives in `tracks/getting-started.md`.

## File Layout

```text
tracks/
  getting-started.md                          ← shared setup (clean start, instructions, agents)
  challenge-1-web-api-track.md                  ← main track file (overview, table, tips, resources)
  challenge-1-web-api-track/
    stage-1-basic-crud.md                     ← one file per stage
    stage-2-auth.md
    stage-3-storage.md
    stage-4-advanced.md
    stage-5-production.md
```

## Main Track File: Section Order

Sections marked **(required)** must appear in every track. Sections marked **(if applicable)** should be included only when relevant.

```text
1. # Track Title                              (required)
   - Duration, Difficulty, Focus metadata     (required)

2. ## Who Is This For                         (required)
   - Bullet list of target roles

3. ## Prerequisites                           (required)
   - Bullet list of required knowledge

4. ## Technology Stack                        (required)
   - Bullet list of languages, frameworks, tools

5. ## Getting Started                         (required)
   - Link to getting-started.md
   - ### Custom Instructions for This Track
   - ### Suggested Agents
   - ### Open the Challenge

6. ## Stages                                  (required)
   - Summary table with linked stage names
   - Brief paragraph on progression and judgment
   - Blockquote with "Short on time?" guidance

7. ## Tips for Using Copilot on This Track    (required)
   - Practical prompts and patterns specific to the track

8. ## Resources                               (required)
   - Flat list of links: Copilot Guide, Prompt Engineering, Troubleshooting, Facilitator Guide
```

## Stage File Format

Each stage lives in `tracks/<track-name>/stage-N-<slug>.md`. Some extended tracks still use `phase-N-<slug>.md`.

```text
1. # Stage N: Name
   - Back-link to main track file
   - Difficulty and Time metadata

2. ## Tasks                                   (required)
   - Numbered list

3. ## Verification                            (required)
   - Bullet list of pass criteria

4. ## What Copilot Helps With vs. What Requires Your Judgment
                                              (if applicable)

5. Navigation footer                          (required)
   - Previous / Next links to adjacent stages
```

## Shared Getting Started File

`tracks/getting-started.md` contains the steps common to all tracks:

1. Clean Start (run cleanup script)
2. Create Custom Instructions (general guidance)
3. Create Custom Agents (general guidance + awesome-copilot reference)
4. Open the Challenge (pointer back to track file)

Each main track file links to this shared file and adds track-specific agent suggestions and instruction guidance.

## Rules

- **No duplicate content.** Verification criteria go inside each stage file only, never repeated in the main track file.
- **One "Getting Started" section.** The main track file links to the shared `getting-started.md` and adds track-specific subsections.
- **One challenge link.** Link to the challenge folder once, inside `### Open the Challenge` in Getting Started.
- **No "Track Overview" prose.** The metadata line (Duration / Difficulty / Focus) under the title is sufficient. Drop any paragraph restating the same information.
- **No "Learning Outcomes" section.** The stages and their verification bullets already communicate what the participant will learn. Outcome framing belongs in metadata and the facilitator guide, not as a track-file section.
- **Tips must be track-relevant.** Do not include tips for tools or domains that belong to a different track.
- **Headings in main file:** `##` for top-level sections, `###` for subsections.
- **Headings in stage files:** `#` for stage title, `##` for Tasks/Verification/etc.
- **Stage table links.** Every stage name in the summary table must be a relative link to the stage file.
- **Navigation links.** Every stage file must end with Previous/Next links to adjacent stages (first stage has only Next, last stage has only Previous).
- **`awesome-copilot` referenced once.** In the shared `getting-started.md` file. Do not repeat it in individual tracks.
- **No "Recommended Schedule" section.** Time estimates belong in the stages table. Clock-slot schedules belong in the Facilitator Guide, not in participant-facing track files.

## Outcome Framing

Every challenge drives a business outcome (for example: modernizing legacy code, shipping features, raising quality, automating delivery, standing up platform foundations, or building AI capabilities). This framing lives in the facilitator guide, learning paths, and website, NOT as a new section in track files.

The track file describes WHAT work gets done and HOW to execute it. The outcome framing describes WHY the work matters from a business perspective. Keep these separate.

For customers authoring their own challenges (Bring Your Own Challenge), templates are provided in `byoc/templates/` matching this canonical structure.

## Writing Style

Follow the rules in `.github/copilot-instructions.md`: no emoji in headings, no em-dashes (use `--`), no hype language, no AI sign-offs, natural phrasing, markdownlint-compliant.
