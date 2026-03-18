# Prompt: Design Contract Extraction

> Extract a structured design contract from an approved canonical screen into `DESIGN.md`.

## When to Use

- After approving the first canonical screen(s)
- When resetting or significantly updating the design direction
- When `DESIGN.md` needs to be re-derived from current screens

## Template

```
Analyze the approved screen "{{SCREEN_NAME}}" (ID: {{SCREEN_ID}}) and extract a comprehensive design contract.

Extract and document the following:

1. **Color system** — every color used, organized by role (background, surface, primary, secondary, accent, text, border, status colors). Include exact hex/HSL values.

2. **Typography** — all font families, weights, sizes, line heights, and letter spacing. Organize by role (display, h1-h3, body, caption, button, code).

3. **Spacing** — the spacing scale used, section padding, card padding, element gaps.

4. **Geometry** — border-radius values for each element type (buttons, cards, inputs, modals, avatars, badges).

5. **Elevation** — shadow values and when they're used.

6. **Component styles** — button variants, input styles, card styles, table styles, navigation patterns.

7. **Layout patterns** — grid system, max widths, sidebar behavior, header behavior.

8. **Motion/interaction** — any transitions, hover effects, or animations visible.

9. **Atmosphere** — overall mood, visual density, temperature (warm/cool), weight (airy/grounded).

Format the output to match the structure of `.stitch/DESIGN.md`.
```

## After Extraction

1. Populate `DESIGN.md` with the extracted values
2. Increment the contract version in `DESIGN.md` and `metadata.json`
3. Record the extraction source screen ID
4. Review for completeness — fill gaps with intentional decisions, not guesses
