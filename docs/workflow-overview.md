# Workflow Overview

This document describes the end-to-end workflow for going from Stitch-based design to a maintainable local UI codebase.

## The Eight Phases

### Phase 1: Reference Capture

**Goal**: Collect visual inspiration before designing anything.

**Actions**:
1. Screenshot designs you admire or want to reference
2. Save them to `.stitch/references/screenshots/`
3. Document what you like about each in `.stitch/references/notes.md`

**Output**: Populated `.stitch/references/` directory.

### Phase 2: Canonical Screen Creation

**Goal**: Create one or two strong representative screens that set the visual identity.

**Actions**:
1. Use `.stitch/prompts/canonical-screen.md` to write your prompt
2. Create the screen in Stitch (via MCP or directly)
3. Iterate with direct edits until the screen feels right
4. Do NOT try to design the whole app at once

**Output**: Approved canonical screen(s) in Stitch.

**Key principle**: Incremental over monolithic. One strong screen is worth more than ten mediocre ones.

### Phase 3: Design Contract Extraction

**Goal**: Convert the approved canonical screen into a durable local style authority.

**Actions**:
1. Use `.stitch/prompts/design-contract-extraction.md`
2. Populate `.stitch/DESIGN.md` with extracted values
3. Review for completeness — fill gaps with intentional decisions

**Output**: Populated `.stitch/DESIGN.md`.

**Key principle**: `DESIGN.md` is the style authority. Future screens must conform to it.

### Phase 4: Planning & Inventory

**Goal**: Map out all surfaces and set priorities.

**Actions**:
1. List every page, view, or major surface in `.stitch/SITE.md`
2. Set priorities (P0/P1/P2)
3. Identify dependencies between pages
4. Note the recommended next surface

**Output**: Populated `.stitch/SITE.md`.

### Phase 5: Baton-Driven Continuation

**Goal**: Generate one page at a time using the baton loop.

**Actions**:
1. Write the next task in `.stitch/next-prompt.md`
2. Use the appropriate prompt template from `.stitch/prompts/`
3. Create the screen in Stitch
4. Review for design contract conformance
5. When approved, move to Phase 6

**Output**: New screen in Stitch, baton completed.

**Key principle**: One page per iteration. Complete → sync → baton → next.

### Phase 6: Artifact Sync

**Goal**: Persist design artifacts locally immediately after approval.

**Actions**:
1. Screenshot to `.stitch/designs/images/`
2. Export HTML to `.stitch/designs/html/` (if applicable)
3. Save other exports to `.stitch/designs/exports/`
4. Update `metadata.json` with screen record and artifact paths
5. Update `SITE.md` page status

**Output**: Local artifacts synced, metadata updated.

### Phase 7: Implementation Handoff

**Goal**: Translate approved designs into local UI code.

**Actions**:
1. Complete the handoff checklist (`.stitch/checklists/handoff.md`)
2. Use `.stitch/prompts/implementation-handoff.md`
3. Build components in `src/components/`
4. Build pages in `src/pages/`
5. Reference the design artifacts, not just memory

**Output**: Working local implementation in `src/`.

**Key principle**: Exported HTML is a reference. Adapt it to your architecture and standards.

### Phase 8: Validation

**Goal**: Confirm readiness before continuing.

**Actions**:
1. Run the readiness checklist (`.stitch/checklists/readiness.md`)
2. Verify visual match between implementation and approved design
3. Update `SITE.md` status
4. Write the next baton or close the loop

**Output**: Validated surface, ready for the next iteration.

## Iteration Cycle

After the initial setup (Phases 1-4), the ongoing cycle is:

```
Phase 5 (baton) → Phase 6 (sync) → Phase 7 (implement) → Phase 8 (validate) → Phase 5 (next baton)
```

Repeat until all surfaces in `SITE.md` are implemented.

## When Things Go Wrong

See [Failure Modes](failure-modes.md) for common issues and recovery steps.
