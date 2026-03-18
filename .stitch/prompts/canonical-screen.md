# Prompt: Canonical Screen Creation

> Create one or two strong representative screens that establish the visual identity for the entire project.

## When to Use

- At the start of a new project, before any other pages
- When the design direction needs to be established or reset

## Template

```
Create a {{DEVICE_TYPE}} screen for {{SURFACE_DESCRIPTION}}.

This is the canonical screen — the first and most important screen that will define the visual identity for the entire project.

**Project context:**
{{PROJECT_DESCRIPTION}}

**Target audience:**
{{AUDIENCE_DESCRIPTION}}

**Design direction:**
- Mood/atmosphere: {{MOOD}}
- Visual density: {{DENSITY — minimal / moderate / dense}}
- Color preference: {{COLOR_DIRECTION}}
- Typography preference: {{TYPOGRAPHY_DIRECTION}}

**This screen should include:**
{{LIST_OF_ELEMENTS}}

**Reference guidance:**
{{REFERENCE_NOTES — what to take from collected references, if any}}

**Constraints:**
- This screen sets the standard. Every future page will derive its style from this one.
- Prioritize visual cohesion and a strong, distinguishing identity over feature completeness.
```

## After Generation

1. Review the screen for overall visual quality and consistency
2. If approved, extract the design contract → use `design-contract-extraction.md`
3. Save screenshot to `.stitch/designs/images/`
4. Update `metadata.json` with screen record
5. Update `SITE.md` with page status
