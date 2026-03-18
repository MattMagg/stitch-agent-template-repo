---
description: Create or edit a screen in Stitch using the current baton task
---

# `/stitch-design` — Create or Edit a Screen

Use this workflow to execute one design iteration in Stitch. Reads the current baton from `next-prompt.md`, selects the appropriate prompt template, creates or edits a screen via MCP, guides the user through review, and syncs artifacts on approval.

**Reference docs**: See `docs/prompting-guide.md` for writing effective Stitch prompts, `docs/stitching-workflow.md` for MCP tool mapping and screen creation flow, and `docs/failure-modes.md` for recovery when designs don't match expectations.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - `stitchProjects[]` has at least one entry with a non-empty `projectId`
   - `workflowPhase` is `"baton-loop"` or later
   - If not, recommend running `/stitch-init` first

// turbo
2. Read `.stitch/DESIGN.md` and verify it is populated (not just the empty template):
   - Check that the Color System section has values
   - If empty, recommend running `/stitch-contract` first

// turbo
3. Read `.stitch/next-prompt.md` and check:
   - Is a task defined (non-template content)?
   - What is the task **Type**? (canonical-screen, redesign, direct-edit, variant, next-page, implementation, asset-restyle)
   - If empty/template-only, fall back to Step 4a

4. Check MCP connectivity by calling `list_projects`
   - If MCP is unavailable, inform the user and provide manual instructions

## Execution Steps

### Step 4a: No Baton — Determine Next Task

If `next-prompt.md` is empty or only contains the template:

// turbo
5. Read `.stitch/SITE.md` and find:
   - The **Next Recommended Page** section
   - Any surfaces with status `"planned"` or `"in-design"`
   - Suggest the highest-priority unstarted surface to the user

6. Ask the user to confirm which surface to design, then prepare the baton:
   - Run `/stitch-next` to write a proper baton, OR
   - Manually fill `next-prompt.md` with the chosen surface details

7. Continue to Step 8 once the baton is ready.

### Step 4b: Baton Exists — Validate Inputs

// turbo
8. From the baton, extract:
   - **Task Name** and **Type**
   - **Target Surface / Page**
   - **Stitch Project ID** (cross-reference with `metadata.json`)
   - **Design Contract Constraints** (verify they match current `DESIGN.md`)
   - **Acceptance Criteria**

9. Verify the **Required Inputs** checklist in the baton:
   - All checked items must be true
   - If any are not met, inform the user and resolve before continuing

### Step 5: Select Prompt Template

10. Based on the baton's **Type**, read the corresponding prompt template:

| Baton Type | Prompt Template | MCP Tool |
|---|---|---|
| `canonical-screen` | `.stitch/prompts/canonical-screen.md` | `generate_screen_from_text` |
| `next-page` | `.stitch/prompts/next-page.md` | `generate_screen_from_text` |
| `redesign` | `.stitch/prompts/redesign-from-reference.md` | `generate_screen_from_text` |
| `direct-edit` | `.stitch/prompts/direct-edit.md` | `edit_screens` |
| `variant` | `.stitch/prompts/variants.md` | `generate_variants` |
| `asset-restyle` | `.stitch/prompts/asset-restyling.md` | `edit_screens` |
| `implementation` | — skip to `/stitch-implement` | — |

// turbo
11. Read the selected prompt template file.

### Step 6: Prepare and Execute the Prompt

12. Fill in the prompt template with:
    - Project details from `metadata.json`
    - Surface details from the baton
    - Design contract constraints from the baton (originally from `DESIGN.md`)
    - Any reference materials noted in the baton

13. Execute the MCP tool call:

    **For new screens** (`generate_screen_from_text`):
    - `projectId`: from `metadata.json`
    - `prompt`: the filled-in prompt
    - `deviceType`: from the baton or default `DESKTOP`

    **For edits** (`edit_screens`):
    - `projectId`: from `metadata.json`
    - `selectedScreenIds`: the screen ID from the baton or `metadata.json`
    - `prompt`: the filled-in prompt
    - `deviceType`: from the baton or default `DESKTOP`

    **For variants** (`generate_variants`):
    - Use `/stitch-variants` workflow instead
    - `projectId`, `selectedScreenIds`, `prompt`, `variantOptions`

14. Wait for the MCP tool to complete. This can take a few minutes — do NOT retry.

### Step 7: Review and Iterate

15. Present the generated screen to the user. Check against the baton's **Acceptance Criteria**:
    - Does it conform to the design contract (colors, typography, spacing, geometry)?
    - Does it meet the functional requirements?
    - Are there any forbidden patterns present?

16. If the user wants changes:
    - Use `edit_screens` with a targeted refinement prompt
    - Reference `.stitch/prompts/direct-edit.md` for edit prompt structure
    - Repeat review until the user approves

17. Once the user approves, mark the baton's Status as `complete`.

### Step 8: Sync Artifacts

18. Run the artifact sync process (or invoke `/stitch-sync`):
    - Get screen details via `get_screen` with the screen ID
    - Save screenshot to `.stitch/designs/images/{surface-name}.png`
    - Save HTML export to `.stitch/designs/html/{surface-name}.html` (if available)
    - Follow naming conventions from `docs/sync-strategy.md`

19. Update `.stitch/metadata.json`:
    - Add or update the screen entry in `screens[]`
    - Set `screenId`, `name`, `status: "approved"`, `designApproved: true`
    - Populate `localArtifacts` paths
    - Set `updatedAt` to current ISO timestamp
    - Append to `syncLog[]`

20. Update `.stitch/SITE.md`:
    - Set the surface status to `"approved"`
    - Update the **Completion Summary** counts
    - Update the **Page Inventory** section for this surface

### Step 9: Write Next Baton

21. Check if there are more surfaces to design in `SITE.md`:
    - **If yes**: Prepare the next baton using `/stitch-next`, or suggest the user run it
    - **If no**: Note that all surfaces are designed. Recommend `/stitch-implement` for implementation

22. Clear and re-fill `.stitch/next-prompt.md` with the next task (or mark the project as design-complete).

## Post-Completion

- [ ] Screen created/edited and approved in Stitch
- [ ] Artifacts synced to `.stitch/designs/` (screenshots, HTML)
- [ ] `metadata.json` updated with screen record, sync log entry
- [ ] `SITE.md` updated with surface status and completion counts
- [ ] `next-prompt.md` updated with the next baton (or cleared if complete)
- [ ] Previous baton marked complete

## Error Handling

- **MCP `generate_screen_from_text` fails**: Do NOT retry immediately — MCP generation can take minutes. Wait, then check the project via `list_screens` to see if the screen was created despite the error. If not, retry once.
- **MCP `edit_screens` fails**: Same approach — check `list_screens` first, then retry.
- **No baton and no planned surfaces in SITE.md**: The site plan may be incomplete. Ask the user whether to add more surfaces or proceed to implementation.
- **Design contract constraints missing from baton**: Read current `DESIGN.md` directly and extract the relevant constraints. Note the gap for the next baton.
- **Screen does not match design contract after multiple edits**: Consider whether the design contract needs updating (run `/stitch-contract`), or whether this surface is an intentional exception. Document the decision.
- **MCP unavailable**: Provide the filled-in prompt text to the user for manual creation in Stitch UI. All local state updates still apply after the user manually creates and shares the result.
- **Design drift between pages**: See `docs/failure-modes.md` → "Design drift between pages" for recovery strategies.
- **General prompting issues**: See `docs/prompting-guide.md` for iteration strategy — typically limit to three rounds of edits before starting fresh.
