# `.stitch/` — Operational State Center

This directory is the local source of truth for all Stitch-driven design work. Every file here serves a specific role in the design-to-implementation workflow.

## Contents

| File / Directory | Role |
|---|---|
| `DESIGN.md` | **Design contract** — the authoritative local style reference for all pages and surfaces |
| `SITE.md` | **Site plan** — surface inventory, page status, roadmap, and next priorities |
| `metadata.json` | **Machine state** — project IDs, screen records, sync timestamps, baton bookkeeping |
| `next-prompt.md` | **Baton file** — the next bounded task to execute (one page/surface at a time) |
| `references/` | Reference screenshots, inspiration captures, and design notes |
| `designs/` | Persisted design artifacts — exported HTML, screenshots, images |
| `prompts/` | Reusable prompt templates for each workflow stage |
| `logs/` | Session logs and decision records |
| `checklists/` | Readiness and handoff validation checklists |

## Principles

1. **Local-first**: This directory is the durable source of truth. Remote Stitch state is a working tool, not the record of truth.
2. **Commit this directory**: `.stitch/` is meant to be version-controlled. It contains no secrets.
3. **One baton at a time**: `next-prompt.md` drives exactly one bounded iteration. Complete it, then write the next one.
4. **Design contract authority**: `DESIGN.md` is the style contract. All future pages must conform to it.
5. **Sync immediately**: After generating or approving a screen in Stitch, persist artifacts locally in `designs/` before continuing.

## File Dependencies

```
references/ → informs → canonical screen creation
canonical screen → extracts → DESIGN.md
DESIGN.md + SITE.md → drives → next-prompt.md
next-prompt.md → generates → new screen in Stitch
new screen → syncs to → designs/
designs/ → translates to → src/ (implementation)
```
