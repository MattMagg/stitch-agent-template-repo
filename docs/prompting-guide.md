# Prompting Guide

How to write effective prompts for Stitch screen generation.

## Core Principles

1. **Incremental, not monolithic**: One screen per prompt. Never ask for an entire multi-page app in one prompt.
2. **Specific over vague**: Describe layout, content, and visual treatment concretely.
3. **Reference-driven when possible**: Describing a reference is often more effective than inventing aesthetics from prose.
4. **Design contract as constraint**: Always include relevant `DESIGN.md` values when generating pages after the canonical screen.

## Prompt Structure

A good prompt has four parts:

```
1. WHAT — what screen/surface to create
2. CONTENT — what elements and content it contains
3. STYLE — design contract constraints (colors, typography, layout)
4. CONTEXT — how this page fits in the broader project
```

## What Makes a Good Prompt

### Do

- Specify the device type (desktop, mobile, tablet)
- List specific UI elements (sidebar, header, card grid, data table)
- Include realistic content, not "lorem ipsum"
- Reference `DESIGN.md` values for consistency
- Mention the canonical screen for shared elements
- State what the page is FOR (purpose/user goal)

### Don't

- Ask for multiple pages in one prompt
- Use vague aesthetic descriptions ("make it look modern and clean")
- Omit the design contract on non-canonical screens
- Describe every pixel — let the model make reasonable micro-decisions
- Include contradictory constraints

## Prompt Templates

All templates are in `.stitch/prompts/`. Use the right template for the right task:

| Task | Template |
|---|---|
| First screen for a new project | `canonical-screen.md` |
| Screen from a reference image | `redesign-from-reference.md` |
| Fix or adjust an existing screen | `direct-edit.md` |
| Explore alternative approaches | `variants.md` |
| Extract style rules from a screen | `design-contract-extraction.md` |
| Create the next page | `next-page.md` |
| Move design to code | `implementation-handoff.md` |
| Restyle images/assets | `asset-restyling.md` |

## Iteration Strategy

1. **First attempt**: Generate with a well-structured prompt
2. **Second attempt**: Use direct edit to fix specific issues
3. **Third attempt**: If still not right, try a variant to explore alternatives
4. **Last resort**: Start fresh with a redesign-from-reference using a working screen as the reference

Don't iterate endlessly on one screen. Three rounds of edits is usually the limit before starting fresh is more effective.
