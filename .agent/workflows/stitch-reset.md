---
description: Reset the template for a new project — clear state, keep structure
---

# `/stitch-reset` — Reset Template for New Project

Use this workflow to clear all project-specific state from the template, preparing it for a fresh project. Preserves the directory structure, templates, documentation, and prompt files while clearing all state files and design artifacts.

> [!CAUTION]
> This workflow is destructive — it removes all project-specific data. Make sure to commit or backup current state before running. This cannot be undone.

## Pre-Flight Checks

1. **Confirm with the user** that they want to reset. This is a destructive operation.

// turbo
2. Check the current project state by reading `.stitch/metadata.json`:
   - Note the `projectName` for the confirmation prompt
   - Note how many screens, sync log entries, and design artifacts exist

3. Ask the user: "This will clear all state for **{projectName}**. Are you sure? (yes/no)"
   - Only proceed if the user explicitly confirms

4. Recommend the user commit or backup current state:
   ```
   git status
   ```
   If there are uncommitted changes, suggest committing first:
   ```
   git add -A && git commit -m "backup: state before reset"
   ```

## Execution Steps

### Step 1: Reset metadata.json

5. Reset `.stitch/metadata.json` to the empty template:
   ```json
   {
     "projectName": "",
     "localSlug": "",
     "stitchProjects": [
       {
         "projectId": "",
         "title": "",
         "deviceType": "",
         "linkedAt": ""
       }
     ],
     "screens": [
       {
         "screenId": "",
         "name": "",
         "stitchProjectId": "",
         "role": "",
         "status": "planned",
         "designApproved": false,
         "localArtifacts": {
           "screenshot": "",
           "html": "",
           "exports": []
         },
         "createdAt": "",
         "updatedAt": "",
         "notes": ""
       }
     ],
     "designContract": {
       "version": 0,
       "lastExtractedFrom": "",
       "extractedAt": ""
     },
     "baton": {
       "currentTarget": "",
       "phase": "",
       "updatedAt": ""
     },
     "workflowPhase": "init",
     "syncLog": [
       {
         "action": "",
         "screenId": "",
         "artifactPath": "",
         "timestamp": ""
       }
     ],
     "notes": [],
     "createdAt": "",
     "updatedAt": ""
   }
   ```

### Step 2: Reset DESIGN.md

6. Reset `.stitch/DESIGN.md` to the empty template:
   - Replace all populated values with the original `<!-- TODO -->` placeholders
   - Set `Contract version` to `0`
   - Clear `Last updated from screen` and `Extraction date`

   The simplest approach: restore from the repo's initial commit or from the template source.

### Step 3: Reset SITE.md

7. Reset `.stitch/SITE.md` to the empty template:
   - Clear the Project Summary
   - Clear the Target Surfaces table (keep header row and one blank row)
   - Reset the sitemap to the default placeholder
   - Clear the Page Inventory
   - Reset Completion Summary counts to 0
   - Clear all other sections

### Step 4: Reset next-prompt.md

8. Reset `.stitch/next-prompt.md` to the empty template:
   - Clear all filled values
   - Restore `<!-- -->` placeholder comments
   - Set Status to empty

### Step 5: Clear Design Artifacts

9. Remove all files from the design artifact directories (keep the directories):
   ```
   rm -f .stitch/designs/images/*
   rm -f .stitch/designs/html/*
   rm -f .stitch/designs/exports/*
   ```

### Step 6: Clear References

10. Remove all files from the references directory (keep the directory):
    ```
    rm -f .stitch/references/screenshots/*
    rm -f .stitch/references/notes.md
    ```
    Recreate an empty `notes.md`:
    ```
    echo "# Reference Notes\n\n<!-- Add notes about reference materials here -->" > .stitch/references/notes.md
    ```

### Step 7: Clear Logs

11. Remove all log files (keep the directory):
    ```
    rm -f .stitch/logs/*
    ```

### Step 8: Clear Implementation (Optional)

12. Ask the user whether to also clear `src/`:
    - **If yes**: Remove all files in `src/` subdirectories but keep the directory structure
    - **If no**: Leave `src/` untouched — the user may want to keep it for reference or reuse

13. Ask the user whether to also clear `plans/`:
    - **If yes**: Remove plan files but keep the directory and template
    - **If no**: Leave plans untouched

### Step 9: Verify Reset

// turbo
14. Verify all state files are back to their empty template state:
    ```
    cat .stitch/metadata.json | head -5    # should show empty projectName
    cat .stitch/DESIGN.md | head -10       # should show TODO placeholders
    cat .stitch/SITE.md | head -10         # should show empty project summary
    cat .stitch/next-prompt.md | head -10  # should show template placeholders
    ls .stitch/designs/images/             # should be empty
    ls .stitch/designs/html/               # should be empty
    ```

## Post-Completion

- [ ] `metadata.json` reset to empty template
- [ ] `DESIGN.md` reset to empty template
- [ ] `SITE.md` reset to empty template
- [ ] `next-prompt.md` reset to empty template
- [ ] `.stitch/designs/` contents cleared
- [ ] `.stitch/references/` contents cleared
- [ ] `.stitch/logs/` contents cleared
- [ ] `src/` cleared (if user chose to)
- [ ] Reset verified
- [ ] User informed: "Template reset. Run `/stitch-init` to start a new project."

## Error Handling

- **User does not confirm**: Do not proceed. Inform the user that no changes were made.
- **Uncommitted changes**: Strongly recommend committing before reset. If the user insists on proceeding without committing, note the risk and proceed.
- **Template files (DESIGN.md, SITE.md, next-prompt.md) are not version-controlled**: Without the original templates, reset requires manually recreating them. Check if the original template content exists in the repo's git history or in another branch.
- **Permission errors on file deletion**: Report which files could not be deleted and suggest manual cleanup.
- **Partial reset**: If the reset fails partway through, report what was and was not reset. The user can continue manually or re-run.
