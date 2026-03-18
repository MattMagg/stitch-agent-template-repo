---
description: "Handoff prompt for a new agent session to create project-level .agent/workflows/ for the stitch-agent-template-repo"
---

# Handoff: Create Stitch Template Operational Workflows

You are a workflow engineer creating agent-discoverable operational workflows for a Stitch-to-local UI template repository. Your output will be a set of `.agent/workflows/*.md` files that agents can discover and execute via slash commands.

---

## Context: What This Repository Is

The repository at `/Users/macmain/stitch-agent-template-repo` is a **reusable starter template** for going from Stitch-based design work to a maintainable local UI codebase. Stitch is Google's AI-powered UI design tool, accessed via MCP (Model Context Protocol).

The template works for websites, landing pages, dashboards, authenticated web apps, and general UI systems. It is model-agnostic, platform-agnostic, and agent-host-agnostic.

### Core Design Principles

1. **Local-first**: All durable state lives in the repository, not in remote tools. The repository is the source of truth.
2. **Incremental design**: One page at a time via a baton loop — never giant app-wide prompts.
3. **Design contract authority**: `.stitch/DESIGN.md` is the single style source of truth for all pages.
4. **Baton-driven continuation**: `.stitch/next-prompt.md` drives one bounded iteration at a time, preventing drift.
5. **Sync immediately**: After generating or approving a screen in Stitch, persist artifacts locally before continuing.
6. **Exported HTML is reference, not production code**: Stitch exports are inputs to implementation, not the final shipped code.

---

## Context: Repository Structure

```
.stitch/                          ← Operational state center
├── README.md                     ← Directory guide
├── DESIGN.md                     ← Design contract template (18 sections: identity, atmosphere, colors, typography, spacing, geometry, elevation, iconography, imagery, layout, navigation, component styles, motion, responsive, implementation notes, forbidden patterns)
├── SITE.md                       ← Site planning template (summary, target surfaces, sitemap, page inventory, completion tracking, dependencies, open tasks, next page, deferred items, risks)
├── metadata.json                 ← Machine-readable state (projectName, slug, stitchProjects[], screens[], designContract version, baton state, workflowPhase, syncLog)
├── next-prompt.md                ← Baton file (task name, type, target surface, required inputs, design contract constraints, acceptance criteria, expected outputs, follow-up)
├── references/                   ← Screenshots, notes.md, inspiration captures
├── designs/                      ← Synced artifacts (html/, images/, exports/)
├── prompts/                      ← 8 reusable prompt templates:
│   ├── canonical-screen.md       ← Create representative screens
│   ├── redesign-from-reference.md ← Reference-driven redesign
│   ├── direct-edit.md            ← Targeted refinement
│   ├── variants.md               ← Controlled variant generation
│   ├── design-contract-extraction.md ← Extract DESIGN.md from screens
│   ├── next-page.md              ← Baton-driven next surface
│   ├── implementation-handoff.md ← Design to code translation
│   └── asset-restyling.md        ← Imagery/asset refinement
├── logs/                         ← Decision records
└── checklists/                   ← readiness.md, handoff.md

docs/                             ← 9 operational guides
├── workflow-overview.md          ← End-to-end 8-phase workflow
├── stitching-workflow.md         ← Working with Stitch specifically
├── prompting-guide.md            ← Writing effective prompts
├── design-contract-guide.md      ← Creating/maintaining DESIGN.md
├── baton-loop-guide.md           ← Page-by-page continuation
├── implementation-handoff-guide.md ← Design to code
├── sync-strategy.md              ← Artifact syncing
├── failure-modes.md              ← Common issues and recovery
└── extension-guide.md            ← Customizing the template

tools/stitch/                     ← 3 shell script stubs (sync, extract-contract, export)
integrations/optional/mcp/        ← MCP docs + example config (isolated, non-core)
src/                              ← Framework-agnostic UI target (app/, components/, pages/, styles/, assets/)
templates/ui/                     ← Reusable UI snippets
plans/                            ← Implementation plan template
prompts/                          ← Root-level prompt extension point
```

---

## Context: The Eight-Phase Workflow

The template supports this workflow end-to-end:

