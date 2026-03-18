#!/usr/bin/env bash
# sync-stub.sh — Sync Stitch artifacts to local .stitch/designs/
#
# This is a stub. Replace with your actual sync implementation.
#
# Example usage:
#   ./sync-stub.sh <screen-name> <source-path>
#
# What this should do:
#   1. Copy/download the screenshot to .stitch/designs/images/<screen-name>.png
#   2. Copy/download HTML export to .stitch/designs/html/<screen-name>.html
#   3. Update .stitch/metadata.json with artifact paths and timestamps
#
# Integration options:
#   - MCP: Use MCP tools to retrieve screen data, then save locally
#   - Browser automation: Screenshot the Stitch preview
#   - Manual: Just use this script to organize files you've downloaded

set -euo pipefail

SCREEN_NAME="${1:?Usage: sync-stub.sh <screen-name> [source-path]}"
SOURCE_PATH="${2:-}"

DESIGNS_DIR=".stitch/designs"
IMAGES_DIR="${DESIGNS_DIR}/images"
HTML_DIR="${DESIGNS_DIR}/html"

echo "Sync stub for screen: ${SCREEN_NAME}"
echo "Target directories:"
echo "  Images: ${IMAGES_DIR}/"
echo "  HTML:   ${HTML_DIR}/"

if [ -n "${SOURCE_PATH}" ]; then
  echo "Source: ${SOURCE_PATH}"
  # TODO: Copy/move source files to target directories
  # cp "${SOURCE_PATH}" "${IMAGES_DIR}/${SCREEN_NAME}.png"
fi

echo ""
echo "TODO: Implement actual sync logic for your workflow."
echo "After syncing, update .stitch/metadata.json with:"
echo "  - screenId"
echo "  - localArtifacts paths"
echo "  - updatedAt timestamp"
