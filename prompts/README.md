# Prompts

Root-level prompt collection. An extension point for project-wide prompts that don't fit in `.stitch/prompts/`.

## Distinction from `.stitch/prompts/`

- **`.stitch/prompts/`** — Stitch-specific prompt templates for design workflow stages (canonical screen, edit, variant, etc.)
- **`prompts/`** (this directory) — General-purpose prompts for implementation, architecture, code review, or other non-design tasks

## Usage

Add prompts here for tasks like:

- Code review checklists
- Architecture decision prompts
- Component specification templates
- Accessibility audit prompts
- Performance review templates

This directory is optional. The core workflow uses `.stitch/prompts/` exclusively.
