# Stitching Workflow

How to work with Stitch specifically — creating screens, editing them, syncing artifacts, and integrating with the local workflow.

## Connecting to Stitch

Stitch can be accessed through:

1. **MCP (Model Context Protocol)** — the preferred integration boundary. See `integrations/optional/mcp/` for configuration examples.
2. **Direct Stitch UI** — use the Stitch web interface directly when MCP isn't available or for visual review.

The workflow works with either method. MCP enables automation; direct access works for manual operation.

## Creating Screens

### Available Operations (via MCP or direct)

| Operation | Prompt Template | MCP Tool |
|---|---|---|
| Create new screen | `canonical-screen.md` or `next-page.md` | `generate_screen_from_text` |
| Edit existing screen | `direct-edit.md` | `edit_screens` |
| Generate variants | `variants.md` | `generate_variants` |
| List screens | — | `list_screens` |
| Get screen details | — | `get_screen` |

### Screen Creation Flow

1. **Prepare your prompt** using a template from `.stitch/prompts/`
2. **Fill in placeholders** with your project-specific details
3. **Include design contract constraints** from `DESIGN.md`
4. **Create the screen** in Stitch
5. **Review the output** — does it match the design contract?
6. **Iterate with direct edits** if needed
7. **Approve** when the screen meets acceptance criteria

### Tips for Effective Screen Creation

- **Be specific about layout**: "3-column grid with sidebar" not "a nice layout"
- **Reference the canonical screen** for consistency on subsequent pages
- **Include content**: Provide actual or realistic placeholder content, not lorem ipsum
- **Specify device type**: Desktop (1280×1024) is the common default
- **One screen per prompt**: Don't ask for multiple unrelated screens

## Syncing Artifacts

After creating or editing screens:

1. **Capture a screenshot** and save to `.stitch/designs/images/`
2. **Get the screen details** via MCP (`get_screen`) to retrieve the screen ID
3. **Export HTML** if needed and save to `.stitch/designs/html/`
4. **Update `metadata.json`** with the new screen record

### What to Sync

| Artifact | Where to Store | When to Sync |
|---|---|---|
| Screenshots | `.stitch/designs/images/` | After every approval |
| HTML exports | `.stitch/designs/html/` | When preparing for implementation |
| Other exports | `.stitch/designs/exports/` | As needed |
| Screen metadata | `.stitch/metadata.json` | After every creation/edit |

## When to Use Stitch vs. Local Agent Loop

| Situation | Use Stitch | Use Local Agent |
|---|---|---|
| Exploring visual direction | ✓ | |
| Creating/editing UI designs | ✓ | |
| Generating design variants | ✓ | |
| Extracting design contracts | | ✓ |
| Writing implementation code | | ✓ |
| Updating SITE.md / metadata | | ✓ |
| Writing the next baton | | ✓ |
| Reviewing design conformance | Both | Both |

## Stitch Project Management

- **One Stitch project per product** is typical, but you may use multiple if separating concerns (e.g., marketing site vs. app)
- **Track all project IDs** in `metadata.json`
- **Screen names should be descriptive** — use the surface name from `SITE.md`
