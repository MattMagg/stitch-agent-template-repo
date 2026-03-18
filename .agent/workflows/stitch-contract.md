---
description: Extract or update the design contract (DESIGN.md) from Stitch screens
---

# `/stitch-contract` — Extract or Update Design Contract

Use this workflow to extract style rules from approved Stitch screen(s) into `.stitch/DESIGN.md`, creating or updating the project's authoritative design contract. Typically run after Phase 2 (canonical screen creation) or when the design direction has intentionally shifted.

**Reference docs**: See `docs/design-contract-guide.md` for detailed guidance on what to extract, how to use the contract during design and implementation, and when to update it.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - `stitchProjects[]` has at least one entry with a non-empty `projectId`
   - `screens[]` has at least one entry with `designApproved: true` or `status: "approved"`
   - If no approved screens exist, recommend running `/stitch-design` first

// turbo
2. Check that `.stitch/DESIGN.md` exists:
   - If it exists, note the current `Contract version` at the bottom of the file
   - If it doesn't exist, the template may not be set up — check the repo setup

// turbo
3. Read `.stitch/prompts/design-contract-extraction.md` for the extraction prompt template.

4. Check MCP connectivity — call `list_screens` with the project ID:
   - If MCP is available, we can retrieve screen details for analysis
   - If MCP is unavailable, we need local artifacts (screenshots, HTML) to extract from

## Execution Steps

### Step 1: Identify Source Screen(s)

5. Determine which screen(s) to extract from:
   - **Default**: the canonical screen (look for `role: "canonical"` in `metadata.json` → `screens[]`)
   - **If updating**: the user may specify a different screen that establishes new patterns
   - Ask the user to confirm the source screen(s)

6. Gather the source material:
   - **Via MCP**: Call `get_screen` with the screen ID to retrieve details
   - **Via local artifacts**: Read screenshots from `.stitch/designs/images/` and HTML from `.stitch/designs/html/`
   - Both are valid inputs for extraction

### Step 2: Analyze and Extract

7. Using the `.stitch/prompts/design-contract-extraction.md` template as a guide, analyze the source screen(s) and extract values for all 18 sections of `DESIGN.md`:

   1. **Project Identity** — name, tagline, personality, audience
   2. **Design Intent** — goal, tone, density, formality
   3. **Atmosphere & Tone** — mode, temperature, weight, texture
   4. **Color System** — primary palette (exact hex/HSL values), gradients, application rules
   5. **Typography** — font families, weights, sizes, line heights, spacing, rules
   6. **Spacing & Rhythm** — base unit, scale, padding conventions
   7. **Geometry & Radius** — border-radius per element type
   8. **Elevation & Shadows** — shadow values per level, rules
   9. **Iconography** — icon set, size, stroke, color rules
   10. **Imagery & Art Direction** — photo/illustration style, aspect ratios
   11. **Layout Patterns** — max width, grid, sidebar, header behavior
   12. **Navigation Patterns** — primary/secondary nav, active states
   13. **Component Styles** — buttons, inputs, cards, tables, modals, notifications
   14. **Motion & Interaction** — transitions, easing, hover, scroll
   15. **Responsive Behavior** — breakpoints, layout changes, scaling
   16. **Implementation Notes** — CSS methodology, component library, accessibility
   17. **Forbidden Patterns** — explicit "never do this" rules
   18. **Metadata** — source screen, version, extraction date

8. For each section:
   - Use **exact values** from the screen (not approximations)
   - Where a value cannot be determined from the screen, make an **intentional decision** and note it
   - Where a section is not applicable, mark it as "N/A — [reason]"

### Step 3: Populate DESIGN.md

9. Write the extracted values into `.stitch/DESIGN.md`:
   - Replace template placeholders (`<!-- TODO -->`) with actual values
   - Preserve the document structure and section headers
   - Update the footer metadata:
     - `Last updated from screen`: source screen ID or name
     - `Contract version`: increment by 1 from the current version
     - `Extraction date`: current date (YYYY-MM-DD)

10. Present the populated `DESIGN.md` to the user for review:
    - Highlight any sections where assumptions were made
    - Ask if any values need adjustment
    - Iterate until the user approves the contract

### Step 4: Update Metadata

11. Update `.stitch/metadata.json`:
    - Set `designContract.version` to the new version number
    - Set `designContract.lastExtractedFrom` to the source screen ID
    - Set `designContract.extractedAt` to the current ISO timestamp
    - Set `updatedAt` to the current ISO timestamp

## Post-Completion

- [ ] `DESIGN.md` populated with extracted values across all 18 sections
- [ ] Contract version incremented
- [ ] `metadata.json` `designContract` fields updated
- [ ] User approved the contract
- [ ] Log the extraction in `.stitch/logs/` noting source screen and version

## Error Handling

- **No approved screens available**: Cannot extract a contract without a source screen. Recommend running `/stitch-design` to create and approve a canonical screen first.
- **MCP unavailable and no local artifacts**: The contract cannot be extracted without seeing the screen. Ask the user to capture a screenshot manually and save to `.stitch/designs/images/`.
- **Partial extraction**: If some sections cannot be filled from the screen (e.g., responsive behavior from a desktop-only screen), fill what's possible, mark remaining sections with `<!-- TODO: Not visible in source screen — decide intentionally -->`, and inform the user.
- **Contract version conflict**: If `DESIGN.md` has been modified outside this workflow, compare the current content with the new extraction. Preserve intentional additions and update only extracted values.
- **User disagrees with extracted values**: Adjust the contract per user feedback. The contract is a design decision, not an automated measurement — the user has final authority.
