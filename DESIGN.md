# Med Spa Revenue OS — UI Guideline

## 1. Context and goals

**Design intent:** a dark, high-contrast marketing site whose every visual decision
resolves to a named token, so the operational credibility of the product is mirrored
by the consistency of its interface.

Surface: marketing site. Audience: U.S. med spa owners and decision-makers.
Tone: concise, confident, implementation-focused.

## 2. Design tokens and foundations

All tokens live in `assets/css/tokens.css`. **Raw hex values must not appear outside
that file** — verify with:

```sh
grep -nE '#[0-9a-fA-F]{3,8}\b' assets/css/styles.css index.html   # must return nothing
```

### Color

Spec tokens are used verbatim. Because `design.md` supplies five colors and a dark
`color.surface.base`, an elevation ramp, border set, focus ring and accent were
**derived** to satisfy the required state rules; all are declared in `tokens.css` as
primitives and exposed only through semantic names.

| Semantic token | Role | Contrast |
| --- | --- | --- |
| `--color-text-primary` | body + headings on base | 20.29:1 |
| `--color-text-secondary` | supporting copy | 7.94:1 on base, 6.80:1 on card |
| `--color-text-accent` | accent labels, emphasis | 12.90:1 |
| `--color-text-danger` | error text | 9.46:1 |
| `--color-focus-ring` | focus-visible outline | 14.56:1 |
| `--color-action-primary-label` on accent | primary button label | 10.74:1 |

Every pair exceeds the WCAG 2.2 AA 4.5:1 text threshold.

### Type, spacing, radius, motion

Type and radius scales are the spec scales, unmodified. Two display steps
(`--font-size-5xl/6xl`) extend the scale for hero type using fluid `clamp()`.

The spec spacing scale tops out at 24px, which cannot express section rhythm, so it is
**continued on the same progression** as `--space-9…13` (32/48/64/96/128). This is an
extension of the scale, not a set of one-off exceptions: no component may introduce a
spacing value outside these tokens.

Motion uses the three spec durations. All animation collapses to 1ms under
`prefers-reduced-motion: reduce`.

## 3. Component rules

Every interactive component defines **default, hover, focus-visible, active, disabled,
loading and error**. Focus-visible is enforced globally and must never be removed:

```css
:where(a, button, input, select, textarea, summary, [tabindex]):focus-visible {
  outline: var(--focus-ring-width) solid var(--color-focus-ring);
  outline-offset: var(--focus-ring-offset);
}
```

### Button (`.btn`)

- **Variants:** `--primary` (filled accent), `--secondary` (outline), `--full` (block).
- **States:** hover shifts to `--color-action-primary-press`; active translates 1px;
  `[disabled]`/`[aria-disabled=true]` drop to 45% opacity and block pointer events;
  `[data-loading=true]` hides the label and shows a spinner, keeping button width so
  layout must not shift.
- **Target size:** `min-height: 44px` — WCAG 2.2 *Target Size (Minimum)*.
- **Pointer/touch:** the whole box is the hit area; no hover-only affordance.
- **Long content:** labels are `white-space: nowrap`; wrap to `--full` on narrow
  viewports rather than truncating — a truncated action label is a prohibited pattern.

### Navigation (`.header`, `.nav`, `.nav-panel`)

- Desktop nav appears at ≥60rem; below that a disclosure button controls `#nav-panel`.
- **Keyboard:** Enter/Space toggle (native `<button>`); Escape closes and returns focus
  to the trigger; focus is never trapped. Selecting a link closes the panel.
- The toggle carries `aria-expanded` and `aria-controls`; its label swaps Menu/Close.
- Crossing the desktop breakpoint force-closes the panel so state cannot desync.

### Card (`.card`)

Anatomy: optional index → heading → body → optional tag pinned to the bottom via
`margin-top: auto`, so cards in a row align regardless of body length.
Hover raises the surface and border. Non-interactive by default; a card must not be made
clickable without an explicit focusable control inside it.

