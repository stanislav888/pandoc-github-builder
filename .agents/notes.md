# Technical Notes — Implementation Details

These notes capture the implementation specifics so new sessions don't need to reverse-engineer decisions. They complement `.agents/preferences.md` which holds only user wishes.

### Rule for Future Skill Additions
- User adds new skills to `.agents/skills/` (standard directory)
- LLM does NOT proactively search `.agents/skills/` on each run
- If LLM finds a skill in `.agents/skills/` (accidentally or by user command), it moves it to `.agents/skill-docs/<skill-name>/` and creates documentation
- LLM loads skills only when user explicitly gives a command
- Never add new skills to `.agents/skill-docs/` directly — always add to `.agents/skills/` first, then move upon user command
- Update skills table below and AGENTS.md reference files section when a skill is moved

## Template Variables in `rich.html`
- `$title$` — document title (in `<title>` tag)
- `$body$` — document body (rendered inside `<div id="content">`)
- `$toc$` — table of contents (rendered inside `<nav id="toc">`)
- `$default_theme$` — replaced by pandoc with `--metadata default_theme` value (JavaScript string literal)
- `$show_toc$` — replaced by pandoc with `--metadata show_toc` value (JavaScript string literal)
- These are pandoc template variables — substituted BEFORE output generation

## CSS Architecture in `rich.html`
- `:root` defines yellow theme CSS custom properties (default)
- `[data-theme="light"]` overrides with light theme CSS variables
- `[data-theme="dark"]` overrides with dark theme CSS variables
- `body.sidebar-collapsed #sidebar` applies `transform: translateX(-250px)`
- `body.sidebar-collapsed #content` sets `margin-left: 0`
- `transition` on `#sidebar` and `#content` for smooth animations
- `#sidebar nav` has `font-size: 0.9em`
- **Desktop (> 768px) base**: `#sidebar` has `position: fixed`, `width: 250px`, `height: 100%`, `left: 0`, `top: 0`; `#content` has `margin-left: 290px`
- **Mobile (<= 768px)**: `@media (max-width: 768px)` overrides `#sidebar` to `position: relative`, `width: 100%`; `#content` to `margin-left: 0`; controls switch from desktop to bottom bar

## JavaScript Functions in `rich.html`
- `getStorage(key)` — returns `localStorage.getItem(key)` wrapped in try-catch
- `setStorage(key, value)` — sets `localStorage.setItem(key, value)` wrapped in try-catch
- `setTheme(theme)` — sets `data-theme` on `<html>`, updates active button, stores to `localStorage`
- `setThemeMobile(theme)` — delegates to `setTheme(theme)`
- Theme button click handlers use `addEventListener` (not inline `onclick`)
- Sidebar toggle click handler uses `addEventListener` (not inline `onclick`)
- `DOMContentLoaded` event listener initializes everything
- `document.documentElement.setAttribute('data-theme', defaultTheme)` called on page load with configured default theme
- `document.getElementById('sidebarToggleBtn')` used for desktop toggle
- `document.getElementById('sidebarToggleBtnMobile')` used for mobile toggle

## Build Script (`build_resume.sh`)
- Reads all settings from `settings.env.txt` using `while IFS='=' read` loop
- Lines starting with `#` are skipped during parsing
- `SHOW_TOC` defaults to `true`, `DEFAULT_THEME` defaults to `yellow`
- `--metadata show_toc` only for HTML and PDF — stock ODT/DOCX templates don't use `$show_toc$`
- `--metadata default_theme` NOT passed to pandoc — template CSS `:root` defines yellow as default; `DEFAULT_THEME` is read from settings.env.txt for CI validation only
- `--embed-resources` NOT used — resources already embedded in template
- `--toc --toc-depth=3` and `--metadata title` used ONLY for HTML and PDF
- **NO `--toc`, NO `--metadata title`, NO `--metadata show_toc` for ODT and DOCX**
- **NO `--metadata default_theme` — template CSS `:root` defines yellow as default

