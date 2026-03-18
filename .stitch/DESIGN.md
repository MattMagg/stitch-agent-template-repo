# Design Contract

> This file is the authoritative local style reference for this project. All pages, components, and surfaces must conform to the rules defined here. Update this file only through deliberate design-contract extraction — never drift from it silently.

## Project Identity

<!-- TODO: Fill after canonical screen approval -->

- **Project name**:
- **Tagline / positioning**:
- **Brand personality** (3–5 adjectives):
- **Target audience**:

## Design Intent

<!-- TODO: What is this design trying to accomplish? What should the user feel? -->

- **Primary goal**:
- **Emotional tone**:
- **Visual density** (minimal / moderate / dense):
- **Formality** (casual / professional / editorial):

## Atmosphere & Tone

<!-- TODO: Describe the overall visual feeling — dark/light, warm/cool, heavy/airy, etc. -->

- **Mode**: <!-- light | dark | adaptive -->
- **Temperature**: <!-- warm | neutral | cool -->
- **Weight**: <!-- airy | balanced | grounded -->
- **Texture**: <!-- flat | subtle depth | layered -->
- **Notes**:

## Color System

<!-- TODO: Extract from canonical screen. Record exact values. -->

### Primary Palette

| Role | Value | Usage |
|---|---|---|
| Background | | |
| Surface | | |
| Primary | | |
| Secondary | | |
| Accent | | |
| Text primary | | |
| Text secondary | | |
| Border / divider | | |
| Error | | |
| Success | | |
| Warning | | |

### Gradient Rules

- **Usage**:
- **Direction**:
- **Stops**:

### Color Application Rules

- Backgrounds:
- Cards/surfaces:
- Interactive elements:
- Hover states:
- Disabled states:

## Typography

<!-- TODO: Record exact font families, weights, and sizes from canonical screen -->

| Role | Font | Weight | Size | Line Height | Letter Spacing |
|---|---|---|---|---|---|
| Display / hero | | | | | |
| H1 | | | | | |
| H2 | | | | | |
| H3 | | | | | |
| Body | | | | | |
| Body small | | | | | |
| Caption / label | | | | | |
| Button text | | | | | |
| Code / mono | | | | | |

### Typography Rules

- **Font loading**:
- **Fallback stack**:
- **Maximum line length**:
- **Text alignment conventions**:

## Spacing & Rhythm

<!-- TODO: Record the spacing scale and rhythm conventions -->

- **Base unit**:
- **Scale**: <!-- e.g., 4, 8, 12, 16, 24, 32, 48, 64 -->
- **Section padding**:
- **Card padding**:
- **Inline element gap**:
- **Vertical rhythm between sections**:

## Geometry & Radius

<!-- TODO: Record border-radius and shape conventions -->

| Element | Radius |
|---|---|
| Buttons | |
| Cards | |
| Inputs | |
| Modals / dialogs | |
| Avatars | |
| Tags / badges | |
| Tooltips | |

## Elevation & Shadows

<!-- TODO: Record shadow and depth conventions -->

| Level | Shadow Value | Usage |
|---|---|---|
| None (flat) | | |
| Low | | |
| Medium | | |
| High | | |

### Elevation Rules

- **When to elevate**:
- **When to keep flat**:
- **Overlay backdrop**:

## Iconography

- **Icon set / source**:
- **Default size**:
- **Stroke weight**:
- **Color rule**:
- **Filled vs outlined**:

## Imagery & Art Direction

<!-- TODO: Record rules for images, illustrations, and visual assets -->

- **Photo style**:
- **Illustration style**:
- **Placeholder treatment**:
- **Aspect ratios**:
- **Border/overlay treatment**:
- **Empty state imagery**:

## Layout Patterns

<!-- TODO: Record the primary layout structures observed -->

### Page Layout

- **Max content width**:
- **Grid system**:
- **Sidebar behavior**:
- **Header behavior** (fixed / scrollable):

### Content Layout

- **Card grid pattern**:
- **List pattern**:
- **Dashboard panel arrangement**:
- **Form layout**:

## Navigation Patterns

- **Primary navigation style**:
- **Secondary navigation**:
- **Breadcrumb conventions**:
- **Active state indicator**:
- **Mobile navigation**:

## Component Styles

<!-- TODO: Record specific component conventions -->

### Buttons

| Variant | Background | Text | Border | Radius | Padding |
|---|---|---|---|---|---|
| Primary | | | | | |
| Secondary | | | | | |
| Ghost / text | | | | | |
| Danger | | | | | |
| Disabled | | | | | |

### Inputs & Forms

- **Input style**:
- **Label placement**:
- **Error display**:
- **Focus indicator**:

### Cards

- **Background**:
- **Border**:
- **Padding**:
- **Hover behavior**:

### Tables

- **Header style**:
- **Row striping**:
- **Border style**:
- **Sort indicators**:

### Modals & Dialogs

- **Overlay opacity**:
- **Container style**:
- **Animation**:
- **Close mechanism**:

### Notifications / Toasts

- **Position**:
- **Duration**:
- **Style variants**:

## Motion & Interaction

<!-- TODO: Record transition and animation conventions -->

- **Default transition duration**:
- **Easing function**:
- **Hover transitions**:
- **Page transitions**:
- **Loading indicators**:
- **Skeleton screens** (yes / no):
- **Scroll behavior**:

## Responsive Behavior

<!-- TODO: Record breakpoint and responsive conventions -->

| Breakpoint | Width | Layout Changes |
|---|---|---|
| Mobile | | |
| Tablet | | |
| Desktop | | |
| Wide | | |

### Responsive Rules

- **Navigation collapse point**:
- **Grid column changes**:
- **Typography scaling**:
- **Component adaptations**:

## Implementation Notes

<!-- TODO: Record any implementation-specific guidance -->

- **CSS methodology**:
- **Component library preference**:
- **State management notes**:
- **Accessibility requirements**:
- **Performance constraints**:

## Forbidden Patterns & Anti-Drift Rules

<!-- TODO: Record patterns that must NOT appear in this project -->

> These are explicit prohibitions. If you see these creeping in, the design has drifted from the contract.

- [ ] <!-- e.g., No drop shadows on flat cards -->
- [ ] <!-- e.g., No serif fonts outside of hero text -->
- [ ] <!-- e.g., No inline color values — always use contract tokens -->
- [ ] <!-- e.g., No rounded corners > 12px -->

---

*Last updated from screen*: <!-- screen ID or name -->
*Contract version*: 0
*Extraction date*: <!-- YYYY-MM-DD -->