| Phase | Name | Key Files | Key Actions |
|-------|------|-----------|-------------|
| 1 | Reference Capture | `.stitch/references/` | Collect screenshots, inspiration, notes |
| 2 | Canonical Screen Creation | `.stitch/prompts/canonical-screen.md` | Create 1-2 representative screens in Stitch via MCP |
| 3 | Design Contract Extraction | `.stitch/DESIGN.md` | Extract style rules from canonical screen into DESIGN.md |
| 4 | Planning & Inventory | `.stitch/SITE.md` | Map all surfaces, set priorities, identify dependencies |
| 5 | Baton-Driven Continuation | `.stitch/next-prompt.md` | Write bounded task → generate one page → review → approve |
| 6 | Artifact Sync | `.stitch/designs/` | Persist screenshots, HTML, exports locally; update metadata.json |
| 7 | Implementation Handoff | `src/` | Translate approved designs to local UI code |
| 8 | Validation | `.stitch/checklists/` | Confirm readiness before continuing |

The ongoing iteration cycle is: Phase 5 → 6 → 7 → 8 → 5 (repeat).

---

## Context: Available MCP Tools (Stitch)

The agent has access to these Stitch MCP tools:

| Tool | Parameters | Use |
|------|-----------|-----|
| `create_project` | title | Create a new Stitch project |
| `get_project` | name (format: `projects/{id}`) | Get project details |
| `list_projects` | filter (optional) | List accessible projects |
| `list_screens` | projectId | List screens in a project |
| `get_screen` | name, projectId, screenId | Get screen details |
| `generate_screen_from_text` | projectId, prompt, deviceType, modelId | Generate a new screen from text |
| `edit_screens` | projectId, selectedScreenIds[], prompt, deviceType, modelId | Edit existing screens |
| `generate_variants` | projectId, selectedScreenIds[], prompt, variantOptions, deviceType, modelId | Generate screen variants |

**Device types**: `MOBILE`, `DESKTOP`, `TABLET`, `AGNOSTIC`
**Model IDs**: `GEMINI_3_PRO`, `GEMINI_3_FLASH`, `GEMINI_3_1_PRO`

---

## Context: The Gap This Task Fills

The repository currently has all the data structures, documentation, and templates — but **no agent-discoverable workflow routing**. An agent landing in this repo cold would not know:

- What to do first
- How to determine the current workflow state
- Which MCP tools to call and in what order
- How to decide between design continuation vs. implementation
- How to execute the baton loop automatically

The `.agent/workflows/` directory needs operational workflows that agents can discover via slash commands and execute with minimal user instruction.

---

## Your Task

Create a complete set of `.agent/workflows/*.md` files in the repository's `.agent/workflows/` directory. Each workflow must:

1. Have YAML frontmatter with a `description` field
2. Include state-detection logic (check `metadata.json`, `DESIGN.md`, `SITE.md`, `next-prompt.md` to determine current state)
3. Include specific MCP tool calls where appropriate
4. Reference the correct `.stitch/prompts/` template for each operation
5. Include pre-flight checks (what must exist before this workflow can run)
6. Include post-completion steps (what to update after the workflow completes)
7. Be self-contained enough that an agent with no prior context can execute them

### Required Workflows

At minimum, create workflows for these operations:

#### 1. `/stitch-init` — Initialize a New Project
- Determine if this is a fresh start or continuation
- Check `metadata.json` for existing state
- If fresh: guide through reference capture → canonical screen creation → design contract extraction → site planning
- If continuing: detect current phase and resume
- Connect to Stitch via MCP, create or link a project
- Update `metadata.json`

#### 2. `/stitch-design` — Create or Edit a Screen
- Check the baton (`next-prompt.md`) for the current task
- If no baton exists, check `SITE.md` for the next recommended surface
- Select the right prompt template based on task type (canonical, next-page, redesign, edit, variant)
- Execute the Stitch MCP tool with the prepared prompt
- Guide through review and approval
- Sync artifacts locally after approval
- Update `metadata.json` and `SITE.md`
- Write the next baton

#### 3. `/stitch-sync` — Sync Artifacts from Stitch
- List screens in the Stitch project via MCP
- Compare against `metadata.json` to find unsynced screens
- For each unsynced screen: get details, capture screenshot, save locally
- Update `metadata.json` with current state
- Update `SITE.md` page statuses

