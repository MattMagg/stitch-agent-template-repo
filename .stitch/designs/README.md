# Design Artifacts

Persisted design outputs from Stitch. Sync artifacts here immediately after generation or approval.

## Directories

| Directory | Contents |
|---|---|
| `html/` | Exported HTML from Stitch screens |
| `images/` | Screenshots and rendered images of approved screens |
| `exports/` | Other exports — CSS, SVGs, design tokens, etc. |

## Sync Rules

1. **Sync immediately** after generating or approving a screen in Stitch
2. **Name files by page/surface**, not by Stitch ID (e.g., `dashboard-overview.png`, not `screen-abc123.png`)
3. **Update `metadata.json`** with artifact paths after syncing
4. **Never delete without replacing** — keep the latest approved version available locally

## File Naming

```
{surface-name}.{ext}
{surface-name}-v{N}.{ext}     ← if keeping versions
{surface-name}-mobile.{ext}   ← for breakpoint variants
```
