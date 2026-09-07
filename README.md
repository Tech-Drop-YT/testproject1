# Med Spa Revenue OS — marketing site

Static, token-driven redesign of acquirebook.com. No build step, no dependencies.

```
index.html            single page
assets/css/tokens.css design tokens — the only file allowed to contain raw hex
assets/css/styles.css layout + components
assets/js/main.js     nav, accordion, calculator (progressive enhancement)
DESIGN.md             design system guideline + QA checklist
```

## Run

Open `index.html`, or serve it:

```sh
python3 -m http.server 8000
```

## Verified

- axe-core: **0 violations**, 44 passes (WCAG 2.0/2.1/2.2 A + AA)
- Contrast: every text pair ≥ 6.80:1 (AA requires 4.5:1)
- No horizontal overflow at 375px
- Calculator reproduces the published figures exactly

See `DESIGN.md` for the full token reference, component state rules and QA checklist.
