# Stitch Agent Template Repository

A reusable starter template for going from Stitch-based design work to a maintainable local UI codebase.

## What This Is

This repository is a project scaffold for UI design-to-implementation workflows using [Stitch](https://stitch.google.com) as the design tool and MCP as the integration boundary. Copy or initialize this template whenever starting a new:

- Website or landing page
- Dashboard
- Authenticated web app
- General UI system

## Core Principles

- **Local-first**: All durable state lives in this repository, not in remote tools
- **Incremental design**: One page at a time, not giant app-wide prompts
- **Design contract authority**: `.stitch/DESIGN.md` is the style source of truth
- **Baton-driven continuation**: `.stitch/next-prompt.md` drives bounded iterations
- **Model/platform/host agnostic**: No lock-in to any specific AI model, editor, or platform

## Quick Start

1. **Copy this template** to a new project directory
2. **Collect references** in `.stitch/references/`
3. **Create a canonical screen** in Stitch using `.stitch/prompts/canonical-screen.md`
4. **Extract the design contract** into `.stitch/DESIGN.md`
5. **Plan your surfaces** in `.stitch/SITE.md`
6. **Write the first baton** in `.stitch/next-prompt.md`
7. **Iterate** page by page, syncing artifacts locally after each step
8. **Implement** using `.stitch/prompts/implementation-handoff.md`

## Directory Overview

```
.stitch/              ← Operational state center (design contract, plans, artifacts, prompts)
docs/                 ← Workflow documentation and guides
tools/                ← Automation stubs for sync, export, extraction
integrations/         ← Optional host-specific integrations (MCP configs, etc.)
src/                  ← Framework-agnostic UI implementation target
templates/            ← Reusable UI template snippets
plans/                ← Project-level implementation planning
prompts/              ← Root-level prompt collection (optional extension point)
```

### `.stitch/` — The Heart of the Workflow

| File | Purpose |
|---|---|
| `DESIGN.md` | Design contract — the style source of truth |
| `SITE.md` | Site plan — surface inventory and roadmap |
| `metadata.json` | Machine-readable operational state |
| `next-prompt.md` | Baton file — next bounded task |
| `references/` | Inspiration screenshots and notes |
| `designs/` | Persisted design artifacts (HTML, images, exports) |
| `prompts/` | Reusable prompt templates for each workflow stage |
| `checklists/` | Readiness and handoff validation |
| `logs/` | Session decision records |

## Workflow Phases

1. **Reference capture** → `.stitch/references/`
2. **Canonical screen creation** → Stitch + `.stitch/prompts/canonical-screen.md`
3. **Design contract extraction** → `.stitch/DESIGN.md`
4. **Planning & inventory** → `.stitch/SITE.md`
5. **Baton-driven continuation** → `.stitch/next-prompt.md` → one page at a time
6. **Artifact sync** → `.stitch/designs/`
7. **Implementation handoff** → `src/`
8. **Validation** → `.stitch/checklists/`

See `docs/workflow-overview.md` for the full guide.

## Documentation

| Guide | Topic |
|---|---|
| [Workflow Overview](docs/workflow-overview.md) | End-to-end workflow |
| [Stitching Workflow](docs/stitching-workflow.md) | Working with Stitch specifically |
| [Prompting Guide](docs/prompting-guide.md) | How to write effective prompts |
| [Design Contract Guide](docs/design-contract-guide.md) | Creating and maintaining DESIGN.md |
| [Baton Loop Guide](docs/baton-loop-guide.md) | Page-by-page continuation |
| [Implementation Handoff](docs/implementation-handoff-guide.md) | Design to code |
| [Sync Strategy](docs/sync-strategy.md) | Artifact syncing |
| [Failure Modes](docs/failure-modes.md) | Common issues and recovery |
| [Extension Guide](docs/extension-guide.md) | Customizing the template |

## For a New Project

1. Copy this template directory
2. Delete `.stitch/designs/` contents (keep the directory structure)
3. Clear `metadata.json` values (keep the schema)
4. Reset `SITE.md` and `DESIGN.md` to blank templates
5. Update `.env` with your project's configuration
6. Start at Phase 1: Reference Capture
