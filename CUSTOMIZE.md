# Customize This Template

> **How to use this file**: After cloning this repo, paste the contents below into your AI coding agent (Cursor, Copilot, Windsurf, Gemini CLI, etc.) along with your answers to the questions in the **Your Project** section. The agent will adapt every template, doc, workflow, and prompt in this repo to fit your specific project.

---

## Your Project

Fill in these fields before handing this to your agent. Replace the placeholder values with your actual answers.

```yaml
# ── Identity ──
project_name: "My Project"
tagline: ""
project_type: ""          # website | landing-page | dashboard | web-app | marketing-site | docs-site | other
description: ""           # One sentence: what is this product?
target_audience: ""       # Who uses this?

# ── Design Direction ──
brand_personality: []     # 3-5 adjectives (e.g., bold, minimal, warm, playful, corporate)
visual_references: []     # URLs or descriptions of designs you admire
color_preferences: ""     # e.g., "dark mode, indigo/purple accent", or "light, earthy tones"
typography_preferences: "" # e.g., "Inter for UI, serif for headings", or "no preference"
mood: ""                  # e.g., "premium SaaS", "friendly consumer app", "data-dense dashboard"

# ── Surfaces ──
pages:                    # List every page/view/surface you need
  - name: ""
    type: ""              # page | modal | panel | overlay
    priority: ""          # P0 | P1 | P2
    description: ""
    # Repeat for each surface

# ── Tech Stack (for implementation phase) ──
framework: ""             # e.g., Next.js, Vite + React, Astro, plain HTML/CSS, SvelteKit, etc.
styling: ""               # e.g., Tailwind, vanilla CSS, CSS Modules, styled-components
component_library: ""     # e.g., none, shadcn/ui, Radix, Material UI
deployment: ""            # e.g., Vercel, Netlify, self-hosted, not decided yet

# ── Constraints ──
device_targets: []        # e.g., [desktop, mobile, tablet] or [desktop-only]
accessibility: ""         # e.g., "WCAG AA", "basic", "not a priority yet"
must_haves: []            # Non-negotiable features or patterns
must_not_have: []         # Explicit anti-patterns or things to avoid
```

---

## Agent Instructions

You are customizing a cloned Stitch-to-UI template repository for a specific project. The user has provided their project details above. Your job is to adapt every relevant file in this repo so it's ready for their project — no more generic placeholders.

### What to Read First

// turbo
1. Read `README.md` for repo overview.
2. Read `.stitch/README.md` for the operational state center.
3. Read `docs/workflow-overview.md` for the eight-phase lifecycle.
4. Read the user's filled-in **Your Project** section above.

### What to Customize

Work through each area below. For each file, replace generic template content with project-specific values from the user's answers. Preserve the document structure — only replace placeholders and example content.

---

#### 1. Project Identity

**Files to update:**

- **`README.md`** — Rewrite the project description, title, and "getting started" section to reflect this specific project. Keep the workflow documentation references.
- **`.stitch/metadata.json`** — Set `projectName`, `localSlug` (kebab-case of project name). Leave `stitchProjects`, `screens`, and `syncLog` empty (those get filled during the workflow). Set `workflowPhase` to `"init"`, `createdAt` and `updatedAt` to the current ISO timestamp.

---

#### 2. Design Contract

**File to update: `.stitch/DESIGN.md`**

Fill in what you can from the user's design direction:
- **Project Identity** section — name, tagline, personality, audience
- **Design Intent** — infer from mood and brand personality
- **Atmosphere & Tone** — infer mode (light/dark), temperature, weight from color and mood preferences
- **Color System** — if specific colors given, populate the palette; otherwise note the direction as guidance
- **Typography** — if preferences given, populate; otherwise note the direction
- **Forbidden Patterns** — populate from `must_not_have`

Leave sections that require a canonical screen (exact hex values, precise spacing, component-level styles) with a note like:
```
<!-- TO EXTRACT: Populate after canonical screen approval in Phase 3 -->
```

This distinguishes "not yet extracted" from "never filled in the template."

---

#### 3. Site Plan

**File to update: `.stitch/SITE.md`**

