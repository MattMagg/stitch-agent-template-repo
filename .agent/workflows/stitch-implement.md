---
description: Translate approved Stitch designs into local UI code in src/
---

# `/stitch-implement` — Implementation Handoff

Use this workflow to translate an approved Stitch design into local UI code. Runs the handoff checklist, reads design artifacts and the design contract, extracts reusable components, and produces working code in `src/`.

**Reference docs**: See `docs/implementation-handoff-guide.md` for the full handoff process, design token workflow, and what to extract from Stitch HTML exports. See `docs/design-contract-guide.md` for how to convert `DESIGN.md` values into CSS custom properties.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - At least one screen has `status: "approved"` and `designApproved: true`
   - `designContract.version` is ≥ 1 (contract has been extracted)
   - `workflowPhase` is `"baton-loop"` or later

// turbo
2. Read `.stitch/DESIGN.md` and verify it is populated (not template-only).

// turbo
3. Read `.stitch/checklists/handoff.md` — this is the validation checklist for implementation readiness.

4. Identify the target surface for implementation:
   - Check `next-prompt.md` — is the current baton an `implementation` type task?
   - If not, check `SITE.md` for surfaces with status `"approved"` that have not been implemented
   - Ask the user to confirm which surface to implement

5. Verify design artifacts exist for the target surface:
   - Screenshot in `.stitch/designs/images/{surface-name}.png`
   - HTML export in `.stitch/designs/html/{surface-name}.html` (if available)
   - If artifacts are missing, recommend running `/stitch-sync` first

## Execution Steps

### Step 1: Run the Handoff Checklist

6. Walk through `.stitch/checklists/handoff.md` section by section:

   **Design Completion**:
   - [ ] Screen approved in Stitch — no further design changes planned
   - [ ] Screenshot captured and saved locally
   - [ ] HTML exported (if applicable)
   - [ ] `metadata.json` updated with screen record
   - [ ] `SITE.md` page status is `"approved"`

   **Design Contract Verification**:
   - [ ] Surface conforms to `DESIGN.md` color system
   - [ ] Surface conforms to `DESIGN.md` typography
   - [ ] Surface conforms to `DESIGN.md` spacing and geometry
   - [ ] Surface conforms to `DESIGN.md` component styles
   - [ ] No forbidden patterns present

   **Implementation Preparation**:
   - [ ] Components to extract identified
   - [ ] Shared vs. page-specific elements distinguished
   - [ ] Responsive behavior documented
   - [ ] Interactive states identified
   - [ ] Data requirements identified
   - [ ] Asset requirements listed

7. If any checklist item fails, resolve it before continuing:
   - Missing artifacts → run `/stitch-sync`
   - Design contract non-conformance → discuss with user (update design or accept exception)
   - Unclear requirements → ask the user

### Step 2: Prepare Implementation Context

// turbo
8. Read the design artifacts:
   - View the screenshot from `.stitch/designs/images/{surface-name}.png`
   - Read the HTML export from `.stitch/designs/html/{surface-name}.html` (if available)
   - Note: HTML exports are **reference material**, not production code

// turbo
9. Read `.stitch/prompts/implementation-handoff.md` for the handoff prompt template.

// turbo
10. Read the relevant sections of `.stitch/DESIGN.md`:
    - Color System (design tokens)
    - Typography (font families, sizes, weights)
    - Spacing & Rhythm (base unit, scale)
    - Component Styles (buttons, inputs, cards, etc.)
    - Motion & Interaction (transitions, easing)

### Step 3: Plan the Implementation

11. Analyze the design and plan the code structure:
    - **Page component**: the top-level page in `src/pages/`
    - **Shared components**: reusable elements that should go in `src/components/`
    - **Page-specific components**: elements unique to this surface
    - **Style files**: CSS/tokens in `src/styles/`
    - **Assets**: images, icons, fonts in `src/assets/`

12. Present the implementation plan to the user:
    - List of files to create/modify
    - Component breakdown
    - Any framework or architectural decisions needed
    - Ask for confirmation before proceeding

### Step 4: Implement

13. Create the implementation, following these principles:
    - **Design contract authority**: Use `DESIGN.md` values for all style tokens (colors, fonts, spacing, radii, shadows)
    - **Exported HTML is reference**: Adapt Stitch HTML to your architecture — do not copy-paste it as production code
    - **Component extraction**: Factor out reusable elements into `src/components/`
    - **Semantic HTML**: Use proper HTML5 semantic elements
    - **Accessibility**: Include alt text, keyboard navigation, ARIA labels where appropriate
    - **Responsive behavior**: Implement breakpoints from `DESIGN.md` responsive section

14. Create files in the appropriate locations:
    ```
    src/
    ├── pages/{surface-name}.{ext}       ← page component
    ├── components/{component-name}.{ext} ← shared components
    ├── styles/{surface-or-token}.css     ← styles
    └── assets/                           ← images, fonts, icons
    ```

15. Apply design tokens consistently:
    - Use CSS custom properties (variables) derived from `DESIGN.md`
    - Reference the design token system established in `src/styles/` (create if needed)

### Step 5: Verify Implementation

16. Verify the implementation matches the approved design:
    - Visual comparison against the screenshot
    - All interactive states implemented (hover, focus, active, disabled, loading)
    - Responsive behavior working at defined breakpoints
    - No forbidden patterns from `DESIGN.md` present

17. Run any available build/lint/test commands to confirm the code is valid.

## Post-Completion

- [ ] Page component created in `src/pages/`
- [ ] Shared components extracted to `src/components/`
- [ ] Design tokens applied from `DESIGN.md`
- [ ] Implementation visually matches approved design
- [ ] Interactive states implemented
- [ ] Responsive behavior implemented
- [ ] Accessibility basics in place
- [ ] `SITE.md` page status updated to `"implemented"`
- [ ] `SITE.md` Completion Summary counts updated
- [ ] `next-prompt.md` updated (next baton or cleared)
- [ ] Handoff logged in `.stitch/logs/`

## Error Handling

- **No design artifacts available**: Cannot implement without reference material. Run `/stitch-sync` to pull artifacts, or ask the user to provide screenshots manually.
- **HTML export missing**: This is acceptable — screenshots + `DESIGN.md` are sufficient for implementation. The HTML export is a convenience, not a requirement.
- **Design contract is stale or incomplete**: If `DESIGN.md` lacks values needed for implementation (e.g., missing responsive breakpoints), note the gaps, make reasonable decisions, and document them. Consider running `/stitch-contract` to update.
- **Framework/tooling not decided**: If `SITE.md` → Implementation Notes is empty, ask the user to choose a framework before proceeding. Implementation depends on architectural decisions.
- **Component conflicts**: If a shared component already exists in `src/components/` with different styling, compare against `DESIGN.md` to determine the correct version. The design contract is authoritative.
- **Build errors after implementation**: Debug and fix before marking as complete. Do not leave broken builds.
- **Exported HTML doesn't work in the local framework**: See `docs/failure-modes.md` → "Exported HTML doesn't work" — remember that Stitch HTML is reference material, not production code. Extract CSS values and rebuild using your framework's patterns.
- **Implementation doesn't match design**: See `docs/failure-modes.md` → "Local implementation doesn't match the design" for common issues (spacing, hover states, border-radius).
