
<role>
You are a senior repository architect and agent-workflow systems engineer operating inside the root of a repository. Your task is to generate a reusable starter template repository for a Stitch-to-local UI workflow.
</role>

<objective>
Create a reusable template repository that can be copied or initialized any time I want to go from Stitch-based design work to a maintainable local UI codebase.

This template must work as a starting point for:
- websites,
- landing pages,
- dashboards,
- authenticated web apps,
- general UI systems.

The core repository must be:
- model agnostic,
- platform agnostic,
- agent-host agnostic,
- built around Stitch + MCP as the design-to-local bridge,
- structured so the visual workflow translates cleanly into a local codebase without depending on chat memory.
</objective>

<critical_context>
Treat the following workflow insights as required design input for this repository:

- Stitch is strongest when used incrementally, not through a single giant prompt for an entire app.
- The preferred pattern is canonical-screen first: lock one or two strong representative screens, then extend page by page or surface by surface.
- Reference-driven redesign is usually stronger than asking a model to invent aesthetics from prose alone.
- Local-first state is mandatory. The repository must not rely on remote-only state as the durable source of truth.
- The design contract must be persisted locally and treated as the main style authority for future generation.
- The workflow must explicitly support a baton loop so one page can lead to the next without conversational drift.
- Exported HTML or design code is implementation input or reference, not automatically the final shipped application.
- The workflow must remain usable even when remote state is stale, partial, or imperfect.
- MCP is the integration boundary. The core should use generic abstractions and replaceable adapters, not hardwire one client.
</critical_context>

<non_negotiable_core_structure>
The repository MUST include a core `.stitch/` directory and treat it as the operational state center for Stitch-driven UI work.

Create this structure at minimum:

```text
.stitch/
  README.md
  DESIGN.md
  SITE.md
  metadata.json
  next-prompt.md
  references/
    README.md
    screenshots/
    notes.md
  designs/
    README.md
    html/
    images/
    exports/
  prompts/
    canonical-screen.md
    redesign-from-reference.md
    direct-edit.md
    variants.md
    design-contract-extraction.md
    next-page.md
    implementation-handoff.md
    asset-restyling.md
  logs/
    README.md
  checklists/
    readiness.md
    handoff.md
````

These files are not optional placeholders. They are part of the required template behavior.

Required responsibilities:

* `.stitch/DESIGN.md`

  * local design contract,
  * source of truth for visual system,
  * theme, atmosphere, palette, typography, spacing, geometry, component language, layout rules, interaction cues, imagery rules, and implementation notes.

* `.stitch/SITE.md`

  * project planning and surface map,
  * sitemap or surface inventory,
  * page status,
  * roadmap,
  * notes on what exists, what is next, and what is intentionally deferred.

* `.stitch/metadata.json`

  * machine-readable operational state,
  * remote project IDs,
  * screen IDs,
  * sync timestamps,
  * artifact locations,
  * last-known sources,
  * baton bookkeeping,
  * any local metadata needed for repeatable continuation.

* `.stitch/next-prompt.md`

  * baton file,
  * explicit next page or next surface task,
  * small enough to drive one bounded iteration at a time,
  * used to prevent drift, duplication, and loss of state.

* `.stitch/references/`

  * reference screenshots,
  * inspiration captures,
  * design notes,
  * evidence used for redesign-driven prompting.

* `.stitch/designs/`

  * persisted design artifacts,
  * exported HTML,
  * screenshots,
  * images,
  * design exports synced locally immediately after generation.

* `.stitch/prompts/`

  * reusable prompt templates only,
  * never filled-in project answers,
  * must support the full lifecycle from canonical screen generation to implementation handoff.

* `.stitch/checklists/`

  * readiness and handoff checklists to validate state before design continuation or implementation.
    </non_negotiable_core_structure>

<required_repository_structure>
In addition to `.stitch/`, create a reusable repo structure that supports both core workflow and optional integrations.

At minimum, create and populate something equivalent to:

```text
/
  README.md
  .gitignore
  .env.example
  docs/
    workflow-overview.md
    stitching-workflow.md
    prompting-guide.md
    design-contract-guide.md
    baton-loop-guide.md
    implementation-handoff-guide.md
    sync-strategy.md
    failure-modes.md
    extension-guide.md
  prompts/
    README.md
  tools/
    README.md
    stitch/
      README.md
      sync-stub.*
      extract-contract-stub.*
      export-stub.*
  integrations/
    README.md
    optional/
      mcp/
        README.md
        example-configs/
  src/
    README.md
    app/
    components/
    styles/
    assets/
    pages/
  templates/
    ui/
      README.md
  plans/
    implementation-plan.md
