# Extension Guide

How to customize this template for your specific project, tools, and workflow.

## Reusing This Template for a New Project

1. **Copy** this directory to a new location
2. **Reset state files**:
   - Clear `metadata.json` values (keep the schema)
   - Reset `DESIGN.md` to the blank template
   - Reset `SITE.md` to the blank template
   - Clear `next-prompt.md`
   - Delete contents of `.stitch/designs/` (keep directories)
   - Delete contents of `.stitch/references/` (keep directories)
3. **Update `.env`** with new project configuration
4. **Start at Phase 1**: Reference Capture

## Adding a Framework

The `src/` directory is framework-agnostic by default. To add a framework:

1. Initialize the framework in the project root (e.g., `npx create-next-app@latest ./`)
2. Map the framework's structure to the template conventions:

| Template Convention | Next.js | Vite + React | SvelteKit |
|---|---|---|---|
| `src/app/` | `app/` | `src/` | `src/routes/` |
| `src/components/` | `components/` | `src/components/` | `src/lib/components/` |
| `src/pages/` | `app/` (routes) | `src/pages/` | `src/routes/` |
| `src/styles/` | `styles/` | `src/styles/` | `src/styles/` |
| `src/assets/` | `public/` | `public/` | `static/` |

3. Update `SITE.md` implementation notes with the chosen framework
4. The `.stitch/` directory and workflow remain unchanged

## Adding Custom Prompt Templates

To add a new prompt template:

1. Create a new `.md` file in `.stitch/prompts/`
2. Follow the template structure: When to Use → Template (with `{{PLACEHOLDERS}}`) → After Steps
3. Keep it reusable — no project-specific answers

## Customizing Tool Stubs

The `tools/stitch/` stubs are deliberately minimal. To extend:

1. Replace the shell scripts with scripts in your preferred language
2. Common extensions:
   - Automatic screenshot capture via browser automation
   - `metadata.json` auto-update after MCP operations
   - Design token extraction from `DESIGN.md` into CSS/JS
3. Keep the interface simple — stdin/stdout or file-based

## Adding MCP Configurations

For specific AI agent hosts:

1. Add config files to `integrations/optional/mcp/example-configs/`
2. Name them by host: `cursor.json`, `vscode.json`, etc.
3. Document any host-specific setup in the config's README
4. Never make the core workflow dependent on a specific host

## Adding CI/CD

This template doesn't include CI/CD by default. If you add it:

- Validate that `.stitch/DESIGN.md` is not empty
- Validate that `.stitch/metadata.json` has valid JSON
- Lint/build `src/` if a framework is installed
- Keep CI/CD config in the standard location for your platform

## Adding Design Tokens Automation

For design-to-code token synchronization:

1. Write a script that reads `DESIGN.md` and outputs CSS custom properties, JSON tokens, or your framework's format
2. Place it in `tools/stitch/`
3. Run it as part of the implementation handoff step
4. Consider making `DESIGN.md` machine-parseable (it mostly is already by section)
