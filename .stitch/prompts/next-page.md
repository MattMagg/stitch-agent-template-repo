# Prompt: Next Page Generation

> Generate the next page or surface, driven by `DESIGN.md` and `SITE.md`.

## When to Use

- When continuing page-by-page after the canonical screen is locked
- When `next-prompt.md` identifies a specific surface to create
- When extending the project with a new page that must match the established design

## Template

```
Create a {{DEVICE_TYPE}} screen for the "{{PAGE_NAME}}" page.

**Project context:**
{{BRIEF_PROJECT_DESCRIPTION}}

**This page's purpose:**
{{PAGE_PURPOSE}}

**Design contract (from DESIGN.md):**
- Color system: {{COLOR_SUMMARY}}
- Typography: {{TYPOGRAPHY_SUMMARY}}
- Spacing: {{SPACING_SUMMARY}}
- Component styles: {{COMPONENT_SUMMARY}}
- Layout pattern: {{LAYOUT_PATTERN}}

**Navigation context:**
- How the user arrives at this page: {{ENTRY_POINT}}
- Navigation elements to include: {{NAV_ELEMENTS}}
- Shared header/sidebar from: {{REFERENCE_SCREEN}}

**Content for this page:**
{{LIST_OF_CONTENT_ELEMENTS}}

**Constraints:**
- Must match the visual identity established in the canonical screen
- Must use the exact color, typography, and spacing values from DESIGN.md
- {{ADDITIONAL_CONSTRAINTS}}

**Reference screen for consistency:**
Use screen "{{CANONICAL_SCREEN_NAME}}" (ID: {{CANONICAL_SCREEN_ID}}) as the visual reference for shared elements (navigation, header, footer, etc.).
```

## After Generation

1. Review for design contract conformance
2. Save screenshot to `.stitch/designs/images/{{page-name}}.png`
3. Export HTML to `.stitch/designs/html/{{page-name}}.html`
4. Update `metadata.json` with screen record
5. Update `SITE.md` page status
6. Write the next baton in `next-prompt.md`
