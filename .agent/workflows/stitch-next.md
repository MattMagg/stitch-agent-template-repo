---
description: Advance to the next page — prepare the baton for the next design iteration
---

# `/stitch-next` — Advance to Next Page

Use this workflow to close the current iteration and prepare the baton for the next surface. Validates readiness, identifies the next surface from `SITE.md`, writes a bounded task in `next-prompt.md` with design contract constraints and acceptance criteria, and hands off to `/stitch-design`.

**Reference docs**: See `docs/baton-loop-guide.md` for the full baton loop mechanics, tips for keeping batons small, and why skipping the baton step causes drift. See `docs/failure-modes.md` → "Baton file is stale or missing" for recovery.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - `workflowPhase` is `"baton-loop"`
   - `designContract.version` ≥ 1 (contract exists)
   - At least one screen exists in `screens[]`

// turbo
2. Read `.stitch/checklists/readiness.md` — this is the validation checklist for pre-design readiness.

// turbo
3. Read `.stitch/next-prompt.md` and check:
   - Is there an active baton? What is its status?
   - If status is `"active"`, the current iteration may not be complete — ask the user before overwriting

// turbo
4. Read `.stitch/DESIGN.md` — needed to extract constraints for the next baton.

## Execution Steps

### Step 1: Verify Current Iteration is Complete

5. Run through the **Pre-Design Readiness** section of `.stitch/checklists/readiness.md`:
   - [ ] `DESIGN.md` exists and is populated from the canonical screen
   - [ ] `SITE.md` identifies surfaces for design
   - [ ] `metadata.json` has current Stitch project ID(s)
   - [ ] Previous surface approved and artifacts synced (if sequential)

6. If the current baton in `next-prompt.md` has status `"active"` or `"pending"`:
   - Ask the user: "The current baton ({task name}) is still {status}. Should I mark it complete and move on, or finish it first?"
   - If the user wants to finish it, recommend running `/stitch-design`
   - If the user wants to skip it, mark it `"complete"` (or `"skipped"`) and continue

### Step 2: Identify the Next Surface

// turbo
7. Read `.stitch/SITE.md` and find the next surface to design:
   - Check the **Next Recommended Page** section first
   - If empty, scan the **Target Surfaces** table for the highest-priority surface with status `"planned"`
   - Consider **Page Dependencies** — skip surfaces whose dependencies aren't met

8. Present the recommendation to the user:
   - "The next surface to design is **{surface name}** (Priority: {P0/P1/P2}). Reason: {from SITE.md or dependency analysis}."
   - Ask the user to confirm, or let them choose a different surface

### Step 3: Determine Task Type

9. Based on the surface and context, determine the baton task type:

| Situation | Type | Prompt Template |
|---|---|---|
| Designing a new page (most common) | `next-page` | `.stitch/prompts/next-page.md` |
| Redesigning from a reference | `redesign` | `.stitch/prompts/redesign-from-reference.md` |
| Restyling assets only | `asset-restyle` | `.stitch/prompts/asset-restyling.md` |
| Creating the canonical screen | `canonical-screen` | `.stitch/prompts/canonical-screen.md` |

Default to `next-page` unless the user specifies otherwise.

### Step 4: Extract Design Contract Constraints

// turbo
10. From `.stitch/DESIGN.md`, extract the constraints relevant to the target surface:
    - **Color rules**: primary palette, application rules
    - **Typography**: font families, sizes, weights for the elements on this surface
    - **Layout pattern**: grid, max width, sidebar behavior relevant to this surface
    - **Component styles**: button variants, input styles, card styles needed
    - **Forbidden patterns**: all forbidden patterns apply to every surface

11. If the surface has specific requirements (e.g., a dashboard needs data tables, a landing page needs hero sections), note the relevant component styles from `DESIGN.md`.

### Step 5: Write the Baton

