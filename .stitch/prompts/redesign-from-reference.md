# Prompt: Redesign from Reference

> Redesign or create a screen using visual references as the primary design input.

## When to Use

- When you have a strong reference design you want to adapt
- When prose descriptions alone aren't producing the desired aesthetic
- When adapting a competitor's or inspiration's visual approach to your brand

## Template

```
Redesign {{SURFACE_DESCRIPTION}} using the following reference(s) as visual input.

**Reference description:**
{{DESCRIBE_THE_REFERENCE — what it looks like, what elements to take from it}}

**What to adopt from the reference:**
- {{ELEMENT_1 — e.g., card layout and density}}
- {{ELEMENT_2 — e.g., sidebar navigation pattern}}
- {{ELEMENT_3 — e.g., color palette mood}}

**What to change from the reference:**
- {{CHANGE_1 — e.g., use our brand colors instead}}
- {{CHANGE_2 — e.g., different typography}}
- {{CHANGE_3 — e.g., add a header section}}

**Design contract constraints (from DESIGN.md):**
- Colors: {{COLOR_RULES}}
- Typography: {{TYPOGRAPHY_RULES}}
- Spacing: {{SPACING_RULES}}

**Content for this screen:**
{{LIST_OF_CONTENT_ELEMENTS}}
```

## Notes

- If your Stitch integration supports image input, attach the reference screenshot directly
- If it doesn't, describe the reference in enough detail that the model can infer the visual style
- Always apply your `DESIGN.md` constraints on top of the reference — the reference is inspiration, not spec
