# Prompt: Controlled Variants

> Generate alternative versions of an existing screen to explore design options.

## When to Use

- When you want to see multiple approaches before committing
- When exploring color, layout, or density alternatives
- When a stakeholder wants options to compare

## Template

```
Generate {{NUMBER}} variants of the screen "{{SCREEN_NAME}}" (ID: {{SCREEN_ID}}).

**Variation focus:**
{{WHAT_SHOULD_VARY — e.g., layout density, color treatment, card arrangement}}

**Hold constant:**
- {{CONSTANT_1 — e.g., overall page structure}}
- {{CONSTANT_2 — e.g., content elements}}
- {{CONSTANT_3 — e.g., navigation pattern}}

**Variant directions:**
- Variant A: {{DIRECTION_A — e.g., more compact, denser information}}
- Variant B: {{DIRECTION_B — e.g., more spacious, editorial feel}}
- Variant C: {{DIRECTION_C — e.g., darker tone, higher contrast}}

**Design contract constraints:**
All variants must conform to DESIGN.md:
- {{CONSTRAINT_1}}
- {{CONSTRAINT_2}}
```

## After Generation

1. Screenshot each variant to `.stitch/designs/images/{{surface-name}}-variant-{a,b,c}.png`
2. Select the winning variant
3. Record the decision in `.stitch/logs/`
4. If the selected variant shifts the design language, update `DESIGN.md`
