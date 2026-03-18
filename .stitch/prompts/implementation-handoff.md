# Prompt: Implementation Handoff

> Translate an approved design artifact into local UI code.

## When to Use

- When a screen is approved and ready for implementation
- After the handoff checklist is complete
- When moving from design artifacts to production code

## Template

```
Translate the approved design for "{{PAGE_NAME}}" into local UI code.

**Design inputs:**
- Screenshot: `.stitch/designs/images/{{PAGE_NAME}}.png`
- Exported HTML: `.stitch/designs/html/{{PAGE_NAME}}.html` (reference only, not production code)
- Design contract: `.stitch/DESIGN.md`

**Implementation target:**
- Framework: {{FRAMEWORK — e.g., React, Vue, Svelte, vanilla HTML/CSS, Next.js}}
- Target directory: `src/pages/{{page-name}}/` or `src/app/{{route}}/`
- Style approach: {{STYLE_APPROACH — e.g., CSS modules, styled-components, vanilla CSS}}

**Requirements:**
1. Match the approved design visually
2. Use design tokens from DESIGN.md, not hardcoded values
3. Extract reusable components to `src/components/`
4. Implement all interactive states (hover, focus, active, disabled)
5. Include responsive behavior per DESIGN.md breakpoints
6. Use semantic HTML
7. Include accessibility basics (alt text, ARIA labels, keyboard navigation)

**Components to extract:**
- {{COMPONENT_1 — e.g., Sidebar navigation → src/components/Sidebar}}
- {{COMPONENT_2 — e.g., Stats card → src/components/StatsCard}}
- {{COMPONENT_3}}

**Data handling:**
- {{DATA_NOTE — e.g., use static placeholder data for now}}

**Important:**
The exported HTML from Stitch is a reference and starting point. It is NOT automatically production code. Adapt it to fit the project's architecture, component structure, and coding standards.
```

## After Implementation

1. Verify visual match against the approved design screenshot
2. Test all interactive states
3. Test responsive behavior at each breakpoint
4. Update `SITE.md` page status to "implemented"
5. Commit the implementation
