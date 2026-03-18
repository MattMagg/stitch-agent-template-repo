---
description: Initialize a Stitch project — fresh start or resume from existing state
---

# `/stitch-init` — Initialize a New Project

Use this workflow to bootstrap a new Stitch-powered design project or to resume work on an existing one. Covers Phases 1–4 of the eight-phase lifecycle: reference capture, canonical screen creation, design contract extraction, and site planning.

**Reference docs**: See `docs/workflow-overview.md` for the full eight-phase lifecycle, `docs/stitching-workflow.md` for Stitch MCP operations, and `docs/prompting-guide.md` for writing effective Stitch prompts.

## Pre-Flight Checks

// turbo
1. Verify the `.stitch/` directory exists with its expected structure:
   ```
   ls .stitch/README.md .stitch/DESIGN.md .stitch/SITE.md .stitch/metadata.json .stitch/next-prompt.md
   ```
   If any are missing, the template may not be properly set up. Check `README.md` for setup instructions.

2. Verify `.stitch/prompts/` contains prompt templates:
   ```
   ls .stitch/prompts/
   ```
   Expected: `canonical-screen.md`, `design-contract-extraction.md`, `next-page.md`, `direct-edit.md`, `variants.md`, `redesign-from-reference.md`, `implementation-handoff.md`, `asset-restyling.md`.

3. Check MCP connectivity — attempt to list Stitch projects:
   - Call `list_projects` via MCP
   - If MCP is unavailable, note this and continue — the user can work directly in Stitch UI

## Execution Steps

### Step 1: Detect Current State

// turbo
4. Read `.stitch/metadata.json` and check:
   - Is `projectName` populated? → **Continuation mode**
   - Is `projectName` empty? → **Fresh start mode**
   - What is `workflowPhase`? (`init`, or a later phase)
   - Are there any entries in `stitchProjects[]`?
   - Are there any entries in `screens[]`?

**If continuation mode**: Skip to the phase indicated by `workflowPhase`. Report current state and ask the user what to do next. Consider running `/stitch-status` for a full report.

**If fresh start**: Continue with Step 2.

### Step 2: Gather Project Identity

5. Ask the user for:
   - **Project name** — what to call this project
   - **Project type** — website, landing page, dashboard, web app, or other
   - **Brief description** — one sentence about the project's purpose
   - **Target audience** — who this is for
   - **Design direction** — any visual preferences, references, or mood

6. Update `.stitch/metadata.json`:
   - Set `projectName` to the user's answer
   - Set `localSlug` to a kebab-case version of the project name
   - Set `workflowPhase` to `"reference-capture"`
   - Set `createdAt` and `updatedAt` to the current ISO timestamp

### Step 3: Phase 1 — Reference Capture

7. Ask the user if they have reference images, screenshots, or inspiration:
   - **If yes**: Save them to `.stitch/references/screenshots/` and document what the user likes about each one in `.stitch/references/notes.md`
   - **If no**: Note that no references were provided — the canonical screen will establish the visual direction from scratch

8. Update `workflowPhase` in `metadata.json` to `"canonical-screen"`.

### Step 4: Phase 2 — Canonical Screen Creation

9. Create a Stitch project via MCP:
   - Call `create_project` with the project name as `title`
   - Record the returned project ID in `metadata.json` → `stitchProjects[0].projectId`
   - Set `stitchProjects[0].title`, `stitchProjects[0].deviceType`, and `stitchProjects[0].linkedAt`

10. Read `.stitch/prompts/canonical-screen.md` for the prompt template.

11. Work with the user to fill in the template:
    - Project identity and design direction from Step 2
    - Reference materials from Step 3 (if any)
    - Target device type (`DESKTOP` is the common default)

12. Call `generate_screen_from_text` with:
    - `projectId`: the Stitch project ID from Step 9
    - `prompt`: the filled-in canonical screen prompt
    - `deviceType`: as chosen (default `DESKTOP`)

13. Present the result to the user for review:
    - Does it match the intended design direction?
    - Is the visual identity strong enough to extract a design contract from?
    - If not, use `edit_screens` to iterate until the user approves

14. Once approved, sync the canonical screen:
    - Record the screen in `metadata.json` → `screens[]` with `role: "canonical"`, `status: "approved"`, `designApproved: true`
    - Save artifacts to `.stitch/designs/images/` and `.stitch/designs/html/` if available
    - Follow the sync steps from `/stitch-sync`

15. Update `workflowPhase` to `"design-contract"`.

### Step 5: Phase 3 — Design Contract Extraction

16. Read `.stitch/prompts/design-contract-extraction.md` for the extraction template.

17. Analyze the approved canonical screen and populate `.stitch/DESIGN.md`:
    - Fill all 18 sections: identity, atmosphere, colors, typography, spacing, geometry, elevation, iconography, imagery, layout, navigation, component styles, motion, responsive, implementation notes, forbidden patterns
    - Use exact values from the screen (hex colors, font names, pixel sizes)
    - Document intentional decisions for any gaps

18. Update `metadata.json`:
    - Set `designContract.version` to `1`
    - Set `designContract.lastExtractedFrom` to the canonical screen ID
    - Set `designContract.extractedAt` to the current ISO timestamp
    - Set `workflowPhase` to `"planning"`

### Step 6: Phase 4 — Site Planning

19. Work with the user to populate `.stitch/SITE.md`:
    - **Project Summary**: name, type, description, target launch
    - **Target Surfaces**: list every page/view/surface with type, priority (P0/P1/P2), and initial status ("planned")
    - **Sitemap**: visual hierarchy of how surfaces relate
    - **Page Dependencies**: which pages must exist before others
    - **Next Recommended Page**: which surface to design first after the canonical

20. Update `metadata.json`:
    - Set `workflowPhase` to `"baton-loop"`
    - Set `baton.phase` to `"design"`

21. Write the first baton — prepare `.stitch/next-prompt.md` for the next surface:
    - Follow the baton structure from the template
    - Reference `/stitch-next` for detailed baton preparation

22. Inform the user that initialization is complete and the project is ready for the design loop. Recommend running `/stitch-design` to execute the first baton.

## Post-Completion

- [ ] `metadata.json` has `projectName`, `stitchProjects[]`, canonical screen in `screens[]`, `designContract` populated, `workflowPhase` set to `"baton-loop"`
- [ ] `DESIGN.md` populated from canonical screen (version 1)
- [ ] `SITE.md` populated with surface inventory and priorities
- [ ] `next-prompt.md` written with the first baton task
- [ ] Canonical screen artifacts synced to `.stitch/designs/`
- [ ] Log the initialization in `.stitch/logs/` with key decisions

## Error Handling

- **MCP unavailable**: Inform the user that Stitch must be accessed directly via the web UI. Provide the project details and prompt text for manual screen creation. All local state updates still apply.
- **`create_project` fails**: Check MCP connectivity with `list_projects`. If that fails too, fall back to manual mode. If it succeeds, retry `create_project`.
- **Canonical screen unsatisfactory after multiple edits**: Consider using `generate_variants` to explore different directions, then use `edit_screens` to refine the preferred variant.
- **Missing template files**: If `.stitch/prompts/` is empty or files are missing, the template repo may not be fully set up. Check the repository's `README.md` for setup instructions.
- **`metadata.json` has unexpected structure**: If the file exists but doesn't match the expected schema, back it up and re-initialize from the template.
- **General troubleshooting**: See `docs/failure-modes.md` for common issues and recovery steps across all workflow phases.