12. Clear `.stitch/next-prompt.md` and fill in the baton template:

    ```markdown
    # Baton: Next Task

    > This file drives exactly one bounded iteration.

    ## Task
    - **Name**: {descriptive name, e.g., "Design Dashboard Overview"}
    - **Type**: {task type from Step 9}

    ## Target
    - **Surface / page**: {surface name from SITE.md}
    - **Stitch project ID**: {from metadata.json}

    ## Required Inputs
    - [x] Design contract (`DESIGN.md`) is current
    - [x] Site plan (`SITE.md`) identifies this surface
    - [{x or space}] Reference materials collected: {paths if applicable}
    - [{x or space}] Previous page approved: {which page}
    - [ ] Other: {any additional prerequisites}

    ## Design Contract Constraints
    - **Color rules**: {extracted from DESIGN.md}
    - **Typography**: {extracted}
    - **Layout pattern**: {extracted}
    - **Component styles**: {extracted}
    - **Forbidden patterns**: {extracted}

    ## Acceptance Criteria
    - [ ] Screen matches DESIGN.md color system
    - [ ] Typography follows the contract
    - [ ] Navigation follows established pattern
    - [ ] {surface-specific criteria}
    - [ ] Screenshot synced to designs/

    ## Expected Outputs
    - [ ] Stitch screen created/updated (ID: ___)
    - [ ] Screenshot saved to `.stitch/designs/images/`
    - [ ] HTML exported to `.stitch/designs/html/` (if applicable)
    - [ ] `metadata.json` updated with screen record
    - [ ] `SITE.md` updated with page status

    ## Prompt to Use
    Template: `.stitch/prompts/{template-name}.md`

    ## Follow-Up
    - **Next surface**: {name of the next page after this one}
    - **Handoff notes**: {anything this iteration needs to know}
    - **Blockers for next**: {anything that must be resolved first}

    ---
    *Created*: {YYYY-MM-DD}
    *Status*: pending
    ```

13. Present the prepared baton to the user for confirmation:
    - Is the task scoped correctly (one page, one surface)?
    - Are the acceptance criteria clear?
    - Are there any additional constraints to include?

### Step 6: Update State

14. Update `.stitch/SITE.md`:
    - Set the target surface status to `"in-design"`
    - Update the **Next Recommended Page** section to reflect the surface after this one
    - Set `Baton written: yes` in the Next Recommended Page section

15. Update `.stitch/metadata.json`:
    - Set `baton.currentTarget` to the surface name
    - Set `baton.phase` to `"design"`
    - Set `baton.updatedAt` to current ISO timestamp

16. Inform the user: "Baton is ready. Run `/stitch-design` to execute this iteration."

## Post-Completion

- [ ] Previous iteration verified as complete
- [ ] Next surface identified and confirmed with user
- [ ] `next-prompt.md` written with bounded task, constraints, and acceptance criteria
- [ ] Design contract constraints included in baton
- [ ] `SITE.md` updated (surface status, next recommendation)
- [ ] `metadata.json` baton fields updated
- [ ] User informed of next step (`/stitch-design`)

## Error Handling

- **No more planned surfaces in SITE.md**: All surfaces may be designed. Check:
  - Are there surfaces in `"approved"` status that need implementation? → Recommend `/stitch-implement`
  - Are there deferred surfaces to reconsider?
  - Is the project complete?
  - Ask the user what to do next.

- **Active baton exists**: Do not silently overwrite. Always ask the user whether to complete, skip, or abandon the current baton before writing a new one.

- **Design contract is stale**: If `DESIGN.md` hasn't been updated but the design direction has shifted, recommend running `/stitch-contract` before writing the next baton.

- **Dependency chain unresolved**: If the next surface depends on pages that aren't approved yet, inform the user and suggest reordering, or design the dependency first.

- **Baton scope too large**: If the user describes a task that spans multiple pages or requires multiple Stitch sessions, help break it down. One baton = one surface = one iteration.
