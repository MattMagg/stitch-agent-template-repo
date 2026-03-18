# Prompt: Direct Edit / Refinement

> Make targeted changes to an existing screen without redesigning it from scratch.

## When to Use

- When a screen is mostly right but needs specific adjustments
- When fixing visual issues, alignment, or content updates
- When iterating after an initial review

## Template

```
Edit the screen "{{SCREEN_NAME}}" (ID: {{SCREEN_ID}}).

**Changes needed:**
1. {{CHANGE_1}}
2. {{CHANGE_2}}
3. {{CHANGE_3}}

**Keep unchanged:**
- {{PRESERVE_1 — e.g., overall layout structure}}
- {{PRESERVE_2 — e.g., color scheme}}
- {{PRESERVE_3 — e.g., typography}}

**Design contract reference:**
These changes must still conform to DESIGN.md:
- {{RELEVANT_CONSTRAINT_1}}
- {{RELEVANT_CONSTRAINT_2}}
```

## Tips

- Be specific about what to change and what to preserve
- Reference exact elements (e.g., "the sidebar navigation" not "the left side")
- If the change is visual, describe the desired end state, not just "make it better"
- Small, focused edits produce better results than long lists of changes
