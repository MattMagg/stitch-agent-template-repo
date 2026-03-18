# MCP Integration

Connect to Stitch through the Model Context Protocol (MCP).

## What Is MCP?

MCP is a standard protocol that allows AI agents to interact with external tools and services. Stitch provides an MCP server that enables agents to:

- Create and edit UI screens
- Generate design variants
- List and retrieve project/screen information

## Available Stitch MCP Tools

| Tool | Description |
|---|---|
| `create_project` | Create a new Stitch project |
| `get_project` | Get project details |
| `list_projects` | List accessible projects |
| `list_screens` | List screens in a project |
| `get_screen` | Get screen details |
| `generate_screen_from_text` | Generate a new screen from a text prompt |
| `edit_screens` | Edit existing screens with a text prompt |
| `generate_variants` | Generate variants of existing screens |

## Configuration

MCP configuration varies by AI agent host. See `example-configs/` for host-specific examples.

### General Setup

1. Ensure you have access to the Stitch MCP server
2. Configure your AI agent host to connect to the Stitch MCP endpoint
3. Verify connectivity by listing projects

### How MCP Fits the Workflow

```
.stitch/prompts/ → MCP tools → Stitch screens → Sync locally → .stitch/designs/
```

MCP is the integration boundary between the local workflow and Stitch. The workflow uses MCP to:

1. **Create screens** using prompts from `.stitch/prompts/`
2. **Edit screens** for refinement
3. **Generate variants** for exploration
4. **Retrieve metadata** for `metadata.json` updates

All other workflow operations (design contract management, baton loop, implementation handoff) happen locally without MCP.

## Host Independence

The core workflow must work regardless of which AI agent host is used. MCP configuration is host-specific, but the workflow and prompt templates are universal.
