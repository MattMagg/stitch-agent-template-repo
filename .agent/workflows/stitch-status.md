---
description: Show current workflow state — read-only status report
---

# `/stitch-status` — Show Current Workflow State

Use this workflow to get a comprehensive status report of the current project. Reads all `.stitch/` state files and reports the current phase, surface inventory, pending work, and next recommended action. **This workflow makes no modifications** — it is read-only.

**Reference docs**: See `docs/workflow-overview.md` for the full eight-phase lifecycle context. See `docs/failure-modes.md` → "Lost track of where I am" for state recovery guidance.

## Pre-Flight Checks

// turbo
1. Verify the `.stitch/` directory exists:
   ```
   ls .stitch/metadata.json .stitch/DESIGN.md .stitch/SITE.md .stitch/next-prompt.md
   ```
   If any files are missing, note them in the report.

## Execution Steps

### Step 1: Read Project State

// turbo
2. Read `.stitch/metadata.json` and extract:
   - `projectName` — the project identity
   - `workflowPhase` — current lifecycle phase
   - `stitchProjects[]` — linked Stitch project(s) and IDs
   - `screens[]` — all screen records with their statuses
   - `designContract` — version, source screen, extraction date
   - `baton` — current baton target and phase
   - `syncLog[]` — recent sync activity

### Step 2: Read Design Contract Status

// turbo
3. Read `.stitch/DESIGN.md` and determine:
   - Is it populated or still template-only?
   - What is the contract version? (check footer)
   - When was it last extracted? (check footer)

### Step 3: Read Site Plan

// turbo
4. Read `.stitch/SITE.md` and extract:
   - **Target Surfaces** table — all surfaces with their statuses
   - **Completion Summary** — counts by status (planned, in-design, approved, implemented, deferred)
   - **Next Recommended Page** — what's queued next
   - **Open Design Tasks** — pending items
   - **Risks & Uncertainties** — anything flagged

### Step 4: Read Current Baton

// turbo
5. Read `.stitch/next-prompt.md` and determine:
   - Is a baton active? (has non-template content)
   - What is the task name and type?
   - What is the target surface?
   - What is the baton status? (pending, active, complete)

### Step 5: Check for Stale State

// turbo
6. Cross-reference the state files for consistency:
   - Do `metadata.json` screens match `SITE.md` surfaces?
   - Does `metadata.json` `workflowPhase` align with actual progress?
   - Are there screens in Stitch (if MCP available) that aren't in `metadata.json`?
   - Is the baton target consistent with `SITE.md` next page?

### Step 6: Generate Report

7. Compile and present the status report to the user:

```
## Project Status: {projectName}

### Current Phase
- **Workflow phase**: {workflowPhase}
- **Active baton**: {baton task name or "none"}

### Design Contract
- **Status**: {populated | empty}
- **Version**: {version}
- **Last extracted from**: {screen name/ID}
- **Extraction date**: {date}

### Surface Inventory
| Surface | Status | Design Approved | Implemented |
|---------|--------|-----------------|-------------|
| {name}  | {status} | {yes/no}      | {yes/no}    |

### Completion Summary
- Planned: {n}
- In Design: {n}
- Approved: {n}
- Implemented: {n}
- Deferred: {n}
- **Total**: {n}

### Stitch Projects
- {project title} (ID: {id}) — {n} screens

### Recent Activity
- {last 5 sync log entries}

### Consistency Checks
- ✅/⚠️ metadata.json ↔ SITE.md alignment
- ✅/⚠️ Workflow phase matches actual progress
- ✅/⚠️ Baton target matches SITE.md next page

### Next Recommended Action
- {recommendation based on current state}
```

### Step 7: Recommend Next Action

8. Based on the current state, recommend the appropriate workflow:

| State | Recommendation |
|---|---|
| No project name | Run `/stitch-init` |
| No canonical screen | Run `/stitch-design` (canonical) |
| No design contract (v0) | Run `/stitch-contract` |
| No site plan | Complete Phase 4 in `/stitch-init` |
| Baton pending | Run `/stitch-design` |
| Approved screens unsynced | Run `/stitch-sync` |
| Approved screens not implemented | Run `/stitch-implement` |
| All surfaces implemented | Project may be complete 🎉 |
| Consistency issues found | Address specific issues noted |

## Post-Completion

This is a read-only workflow. No files are modified.

- [ ] Status report presented to user
- [ ] Consistency checks run
- [ ] Next action recommended

## Error Handling

- **Missing `.stitch/` files**: Report which files are missing and recommend running `/stitch-init` to set up the project.
- **`metadata.json` is malformed**: Report the parse error and suggest restoring from version control or re-initializing.
- **Inconsistent state between files**: Report the specific inconsistencies in the Consistency Checks section. Do not attempt to auto-fix — let the user decide how to resolve.
- **MCP unavailable for remote comparison**: Skip the remote comparison step. Report status based on local state only and note that remote state was not checked.
