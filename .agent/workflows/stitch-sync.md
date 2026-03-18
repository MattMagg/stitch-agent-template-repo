---
description: Sync design artifacts from Stitch to the local repository
---

# `/stitch-sync` — Sync Artifacts from Stitch

Use this workflow to pull design artifacts from Stitch into the local repository. Compares remote Stitch state against `metadata.json`, identifies unsynced screens, retrieves details, and persists screenshots, HTML, and exports locally.

## Pre-Flight Checks

// turbo
1. Read `.stitch/metadata.json` and verify:
   - `stitchProjects[]` has at least one entry with a non-empty `projectId`
   - If no project is linked, recommend running `/stitch-init` first

// turbo
2. Verify the local sync directories exist:
   ```
   ls .stitch/designs/images/ .stitch/designs/html/ .stitch/designs/exports/
   ```
   Create any missing directories.

3. Check MCP connectivity by calling `list_projects`:
   - If MCP is unavailable, inform the user that sync requires either MCP access or manual artifact collection. Provide manual sync instructions (see Error Handling).

## Execution Steps

### Step 1: Inventory Remote Screens

4. Call `list_screens` with the `projectId` from `metadata.json`:
   - Record every screen ID and name returned

5. If multiple Stitch projects exist in `metadata.json`, repeat Step 4 for each project.

### Step 2: Identify Unsynced Screens

// turbo
6. Read the `screens[]` array in `metadata.json`.

7. Compare remote screens (Step 4) against local records:
   - **New screens**: remote screen IDs not in `metadata.json` → need full sync
   - **Updated screens**: remote screens that may have changed since `updatedAt` → need re-sync
   - **Already synced**: remote screens matching local records with artifacts present → skip unless forced

8. Report the comparison to the user:
   - "Found N screens in Stitch. M are new, K may need re-sync, J are up to date."

### Step 3: Sync Each Unsynced Screen

For each screen that needs syncing:

9. Call `get_screen` with:
   - `name`: `projects/{projectId}/screens/{screenId}`
   - `projectId`: the Stitch project ID
   - `screenId`: the screen ID

10. From the screen details, extract:
    - Screen name / title
    - Any rendered content or metadata available

11. Save artifacts locally following naming conventions from `docs/sync-strategy.md`:
    ```
    .stitch/designs/images/{surface-name}.png          ← screenshot
    .stitch/designs/html/{surface-name}.html            ← HTML export (if available)
    .stitch/designs/exports/{surface-name}-{type}.{ext} ← any other exports
    ```
    - Use surface names from `SITE.md`, not raw Stitch IDs
    - If the screen doesn't have a matching surface name in `SITE.md`, use the Stitch screen name in kebab-case

12. **Screenshot capture**: If MCP does not directly provide a screenshot:
    - Ask the user to capture and save it manually, OR
    - Use browser automation to capture the screen if available
    - Note: this is a known limitation — screenshots may require manual capture

### Step 4: Update Metadata

13. For each synced screen, update `metadata.json`:
    - Add or update the entry in `screens[]`:
      ```json
      {
        "screenId": "<from Stitch>",
        "name": "<surface name>",
        "stitchProjectId": "<project ID>",
        "role": "<canonical | page | component | variant>",
        "status": "<synced | approved>",
        "designApproved": false,
        "localArtifacts": {
          "screenshot": ".stitch/designs/images/{name}.png",
          "html": ".stitch/designs/html/{name}.html",
          "exports": []
        },
        "createdAt": "<ISO timestamp>",
        "updatedAt": "<current ISO timestamp>",
        "notes": ""
      }
      ```

14. Append a sync log entry for each screen:
    ```json
    {
      "action": "sync",
      "screenId": "<screen ID>",
      "artifactPath": ".stitch/designs/images/{name}.png",
      "timestamp": "<current ISO timestamp>"
    }
    ```

15. Set `metadata.json` → `updatedAt` to current ISO timestamp.

### Step 5: Update SITE.md

// turbo
16. Read `.stitch/SITE.md`.

17. For each synced screen that maps to a known surface in `SITE.md`:
    - Update its status (e.g., `"planned"` → `"in-design"` or `"approved"` if user confirms)
    - Update the **Page Inventory** section with screen ID and local artifact paths
    - Update the **Completion Summary** counts

### Step 6: Report

18. Summarize the sync results:
    - How many screens were synced
    - What artifacts were saved and where
    - Any screens that could not be synced (and why)
    - Next recommended action (e.g., "Run `/stitch-contract` to extract the design contract" or "Run `/stitch-design` to continue designing")

## Post-Completion

- [ ] All unsynced screens retrieved from Stitch via `get_screen`
- [ ] Screenshots saved to `.stitch/designs/images/`
- [ ] HTML exports saved to `.stitch/designs/html/` (where available)
- [ ] `metadata.json` `screens[]` updated with current records
- [ ] `metadata.json` `syncLog[]` has entries for all synced screens
- [ ] `SITE.md` surface statuses updated
- [ ] Sync summary reported to user

## Error Handling

- **MCP `list_screens` fails**: Check connectivity with `list_projects`. If MCP is down, inform the user and provide manual sync instructions:
  1. Open Stitch in the browser
  2. Screenshot each approved screen
  3. Save to `.stitch/designs/images/` with descriptive names
  4. Manually update `metadata.json` with screen IDs and artifact paths

- **MCP `get_screen` fails for a specific screen**: Skip it, note the failure, and continue with remaining screens. Report the failed screen at the end.

- **Screenshot capture not available via MCP**: This is expected — MCP may only provide metadata, not rendered images. Ask the user to capture screenshots manually or via browser automation.

- **Screen name doesn't match any SITE.md surface**: Add a new entry to `SITE.md` with status `"in-design"` and ask the user to categorize it.

- **Stale local artifacts**: If a local artifact already exists for a screen being re-synced, rename the old file with a version suffix (e.g., `{name}-v1.png`) before saving the new one.

- **`metadata.json` sync log grows too large**: Keep only the most recent 50 entries. Archive older entries to `.stitch/logs/sync-archive.json` if needed.
