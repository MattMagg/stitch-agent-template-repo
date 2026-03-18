#!/usr/bin/env bash
# extract-contract-stub.sh — Extract design contract values into .stitch/DESIGN.md
#
# This is a stub. Replace with your actual extraction implementation.
#
# Example usage:
#   ./extract-contract-stub.sh <screen-id>
#
# What this should do:
#   1. Retrieve the screen data (via MCP or from local artifacts)
#   2. Analyze the screen for design values (colors, typography, spacing, etc.)
#   3. Populate .stitch/DESIGN.md with extracted values
#   4. Increment the contract version in DESIGN.md and metadata.json
#
# This is typically done by an AI agent analyzing the screen, not by
# parsing pixels programmatically. The stub exists as a workflow marker.

set -euo pipefail

SCREEN_ID="${1:?Usage: extract-contract-stub.sh <screen-id>}"

echo "Extract contract stub for screen: ${SCREEN_ID}"
echo ""
echo "This task is typically performed by an AI agent:"
echo "  1. Use .stitch/prompts/design-contract-extraction.md as the prompt template"
echo "  2. Analyze the approved screen"
echo "  3. Populate .stitch/DESIGN.md with extracted values"
echo "  4. Increment the contract version"
echo ""
echo "TODO: Implement automation if desired."