- **Project Summary** — fill from identity fields
- **Target Surfaces** table — populate from the `pages` list with names, types, priorities, all set to status `"planned"`
- **Sitemap** — create a text tree showing page hierarchy (infer logical grouping from the page list)
- **Page Inventory** — create a section for each page with empty status fields ready for use
- **Completion Summary** — set counts (all in "Planned")
- **Page Dependencies** — infer and document obvious dependencies (e.g., dashboard requires auth)
- **Next Recommended Page** — set to the highest-priority surface
- **Implementation Notes** — fill from tech stack fields

---

#### 4. First Baton

**File to update: `.stitch/next-prompt.md`**

Write the first baton targeting the canonical screen:
- **Name**: "Create Canonical Screen — {project name}"
- **Type**: `canonical-screen`
- **Surface**: the highest-priority P0 page (or the most visually representative one)
- **Required Inputs**: check off what's available (references, design direction)
- **Design Contract Constraints**: copy from what was filled in `DESIGN.md`
- **Acceptance Criteria**: project-specific criteria based on the design direction
- **Prompt to Use**: `.stitch/prompts/canonical-screen.md`
- **Status**: `pending`

---

#### 5. Reference Notes

**File to update: `.stitch/references/notes.md`**

If the user provided `visual_references`, document them:
- List each reference URL or description
- Note what the user likely admires about each (infer from brand personality and mood)
- If references are screenshot URLs, note that they should be saved to `.stitch/references/screenshots/`

---

#### 6. Implementation Target

**Files to update in `src/`:**

- **`src/README.md`** — Update with the chosen framework and tech stack
- If the framework choice implies a specific project structure (e.g., Next.js app router, Vite), note the expected structure but do NOT run any scaffolding commands — the user will do that during implementation phase

---

#### 7. Prompt Templates

**Files in `.stitch/prompts/` — light customization only:**

Do NOT rewrite the prompt templates. They are intentionally generic. But if the user has strong design direction that should be baked into every prompt (e.g., "always dark mode", "always use Inter font"), add a small project-specific addendum section at the bottom of each relevant template:

```markdown
---
## Project-Specific Defaults

<!-- These defaults apply to all screens in this project -->
- Mode: {dark/light}
- Primary font: {font}
- Device target: {device}
```

---

#### 8. Documentation

**File to update: `docs/workflow-overview.md`** (optional, light touch)

If the project type makes certain phases irrelevant (e.g., a single landing page doesn't need extensive site planning), add a brief note at the top:

```markdown
> **Project note**: This is a {project_type}. {any workflow simplifications, e.g., "Phase 4 (planning) is lightweight — there are only N surfaces."}
```

---

### What NOT to Change

- **Do not modify** `.agent/workflows/stitch-*.md` — these are operational workflows that work generically
- **Do not modify** `docs/` guides (except the optional note above) — they are reference documentation
- **Do not modify** `.stitch/checklists/` — they are validation checklists that work for any project
- **Do not modify** `tools/stitch/` — they are automation stubs
- **Do not run** framework scaffolding (`npx create-next-app`, etc.) — that's for the implementation phase
- **Do not fill in** design contract sections that require a canonical screen — mark them for Phase 3

### After Customization

Report to the user:
1. What was customized and with what values
2. What was left as "to extract after canonical screen" in `DESIGN.md`
3. The first baton that's ready in `next-prompt.md`
4. The recommended next step: "Run `/stitch-init` to connect Stitch and create your canonical screen"

---

## Quick Start After Customization

Once an agent has customized this repo for your project:

1. **Run `/stitch-init`** — connects to Stitch, creates your project, guides you through the canonical screen
2. **Run `/stitch-design`** — executes the baton (first screen design)
3. **Run `/stitch-contract`** — extracts the full design contract from your approved screen
4. **Run `/stitch-next`** — prepares the baton for the next page
5. **Repeat** `/stitch-design` → `/stitch-sync` → `/stitch-next` for each surface
6. **Run `/stitch-implement`** — translates approved designs into code
7. **Run `/stitch-status`** anytime to see where you are