## settings.env.txt
```
FILE_BASENAME="..."
INPUT_FILE="./resume.md"
RICH_TEMPLATE_FILE="./pandoc-templates/rich.html"
SHOW_TOC=true          # Only used for HTML and PDF
DEFAULT_THEME=yellow   # Only for CI validation, not passed to pandoc
ODT_TEMPLATE_FILE="./pandoc-templates/default.opendocument"
DOCX_TEMPLATE_FILE="./pandoc-templates/default.ms"
```
- `SHOW_TOC` and `DEFAULT_THEME` only used by HTML/PDF generation

## CI Pipeline (`.github/workflows/ci.yml`)
- `setup-file-names` job: loads settings.env.txt via dotenv, extracts `SHOW_TOC`, `DEFAULT_THEME`, `RICH_TEMPLATE_FILE`, template paths, file basename
- `build` job: calls `bash build_resume.sh ${OUTPUT_FOLDER}` which passes `--metadata show_toc` only to HTML and PDF commands, NOT to ODT/DOCX
- Uses `RICH_TEMPLATE_FILE` instead of `HTML_TEMPLATE_FILE`
- No `FILE_HTML_SIMPLE` or `HTML_TEMPLATE_FILE` references
- Tests matrix: PDF, DOCX, ODT, HTML (rich)

## Key HTML Structure in `rich.html`
- `<html lang="en">` carries `data-theme` attribute
- `<body>` has NO `data-theme` attribute
- Desktop controls: `<div class="controls-desktop">` with `id="sidebarToggleBtn"` and `[data-theme-btn]` buttons
- Mobile controls: `<div class="controls-mobile">` with `id="sidebarToggleBtnMobile"` and `[data-theme-btn-mobile]` buttons
- Sidebar: `<div id="sidebar"><nav id="toc">$toc$</nav></div>`
- Content: `<div id="content">$body$</div>`

## Skills (manual loading — NOT auto-discovered)

Skills are in `.agents/skill-docs/`. These are the LLM's working copies. Not auto-discovered by opencode or other agents. Load manually via `read` tool only when user gives a command.

| Skill | Source | When to Load |
|-------|--------|-------------|
| `bootstrap` | `.agents/skills/bootstrap/` → `.agents/skill-docs/bootstrap/SKILL.md` | Authoring/modifying HTML template layout, Bootstrap components, responsive grid |
| `bootstrap-mobile` | `.agents/skills/bootstrap-mobile/` → `.agents/skill-docs/bootstrap-mobile/SKILL.md` | Working on mobile responsive design, viewport issues |
| `pandoc` | `.agents/skills/pandoc/` → `.agents/skill-docs/pandoc/SKILL.md` | Editing pandoc templates, writing pandoc commands, template syntax |
| `bash-defensive-patterns` | `.agents/skills/bash-defensive-patterns/` → `.agents/skill-docs/bash-defensive-patterns/SKILL.md` | Writing bash scripts, CI/CD pipeline scripts, defensive programming |
| `create-github-action-workflow-specification` | `.agents/skills/create-github-action-workflow-specification/` → `.agents/skill-docs/create-github-action-workflow-specification/SKILL.md` | Creating/modifying CI workflow specifications |

**How to load:** Use `read` tool to read the SKILL.md file only when user explicitly gives a command. Do NOT load all skills at once. Do NOT search for skills proactively.

## Manual Generation Commands
```bash
# HTML Rich
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/rich.html --metadata title="..." --metadata show_toc=true -o output.html

# PDF
pandoc resume.md -s --toc --toc-depth=3 -t html --pdf-engine=wkhtmltopdf --template=pandoc-templates/rich.html --metadata title="..." --metadata show_toc=true -o output.pdf

# ODT
pandoc resume.md -s -t odt --template=pandoc-templates/default.opendocument -o output.odt

# DOCX
pandoc resume.md -s --template=pandoc-templates/default.ms -o output.docx
```

Preview output is `${OUTPUT_FOLDER}/${FILE_BASENAME}_rich.html` (same as the rich HTML output).

### Notes on manual commands
- `--metadata default_theme` not needed — template CSS `:root` defines yellow as default
- `--embed-resources` not needed — resources already embedded in template
- `--metadata show_toc` only for HTML and PDF — stock ODT/DOCX templates don't use `$show_toc$`
- `--toc --toc-depth=3` only for HTML and PDF
