# Design Contract Guide

How to create, maintain, and use `.stitch/DESIGN.md` as the local style authority.

## What Is the Design Contract?

`DESIGN.md` is a structured document that captures every visual decision from your approved canonical screen. It is the single source of truth for:

- Colors (exact values, not "blue-ish")
- Typography (exact fonts, sizes, weights)
- Spacing (exact scale, not "generous")
- Component styles (exact radius, shadow, padding)
- Layout patterns (exact grid, max-width, sidebar rules)

## When to Create It

Create `DESIGN.md` after approving your canonical screen(s) — Phase 3 of the workflow.

Use the prompt template: `.stitch/prompts/design-contract-extraction.md`

## What to Extract

The template in `.stitch/DESIGN.md` has all the sections you need. Focus on:

1. **Start with exact values**: Extract hex codes, pixel sizes, font names. Not descriptions — values.
2. **Cover every element type**: Buttons, cards, inputs, tables, modals, navigation.
3. **Document the atmosphere**: Sometimes the feeling matters as much as the values (warm/cool, dense/spacious, heavy/light).
4. **Record forbidden patterns**: What should NOT appear. These are as important as what should.

## How to Use It

### During Design Continuation

When generating new pages (Phase 5), include relevant `DESIGN.md` values in your prompt:

```
**Design contract constraints:**
- Background: #0F1117
- Surface: #1A1D27
- Primary: #6366F1
- Typography: Inter, 14px body, 24px h2
- Card radius: 12px
- Card padding: 24px
```

### During Implementation

Reference `DESIGN.md` values when writing CSS/styles. Use CSS custom properties or design tokens to make the contract enforceable:

```css
:root {
  --color-bg: #0F1117;
  --color-surface: #1A1D27;
  --color-primary: #6366F1;
  --radius-card: 12px;
  --space-card: 24px;
}
```

## When to Update It

- **After a significant design evolution**: If you approve a screen that intentionally changes the visual direction
- **When adding new component types**: If a new page introduces a component not yet in the contract (e.g., first use of a data table)
- **Never silently**: Always increment the version number and record what changed

## Common Mistakes

- **Skipping extraction**: Relying on "I'll remember the style" instead of documenting it
- **Vague values**: Writing "use a rounded corner" instead of "border-radius: 12px"
- **Incomplete coverage**: Extracting colors but forgetting typography or spacing
- **Not enforcing it**: Having a design contract but not referencing it in prompts or implementation
