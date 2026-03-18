# Prompt: Asset Restyling

> Restyle or regenerate visual assets (images, illustrations, icons) to match the project's design contract.

## When to Use

- When placeholder images need to be replaced with styled versions
- When visual assets from a reference don't match the project's aesthetic
- When generating custom illustrations or imagery for specific pages
- When icon styles need to be unified

## Template

```
Restyle the following asset(s) for the "{{PAGE_NAME}}" page to match the project's design contract.

**Asset(s) to restyle:**
- {{ASSET_DESCRIPTION — e.g., hero illustration, profile placeholder, background pattern}}

**Current state:**
{{DESCRIBE_CURRENT — e.g., generic stock photo, placeholder rectangle, mismatched icon set}}

**Design contract guidance (from DESIGN.md):**
- Imagery style: {{IMAGERY_RULES}}
- Color palette: {{COLOR_RULES}}
- Atmosphere: {{ATMOSPHERE}}
- Art direction: {{ART_DIRECTION_NOTES}}

**Target output:**
- Format: {{FORMAT — png / svg / webp}}
- Dimensions: {{DIMENSIONS}}
- Usage context: {{WHERE_IT_WILL_BE_USED}}

**Constraints:**
- {{CONSTRAINT_1 — e.g., must work on dark background}}
- {{CONSTRAINT_2 — e.g., no photorealistic images, illustration only}}
- {{CONSTRAINT_3 — e.g., must feel cohesive with other page assets}}
```

## After Restyling

1. Save new asset(s) to `src/assets/` (for implementation) and `.stitch/designs/images/` (for record)
2. Verify visual consistency with the overall design
3. Update any references in implementation code
