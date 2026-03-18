# Implementation Handoff Guide

How to translate approved Stitch designs into production-quality local UI code.

## Key Principle

**Exported HTML is a reference, not production code.**

Stitch generates working HTML/CSS, but it's optimized for visual fidelity, not for your project's architecture, component structure, or coding standards. Treat exports as a detailed visual specification, not something to ship directly.

## When to Handoff

Start implementation when:

- [ ] The screen is approved in Stitch
- [ ] The handoff checklist (`.stitch/checklists/handoff.md`) is complete
- [ ] The design contract (`DESIGN.md`) is current
- [ ] The implementation target is ready (`src/` with framework set up)

## Handoff Process

### 1. Gather Your Inputs

- **Approved screenshot**: `.stitch/designs/images/{page-name}.png`
- **Exported HTML** (reference): `.stitch/designs/html/{page-name}.html`
- **Design contract**: `.stitch/DESIGN.md`
- **Site plan**: `.stitch/SITE.md` (for navigation context)

### 2. Identify Components

Before writing code, identify what to extract:

- **Shared components** (used across pages): navigation, header, footer, cards, buttons
- **Page-specific components**: unique to this surface
- **Layout components**: page shells, grid wrappers, sidebar containers

### 3. Implement

Use `.stitch/prompts/implementation-handoff.md` to structure the translation:

1. Create reusable components in `src/components/`
2. Build the page in `src/pages/` or `src/app/`
3. Use design tokens from `DESIGN.md`, not hardcoded values
4. Implement all interactive states (hover, focus, active, disabled)
5. Add responsive behavior per `DESIGN.md` breakpoints

### 4. Verify

- Visual comparison against the approved screenshot
- All interactive states work
- Responsive behavior at each breakpoint
- Semantic HTML and accessibility basics

### 5. Update Tracking

- Update `SITE.md`: mark the page as "implemented"
- Write the next baton if more pages remain

## What to Extract from Stitch HTML

The exported HTML is useful for:

- **Exact CSS values**: Colors, sizes, spacing that match the design
- **Layout structure**: How elements are arranged
- **Content**: Text and placeholder content

But you should NOT directly use:

- **Class names**: They're generated, not semantic
- **DOM structure**: It may not match your component architecture
- **Inline styles**: Convert to your project's style system
- **Asset references**: Replace with your local asset paths

## Design Token Workflow

Convert `DESIGN.md` values into your framework's token system:

| DESIGN.md | CSS Custom Properties | JS Tokens |
|---|---|---|
| Color: Primary `#6366F1` | `--color-primary: #6366F1` | `colors.primary = '#6366F1'` |
| Radius: Card `12px` | `--radius-card: 12px` | `radius.card = '12px'` |
| Space: Card `24px` | `--space-card: 24px` | `spacing.card = '24px'` |

This makes the design contract enforceable in code.
