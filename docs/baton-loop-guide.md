# Baton Loop Guide

How to use `.stitch/next-prompt.md` for page-by-page continuation without drift.

## What Is the Baton Loop?

The baton loop is the mechanism that prevents conversational drift when creating multiple pages. Instead of relying on context or memory, each iteration is driven by a written baton file (`next-prompt.md`) that contains everything needed for one bounded task.

## The Loop

```
Write baton → Execute task → Sync artifacts → Update SITE.md → Write next baton → Repeat
```

### Step 1: Write the Baton

Open `.stitch/next-prompt.md` and fill in:

- **Task name**: A short, descriptive name
- **Target surface**: Which page or component to create
- **Required inputs**: What must exist before starting (design contract, previous pages, references)
- **Design contract constraints**: Copy the relevant rules from `DESIGN.md`
- **Acceptance criteria**: What must be true for this iteration to be complete
- **Expected outputs**: What artifacts to produce

### Step 2: Execute the Task

Use the baton to drive one prompt:

1. Select the right prompt template from `.stitch/prompts/`
2. Fill in the template using the baton's details
3. Create or edit the screen in Stitch
4. Review against the acceptance criteria

### Step 3: Sync Artifacts

Once approved:

1. Screenshot → `.stitch/designs/images/`
2. HTML export → `.stitch/designs/html/`
3. Update `metadata.json`

### Step 4: Update SITE.md

Mark the surface as "approved" or "implemented" in `SITE.md`.

### Step 5: Write the Next Baton

Before stopping:

1. Clear `next-prompt.md`
2. Fill it with the next surface from `SITE.md`
3. Include any handoff notes from this iteration

## Why This Matters

- **No reliance on chat memory**: The baton contains all the context needed
- **No scope creep**: Each iteration is bounded — one page or one surface
- **Resumable**: Anyone (human or agent) can pick up the baton and continue
- **Auditable**: The progression from baton to baton is traceable

## Tips

- Keep batons small. If a baton requires more than one Stitch session, it's too big.
- Include the design contract constraints directly — don't just reference `DESIGN.md` by name.
- Write the acceptance criteria before starting, not after.
- If you skip the baton step, you'll drift. It feels tedious, but it prevents rework.
