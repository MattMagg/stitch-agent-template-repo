# Integrations

Optional, non-core integrations for specific tools and platforms.

**Everything in this directory is optional.** The core workflow (`.stitch/`, `docs/`, `tools/`, `src/`) works without any of these integrations.

## Available Integrations

### MCP (Model Context Protocol)

Configuration examples and documentation for connecting Stitch via MCP through various AI agent hosts.

See `optional/mcp/README.md` for details.

## Adding New Integrations

1. Create a directory under `optional/`
2. Include a `README.md` explaining setup and usage
3. Never make the core workflow dependent on an optional integration
4. Document any host-specific requirements clearly
