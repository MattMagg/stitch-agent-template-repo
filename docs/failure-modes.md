# Failure Modes

Common issues and how to recover from them.

## Design Phase Failures

### Stitch generates something that doesn't match the design contract

**Symptoms**: Colors, typography, or layout don't match `DESIGN.md`.

**Recovery**:
1. Use `.stitch/prompts/direct-edit.md` with explicit `DESIGN.md` values quoted in the prompt
2. Be more specific — include exact hex codes, font sizes, spacing values
3. If repeated failures, create a variant and select the closest match

### Screen quality is poor after multiple iterations

**Symptoms**: Three+ rounds of edits haven't produced an acceptable result.

**Recovery**:
1. Stop iterating on the current screen
2. Start fresh with a new prompt — sometimes a clean start works better than incremental fixes
3. Consider using redesign-from-reference with a working screen as the reference
4. Check if the prompt is too complex — simplify and split into smaller pieces

### Design drift between pages

**Symptoms**: New pages don't visually match the canonical screen.

**Recovery**:
1. Check that `DESIGN.md` is included in prompts
2. Reference the canonical screen ID explicitly in next-page prompts
3. Compare screenshots side-by-side
4. If drift is intentional, update `DESIGN.md` and note the decision

## Sync & State Failures

### Stitch is temporarily unavailable

**Symptoms**: MCP connection fails, Stitch UI is down.

**Recovery**:
1. You can still work from local artifacts
2. Review screenshots in `.stitch/designs/images/`
3. Proceed with implementation using existing artifacts
4. Queue design work for when Stitch is available again

### metadata.json is out of sync

**Symptoms**: Screen IDs in metadata don't match Stitch, timestamps are stale.

**Recovery**:
1. Use MCP `list_screens` to get current state
2. Reconcile against `metadata.json`
3. Update the local file with current values
4. Add a note in `.stitch/logs/`

### Forgot to sync artifacts before continuing

**Symptoms**: Approved screen exists in Stitch but not locally.

**Recovery**:
1. Go back and sync before continuing
2. Screenshot the screen and save locally
3. Update `metadata.json`
4. Don't skip this step again — the local copy is the safety net

## Implementation Failures

### Local implementation doesn't match the design

**Symptoms**: Visual comparison shows differences.

**Recovery**:
1. Check design token values against `DESIGN.md`
2. Open the screenshot and the local implementation side by side
3. Fix specific differences rather than rewriting from scratch
4. Common issues: wrong spacing, missing hover states, incorrect border-radius

### Exported HTML doesn't work in the local framework

**Symptoms**: Stitch HTML has structure/styles that conflict with the project.

**Recovery**:
1. Remember: exported HTML is a reference, not production code
2. Extract the CSS values you need
3. Rebuild the structure using your framework's patterns
4. Use the screenshot as the visual target, not the HTML structure

## Workflow Failures

### Lost track of where I am in the workflow

**Symptoms**: Not sure which page is next, what's been approved, what's been implemented.

**Recovery**:
1. Check `SITE.md` — it should have current page statuses
2. Check `next-prompt.md` — it should have the next task
3. Check `metadata.json` — it should have screen records
4. If any of these are stale, update them before continuing

### Baton file is stale or missing

**Symptoms**: `next-prompt.md` doesn't reflect the current state.

**Recovery**:
1. Check `SITE.md` for the next recommended surface
2. Write a fresh baton based on current state
3. Don't continue without a baton — it prevents drift