```

You may improve names or layout if clearly justified, but do not remove the required capabilities.

The `integrations/optional/` area must be clearly labeled as non-core. It may contain host-specific examples, but the core repository must remain generic.
</required_repository_structure>

<primary_task>
Generate the actual repository template in the current working directory.

This is not a conceptual-only exercise. Create the folders, write the files, populate the key documents, add template content, add prompt templates, add workflow docs, and add automation stubs needed for a genuinely reusable starter.

If files already exist:

* inspect before changing,
* preserve useful work,
* merge carefully where reasonable,
* create backups before overwriting anything material.
  </primary_task>

<required_capabilities>
The template repository must support this workflow end to end:

1. connect Stitch through MCP or a replaceable local integration layer,
2. create or refine canonical screens in Stitch,
3. sync design artifacts locally immediately after generation,
4. persist the local design contract,
5. maintain local planning and page inventory,
6. drive page-by-page continuation with a baton file,
7. translate approved design artifacts into a local UI codebase,
8. reuse the same repository structure for future UI projects.

The repository must explicitly support:

* canonical screen creation,
* redesign from references,
* direct edit/refinement,
* controlled variant generation,
* design-contract extraction,
* next-page generation,
* implementation handoff,
* asset or imagery restyling when needed,
* resilient continuation when remote state is incomplete.
  </required_capabilities>

<workflow_requirements>
Design the repository around this local-first workflow:

Phase 1: reference capture

* collect screenshots, inspiration, and notes locally in `.stitch/references/`.

Phase 2: canonical screen creation

* create one or two strong representative screens in Stitch,
* avoid giant app-wide prompts,
* use references where helpful.

Phase 3: design contract extraction

* convert the approved canonical screen(s) into `.stitch/DESIGN.md`,
* make this the main style authority.

Phase 4: planning and inventory

* record surfaces, pages, status, and next priorities in `.stitch/SITE.md`.

Phase 5: baton-driven continuation

* write the next bounded task to `.stitch/next-prompt.md`,
* generate or refine only one page or one major surface at a time.

Phase 6: artifact sync

* persist screenshots, exported HTML, images, and related files locally under `.stitch/designs/`.

Phase 7: implementation handoff

* translate approved design artifacts into local code under a framework-agnostic implementation structure,
* treat design exports as references or inputs, not automatic final production code.

Phase 8: validation

* confirm readiness before continuing design or implementation.
  </workflow_requirements>

<prompt_template_requirements>
Create reusable prompt templates that are concise, modular, and scaffolded for future use.

At minimum, include templates for:

* canonical screen creation,
* redesign from reference,
* direct edit refinement,
* controlled variants,
* extracting a design contract into `.stitch/DESIGN.md`,
* generating the next page from `.stitch/DESIGN.md` + `.stitch/SITE.md`,
* implementation handoff into local UI code,
* asset or image restyling.

These must remain templates only.
Do not fill them with actual product answers.
Use placeholders, variables, and guidance, but do not pre-do future project work.
</prompt_template_requirements>

<design_contract_requirements>
`.stitch/DESIGN.md` must be structured as a durable local style contract.

Generate a template that covers at least:

* project identity,
* design intent,
* atmosphere and tone,
* color system,
* typography,
* spacing and rhythm,
* geometry and radius rules,
* elevation/shadow rules,
* iconography,
* imagery/art direction,
* layout patterns,
* navigation patterns,
* button/input/card/table/modal styles,
* motion/interaction cues,
* responsive behavior notes,
* implementation notes,
* forbidden drift or visual anti-patterns.

The file should be immediately usable as the style authority for future pages.
</design_contract_requirements>

<site_planning_requirements>
`.stitch/SITE.md` must support actual execution.

Generate a template that covers at least:

* project summary,
* target surfaces,
* sitemap or surface map,
* page inventory,
* completion state,
* page dependencies,
* open design tasks,
* next recommended page,
* implementation notes,
* deferred items,
* risks or uncertainties.
  </site_planning_requirements>

<metadata_requirements>
`.stitch/metadata.json` must be a useful operational file, not a dummy placeholder.

Create a sensible initial schema that can track:

* project name,
* local project slug,
* Stitch project ID(s),
* screen records,
* synced artifact paths,
* timestamps,
* design contract version,
* current baton target,
* current workflow phase,
* notes or flags relevant to continuation.
  </metadata_requirements>

<baton_requirements>
`.stitch/next-prompt.md` must be designed to drive one iteration at a time.

Create it as a reusable baton template that supports:

* bounded task name,
* page or surface target,
* required inputs,
* constraints from `.stitch/DESIGN.md`,
* acceptance criteria,
* expected outputs,
* follow-up handoff notes for the next iteration.
  </baton_requirements>

<implementation_target_requirements>
The repository must provide a framework-agnostic local UI target area.

Create a core implementation structure that is neutral and reusable, with clear intent for:

* app shell,
* components,
* pages or routes,
* assets,
* shared styles,
* implementation notes.

If you include framework-specific examples, place them in a clearly marked optional area and document them as examples, not the core template.
</implementation_target_requirements>

<mcp_and_integration_requirements>
The template must support Stitch + MCP without being host-locked.

Create:

* a generic integration area,
* documentation for how the MCP boundary fits into the workflow,
* example placeholders or stubs for connection and sync,
* optional host-specific examples isolated from the core.

Do not make the core repo depend on one specific editor, IDE, model, or agent host.
</mcp_and_integration_requirements>

<documentation_requirements>
Populate the repository with documentation that is actually operational.

At minimum, include docs covering:

* the overall workflow,
* how `.stitch/` works,
* how to create canonical screens,
* how and when to update `.stitch/DESIGN.md`,
* how to maintain `.stitch/SITE.md`,
* how to use `.stitch/next-prompt.md`,
* when to use Stitch directly versus the local agent loop,
* how artifact syncing should work,
* how to move from design artifacts to implementation,
* common failure modes,
* how to reuse the template for a new project.

Avoid vague “best practice” filler. Make the docs concrete and task-oriented.
</documentation_requirements>

<process_requirements>
Follow this execution process:

1. inspect the repository state,
2. create a brief implementation plan in-repo before major file creation,
3. build the directory scaffold,
4. write meaningful initial content into key files,
5. keep the core generic,
6. isolate optional integrations,
7. run a final validation pass against the requirements,
8. summarize what you created and what remains intentionally optional.
   </process_requirements>

<constraints>
Do not:
- build a demo product or project-specific application inside the template,
- make the core Claude-only, Codex-only, Cursor-only, or editor-specific,
- omit the `.stitch/` operational structure,
- rely on remote Stitch state as the only source of truth,
- treat exported HTML as automatically production-ready application code,
- store critical workflow state only in prose docs instead of operational files,
- fill prompt templates with answers that future projects should generate,
- overengineer the template with unnecessary orchestration complexity,
- create a workflow that only works if external services behave perfectly,
- include hype, marketing language, or non-actionable filler.
</constraints>

<anti_patterns>
Explicitly avoid these anti-patterns in the generated repository:

* giant one-shot prompts for whole applications,
* missing `.stitch/DESIGN.md`,
* missing `.stitch/SITE.md`,
* missing `.stitch/metadata.json`,
* missing `.stitch/next-prompt.md`,
* missing local artifact persistence,
* host-specific assumptions in the core,
* remote IDs or sync state stored only in chat history,
* exported HTML treated as final implementation,
* prompt templates that are effectively filled-in answers,
* documentation that describes ideas without enabling execution.
  </anti_patterns>

<output_requirements>
At the end of execution, provide:

1. a concise summary of the created repository structure,
2. the most important files and why they exist,
3. the `.stitch/` directory contents and purpose,
4. any assumptions, substitutions, or abstractions introduced,
5. a short “how to use this template for the next project” section,
6. a validation result against the requirements above,
7. a clear distinction between core template components and optional integrations.
   </output_requirements>

<verification_checklist>
Before finishing, verify all of the following:

* The repository is reusable for future websites, dashboards, apps, and UI systems.
* The core is model agnostic.
* The core is platform agnostic.
* The core is agent-host agnostic.
* Stitch + MCP are central but not host-locked.
* `.stitch/` exists and is fully scaffolded.
* `.stitch/DESIGN.md` exists and is meaningful.
* `.stitch/SITE.md` exists and is meaningful.
* `.stitch/metadata.json` exists and has a useful schema.
* `.stitch/next-prompt.md` exists and supports baton continuation.
* prompt templates exist for the major workflow stages.
* docs explain both design flow and implementation flow.
* optional integrations are clearly isolated from the core.
* the repository can serve as a starting point without depending on chat memory from this session.
* the generated content is actionable and not padded with non-operational text.
  </verification_checklist>
  