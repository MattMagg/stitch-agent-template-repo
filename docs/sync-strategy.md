# Sync Strategy

How and when to sync Stitch artifacts to the local repository.

## Core Rule

**Sync immediately after approval.** Never rely on Stitch as the durable record. The local repository is the source of truth.

## What to Sync

| Artifact | Local Path | When |
|---|---|---|
| Screenshot of approved screen | `.stitch/designs/images/{name}.png` | After every screen approval |
| HTML export | `.stitch/designs/html/{name}.html` | Before implementation handoff |
| Design exports (CSS, SVG, etc.) | `.stitch/designs/exports/` | As needed |
| Screen metadata (IDs, timestamps) | `.stitch/metadata.json` | After every screen creation/edit |

## How to Sync

### Manual (always available)

1. Screenshot the approved screen
2. Save to `.stitch/designs/images/` with a descriptive filename
3. If HTML export is available, download and save to `.stitch/designs/html/`
4. Update `metadata.json` with the screen record

### Using the Stitch MCP Tools

If MCP is configured:

1. Use `get_screen` to retrieve screen details
2. Use the screen metadata to record IDs and timestamps
3. Screenshots may need to be captured manually or through browser automation

### Using the Tool Stubs

The `tools/stitch/` directory contains shell script stubs you can customize:

- `sync-stub.sh` — placeholder for artifact sync automation
- `extract-contract-stub.sh` — placeholder for design contract extraction
- `export-stub.sh` — placeholder for export automation

These are starting points, not complete implementations.

## Naming Conventions

```
{surface-name}.{ext}              ← primary artifact
{surface-name}-v{N}.{ext}        ← versioned (if keeping history)
{surface-name}-mobile.{ext}      ← breakpoint variant
{surface-name}-variant-a.{ext}   ← design variant
```

Use surface names from `SITE.md`, not Stitch IDs.

## Metadata Update

After syncing, update `metadata.json`:

```json
{
  "screens": [
    {
      "screenId": "abc123",
      "name": "Dashboard Overview",
      "status": "approved",
      "localArtifacts": {
        "screenshot": ".stitch/designs/images/dashboard-overview.png",
        "html": ".stitch/designs/html/dashboard-overview.html"
      },
      "updatedAt": "2025-01-15T10:30:00Z"
    }
  ]
}
```

## Resilience

The workflow must continue even when:

- Stitch is temporarily unavailable
- Remote state is stale or incomplete
- Screenshots are the only artifact available (no HTML export)

Local artifacts are the fallback. If you have the screenshot and the design contract, you can always reconstruct or implement a page.
