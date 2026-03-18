---
description: Generate and compare design variants for a specific screen
---

# `/stitch-variants` — Generate and Compare Variants

Use this workflow to generate multiple design variants of an existing screen, compare them, select the best, and sync the chosen variant. Useful for exploring visual directions, testing design alternatives, or refining specific aspects of a design.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - `stitchProjects[]` has at least one entry with a non-empty `projectId`
   - `screens[]` has at least one entry to generate variants from

// turbo
2. Read `.stitch/DESIGN.md` — variant generation should reference the design contract to maintain consistency.

// turbo
3. Read `.stitch/prompts/variants.md` for the variant prompt template.

4. Check MCP connectivity — call `list_screens` with the project ID.

## Execution Steps

### Step 1: Select Source Screen

5. Identify the screen to generate variants for:
   - Ask the user which screen to use as the source
   - Cross-reference with `metadata.json` → `screens[]` to get the `screenId`
   - If the user is unsure, suggest the most recently created or currently active screen

6. Call `get_screen` to retrieve the current state of the source screen:
   - `name`: `projects/{projectId}/screens/{screenId}`
   - `projectId`: from `metadata.json`
   - `screenId`: the chosen screen

### Step 2: Define Variant Parameters

7. Ask the user what to explore:
   - **What aspect to vary**: layout, color scheme, typography, component style, content arrangement, density, etc.
   - **How many variants**: typically 2–4 for meaningful comparison
   - **Creative range**: conservative (small tweaks) vs. exploratory (significant departures)

8. Read `.stitch/prompts/variants.md` and fill in the template with:
   - The source screen context
   - What to keep constant (from `DESIGN.md` — identity, brand, core constraints)
   - What to vary (from user input)

### Step 3: Generate Variants

9. Call `generate_variants` with:
   - `projectId`: from `metadata.json`
   - `selectedScreenIds`: `["{source screenId}"]`
   - `prompt`: the filled-in variant prompt
   - `deviceType`: same as the source screen (from `metadata.json` or baton)
   - `variantOptions`: configure based on user input:
     - Number of variants (2–4)
     - Creative range (conservative / exploratory)
     - Aspects to focus on

10. Wait for generation to complete. This can take a few minutes — do NOT retry.

### Step 4: Compare and Select

11. Present all generated variants to the user:
    - Show each variant alongside the original screen
    - Highlight the differences between variants
    - Note how each variant conforms to or departs from the design contract

12. Ask the user to:
    - **Select the preferred variant**, OR
    - **Combine elements** from multiple variants (describe what to take from each), OR
    - **Reject all** and try a different direction

13. If combining elements:
    - Use `edit_screens` to apply the combined changes to the preferred variant
    - Iterate until the user is satisfied

### Step 5: Apply and Sync

14. Once a variant is selected/finalized:
    - If the variant should **replace** the original screen:
      - Use `edit_screens` to apply any final adjustments
      - Update the existing screen record in `metadata.json`
    - If the variant should **supplement** the original (keeping both):
      - Add a new screen entry in `metadata.json` with `role: "variant"`
      - Note the relationship to the original

15. Sync the chosen variant's artifacts:
    - Follow the `/stitch-sync` workflow steps
    - Save to `.stitch/designs/images/{surface-name}-variant-{a|b|c}.png` if keeping variants
    - Or overwrite the original artifact if replacing

16. If the variant changes the visual direction significantly, consider whether `DESIGN.md` needs updating:
    - If yes, recommend running `/stitch-contract` to re-extract
    - If no (variant stays within contract), proceed

## Post-Completion

- [ ] Variants generated and presented to user
- [ ] Preferred variant selected (or elements combined)
- [ ] Chosen variant synced to `.stitch/designs/`
- [ ] `metadata.json` updated with variant screen record
- [ ] Rejected variants noted (optional — for future reference)
- [ ] Design contract consistency verified

## Error Handling

- **`generate_variants` fails**: Do NOT retry immediately. Check `list_screens` to see if variants were created despite the error. If not, verify MCP connectivity and retry once.
- **No source screen available**: Cannot generate variants from nothing. Recommend running `/stitch-design` first.
- **All variants are unsatisfactory**: Try adjusting the prompt — be more specific about what to change. Consider using `edit_screens` for targeted refinements instead of full variant generation.
- **Variant breaks design contract**: If the user prefers a variant that departs from `DESIGN.md`, this is a design decision. Document the departure and update the contract if it's an intentional new direction.
- **MCP unavailable**: Variant generation requires MCP — there is no manual fallback for `generate_variants`. Inform the user and suggest using `edit_screens` (manually in Stitch UI) for targeted explorations instead.
