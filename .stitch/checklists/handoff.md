# Handoff Checklist

> Run through this checklist when transitioning a design from Stitch approval to local implementation.

## Design Completion

- [ ] Screen approved in Stitch — no further design changes planned
- [ ] Screenshot captured and saved to `.stitch/designs/images/{{surface-name}}.png`
- [ ] HTML exported and saved to `.stitch/designs/html/{{surface-name}}.html` (if applicable)
- [ ] Any additional exports saved to `.stitch/designs/exports/`
- [ ] `metadata.json` updated with screen record and artifact paths
- [ ] `SITE.md` page status updated to "approved"

## Design Contract Verification

- [ ] Surface conforms to `DESIGN.md` color system
- [ ] Surface conforms to `DESIGN.md` typography
- [ ] Surface conforms to `DESIGN.md` spacing and geometry
- [ ] Surface conforms to `DESIGN.md` component styles
- [ ] No forbidden patterns present
- [ ] Design contract version noted

## Implementation Preparation

- [ ] Components to extract identified and listed
- [ ] Shared vs. page-specific elements distinguished
- [ ] Responsive behavior documented or noted
- [ ] Interactive states identified (hover, focus, active, disabled, loading)
- [ ] Data requirements identified (static content vs. dynamic)
- [ ] Asset requirements listed (images, icons, fonts)

## Handoff Artifacts

- [ ] Implementation notes written in handoff prompt or `SITE.md`
- [ ] `next-prompt.md` updated to implementation task (or next design task)
- [ ] Previous baton marked complete

## Post-Implementation Verification

- [ ] Local implementation visually matches approved design
- [ ] All interactive states implemented
- [ ] Responsive behavior implemented
- [ ] Accessibility basics in place (semantic HTML, alt text, keyboard nav)
- [ ] `SITE.md` page status updated to "implemented"
