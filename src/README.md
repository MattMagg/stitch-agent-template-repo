# Source — UI Implementation Target

This directory is the framework-agnostic target for UI implementation code.

## Structure

```
src/
├── app/          ← Application shell, entry point, routing
├── components/   ← Reusable UI components
├── pages/        ← Page-level components / route views
├── styles/       ← Shared styles, design tokens, CSS
└── assets/       ← Static assets (images, fonts, icons)
```

## Usage

This directory starts empty. When you're ready to implement:

1. **Choose a framework** (or go vanilla) and set up your project
2. **Map framework conventions** to these directories (see `docs/extension-guide.md`)
3. **Use `DESIGN.md` values** as your design tokens
4. **Build components** extracted from approved Stitch screens
5. **Build pages** using the implementation handoff prompt template

## No Framework Lock-In

This scaffold is deliberately neutral. The directory names are common conventions that map to most frontend frameworks. See `docs/extension-guide.md` for framework-specific mapping.

## Design Token Integration

Convert `.stitch/DESIGN.md` values into your framework's style system:

```css
/* Example: CSS Custom Properties from DESIGN.md */
:root {
  /* Colors from DESIGN.md → Color System */
  --color-bg: /* from DESIGN.md */;
  --color-surface: /* from DESIGN.md */;
  --color-primary: /* from DESIGN.md */;
  
  /* Typography from DESIGN.md → Typography */
  --font-body: /* from DESIGN.md */;
  --font-size-body: /* from DESIGN.md */;
  
  /* Spacing from DESIGN.md → Spacing & Rhythm */
  --space-base: /* from DESIGN.md */;
}
```