#### 4. `/stitch-contract` — Extract or Update Design Contract
- Identify the source screen(s) for extraction
- Use the `design-contract-extraction.md` prompt template
- Analyze the screen and populate `DESIGN.md`
- Increment the design contract version
- Update `metadata.json`

#### 5. `/stitch-implement` — Implementation Handoff
- Run the handoff checklist (`.stitch/checklists/handoff.md`)
- Identify the target surface and its design artifacts
- Use the `implementation-handoff.md` prompt template
- Translate the design into local code in `src/`
- Extract reusable components
- Apply design tokens from `DESIGN.md`
- Update `SITE.md` status to "implemented"

#### 6. `/stitch-status` — Show Current Workflow State
- Read `metadata.json` for project and screen state
- Read `SITE.md` for surface inventory and completion
- Read `next-prompt.md` for the current baton
- Read `DESIGN.md` to check if design contract exists
- Report: current phase, completed surfaces, pending surfaces, next recommended action
- No modifications — read-only status report

#### 7. `/stitch-next` — Advance to Next Page
- Check readiness via `.stitch/checklists/readiness.md`
- Identify the next surface from `SITE.md`
- Prepare `next-prompt.md` with the bounded task
- Include design contract constraints from `DESIGN.md`
- Set acceptance criteria
- Hand off to `/stitch-design` or report what's ready

### Optional Workflows (create if time/context permits)

- `/stitch-variants` — Generate and compare design variants for a specific screen
- `/stitch-reset` — Reset the template for a new project (clear state files, keep structure)

---

## Workflow Format Requirements

Each workflow file must follow this structure:

```markdown
---
description: [One-line description of what this workflow does]
---

# [Workflow Name]

[Brief description of when and why to use this workflow]

## Pre-Flight Checks

[What the agent must verify before executing — file existence, state conditions, MCP connectivity]

## Execution Steps

[Numbered steps the agent follows, including:
- State detection (read files, check conditions)
- Decision logic (if/then based on current state)
- MCP tool calls (with specific tool names and parameter guidance)
- File operations (what to read, write, update)
- User interaction points (when to show output, ask for approval)]

## Post-Completion

[What to update after the workflow completes — metadata.json, SITE.md, next-prompt.md, etc.]

## Error Handling

[What to do when things go wrong — MCP failures, missing files, conflicting state]
```

---

## Constraints

- Workflows must be agent-host agnostic — do not assume Cursor, VS Code, or any specific editor
- Workflows must work with the Stitch MCP tools listed above
- Workflows must read/write the `.stitch/` state files, not rely on conversation memory
- Workflows must not pre-fill project-specific answers — they are templates
- Keep workflows focused: each one does one thing well
- Include the `// turbo` annotation on safe read-only steps (listing files, reading state) to enable auto-run
- Reference existing `.stitch/prompts/` templates rather than duplicating their content
- Workflows should degrade gracefully when MCP is unavailable (fall back to manual steps)

---

## Validation

After creating all workflows, verify:

- [ ] Each workflow file has valid YAML frontmatter with a `description`
- [ ] Each workflow has pre-flight checks, execution steps, post-completion, and error handling
- [ ] State detection reads from `.stitch/` files (not conversation memory)
- [ ] MCP tool calls reference correct tool names and parameters
- [ ] Workflows cross-reference each other where appropriate (e.g., `/stitch-design` mentions `/stitch-sync`)
- [ ] An agent with no prior context can follow any workflow from start to finish
- [ ] The set of workflows covers the full eight-phase lifecycle

---

## Reference Files to Read

Before creating workflows, read these files to understand the system:

1. `.stitch/README.md` — Overview of the .stitch/ directory and file dependencies
2. `.stitch/metadata.json` — The machine-readable state schema
3. `.stitch/next-prompt.md` — The baton file structure
4. `.stitch/checklists/readiness.md` — Pre-continuation checklist
5. `.stitch/checklists/handoff.md` — Design-to-implementation checklist
6. `docs/workflow-overview.md` — The eight-phase workflow
7. `docs/stitching-workflow.md` — Stitch-specific operations and MCP tool mapping
8. `docs/baton-loop-guide.md` — How the baton loop works
9. `docs/sync-strategy.md` — Artifact syncing rules