### Accordion (`.faq`)

- Independent disclosures — more than one may be open.
- **Keyboard:** Enter/Space toggle; ArrowUp/ArrowDown cycle between triggers;
  Home/End jump to first/last.
- Each trigger is a `<button>` inside an `<h3>` with `aria-expanded` + `aria-controls`;
  each panel is a labelled `region`. Panels use the `hidden` attribute, so collapsed
  content is removed from the accessibility tree and from find-in-page.
- **Without JS** the triggers are inert but all content remains in the DOM.

### Calculator (`[data-calc]`)

- Anatomy: six range inputs, each with `<label>`, live `<output>` mirror, hint and a
  pre-wired error message; results in an `aria-live="polite"` region.
- **Keyboard:** native range semantics — arrows step, Home/End jump, PageUp/PageDown
  page. No custom key handling that would override them.
- **Error state:** out-of-range input sets `data-invalid="true"` on the field, revealing
  the `role="alert"` message and recoloring the track; the model clamps rather than
  rendering `NaN`.
- **Edge cases:** a modeled lift can never push a rate past 100% (`Math.min(rate*k, 1)`);
  the headline delta floors at zero, so the page never advertises a negative "gain".
- Results are labelled *illustrative* at the model, the caption and the footer.

## 4. Accessibility acceptance criteria

Testable pass/fail:

| # | Criterion | How to verify | Status |
| --- | --- | --- | --- |
| A1 | Zero axe-core violations (wcag2a/aa, wcag21aa, wcag22aa) | run axe on the page | **0 violations, 44 passes** |
| A2 | All text ≥ 4.5:1 | contrast table above | **min 6.80:1** |
| A3 | First tab stop is a working skip link | Tab from load | **pass** |
| A4 | Every focusable control shows a 3px visible ring | Tab through page | **pass** |
| A5 | Accordion operable by keyboard alone incl. arrows/Home/End | keyboard test | **pass** |
| A6 | Mobile nav closes on Escape and restores focus | keyboard test | **pass** |
| A7 | Interactive targets ≥ 44px | inspect `min-height` | **pass** |
| A8 | No horizontal scroll at 375px | measure `scrollWidth` | **0px overflow** |
| A9 | Animation suppressed under reduced-motion | emulate the media feature | **pass** |
| A10 | Page is readable and complete with JS disabled | disable JS | **pass (accordion inert, content present)** |

## 5. Content and tone standards

Concise, confident, implementation-focused. Name the mechanism, not the mood.

- Do: "Missed appointments trigger a recovery journey."
- Don't: "Revolutionize your patient experience!"
- Actions state their outcome: "Book My Revenue Audit", not "Submit" or "Click here".
- Every modeled figure is labelled illustrative and paired with a qualifier naming the
  real dependencies (traffic, offer, market, service mix, execution).

## 6. Anti-patterns — prohibited

- Raw hex, px or ms values in component CSS. Add a token instead.
- Removing or dimming a focus outline for aesthetics.
- Communicating state by color alone.
- Placeholder text used as a label.
- Truncating an action label, or a non-descriptive one ("Learn more" with no object).
- A clickable card with no focusable control inside it.
- Presenting a modeled projection as a guaranteed result.

## 7. QA checklist

- [ ] `grep -nE '#[0-9a-fA-F]{3,8}' assets/css/styles.css index.html` returns nothing
- [ ] axe-core reports 0 violations
- [ ] Tab order is logical; skip link first; no focus trap
- [ ] Each of the seven states verified on every interactive component
- [ ] 375 / 768 / 1440 render with no horizontal scroll
- [ ] Calculator matches the reference figures (180 / 35 / 70 / 45 / $650 / 15% →
      **$6,719**, 20 → 30 patients, $12,899 → $19,618)
- [ ] Reduced-motion honored
- [ ] Page usable with JS disabled
