# AGENTS.md

# Project: Pandoc Templates Collection

## Overview
A collection of templates for generating documents via Pandoc from Markdown sources.
Current templates: `default.ms`, `default.opendocument`, `rich.html`, `simple.html`.

## Goal
Generate clean, responsive documents from Markdown via Pandoc using Bootstrap 5 templates.
The working template is `pandoc-templates/rich.html`. Target markdown document is `./resume.md`.

## Skills
This project uses two skills, both loaded from `.agents/skills/`.
OpenCode auto-discovers them by scanning for `SKILL.md` files in this directory.

### `bootstrap`
- **Path:** `.agents/skills/bootstrap/SKILL.md`
- **Purpose:** Provides Bootstrap 5 layout patterns, CDN references, and responsive grid conventions used when authoring the HTML template.

### `pandoc`
- **Path:** `.agents/skills/pandoc/SKILL.md`
- **Purpose:** Documents Pandoc template syntax, required variables (`$title$`, `$body$`, `$toc$`, `$for(css)$`…`$endfor$`), and the CLI invocation used to build documents from Markdown.

**Rule:** Always consult the relevant skill before editing or creating templates. When a task touches both markup and template variables, load both skills.

## Rules
- New templates go into `pandoc-templates/`.
- Working template: `pandoc-templates/rich.html`.
- Simple template: `pandoc-templates/simple.html`.
- The template must use standard Pandoc variables: `$title$`, `$body$`, `$toc$`.
- `rich.html` should NOT be treated as read-only - it has been explicitly modified by the user with UI features and should be treated as the working template.
- Do not modify existing templates (`default.ms`, `default.opendocument`) unless explicitly asked.
- Always use standard Bootstrap's stylesheets for any HTML code.
- Any exceptional changes to Bootstrap styles wanted by user should be implemented in a 'diff' approach only to that case. Try to change common style instead of creating a new one.
- Do not create your own stylesheets until you can not implement it with Bootstrap's common stylesheets.
- Any style or script should be included into webpage to get offline viewer experience. Use 'pandoc --embed-resources=true' to reach that.
- Do not manipulate with git without explicit user command to add\delete new\outdated files under version control.
- The temporary file to view current changes is `file:///tmp/resume_rich.html`. Always generate it to show your work results.
- Use CDN if possible to pull scripts & stylesheets during document generation.
- Embed any necessary style or necessary scripts into the pandoc template.
- Always generate output document based on your outcome aside of gitlab CI pipelines.
- Always report at the very end of task about example documents generated.
- Theme switching uses `data-theme` attribute on `<html>` element, NOT `<body>`. `<body>` has no `data-theme` attribute to avoid CSS specificity conflicts.
- `localStorage` calls must always be wrapped in `try-catch` for `file://` protocol compatibility.
- `DOMContentLoaded` event used for all JS initialization - no inline `onclick` handlers.
- Sidebar collapse uses `transform: translateX(-250px)` (NOT `width: 0`) so the toggle button remains visible outside the sidebar bounds.

### No Emojis
- **Never use emojis** in any generated content, code, documentation, or comments.
- Professional standards require clean, emoji-free output.
- Use plain text or appropriate icons/symbols only when semantically necessary (e.g., CSS pseudo-elements, SVG icons from libraries).
- If a concept naturally calls for an emoji in source markdown, replace it with a text descriptor or Unicode symbol that is not a color-emoji character.

## Permissions
See `opencode.json` for read/write restrictions. In short:
- Read: only project files, `~/.config/opencode/**`, and `/var/log/**`.
- Write: only inside the project directory and `/tmp/**`.

Operating system: Debian 13
User mode access.

Target markdown template ./resume.md

There is 100% working html template ./pandoc-templates/rich.html

### Template Usage
- Consult `.agents/skills/` for skill documentation before creating or modifying templates.

## UI Preferences & Design Decisions

### Template: `rich.html`

This template is the fully implemented working template with all UI features. Do not treat it as read-only - it has been explicitly modified by the user.

#### HTML Structure
- `<html>` element carries `data-theme` attribute set via `document.documentElement.setAttribute('data-theme', ...)`
- `<body>` has NO `data-theme` attribute
- Three control buttons in a single `btn-group` at top-right: **Show TOC/Hide TOC**, **Light**, **Dark**, **Yellow**
- Button `id="sidebarToggleBtn"` for the sidebar toggle
- Theme buttons have `data-theme-btn` attribute with values `light`, `dark`, `yellow`

#### Theme Switching (3-Button Control)
- Three buttons in a `btn-group`: **Light**, **Dark**, **Yellow**
- The `data-theme` attribute on `<html>` controls the active theme via CSS selectors
- Buttons are `btn-outline-secondary` with `font-weight: bold`
- Theme is controlled via `data-theme` attribute on `<html>` element (set via `document.documentElement.setAttribute`)
- CSS custom properties (`--*` variables) in `:root`, `[data-theme="light"]`, `[data-theme="dark"]` selectors drive all theming
- `:root` defines yellow theme variables (default)
- `[data-theme="light"]` overrides with light theme
- `[data-theme="dark"]` overrides with dark theme
- Theme selection persisted to `localStorage` under key `pandoc-theme`
- `localStorage` calls wrapped in `try-catch` for `file://` protocol compatibility
- `DOMContentLoaded` event used for all JS initialization (no inline `onclick` handlers)
- The default theme is set via `$default_theme$` pandoc template variable, which gets its value from the `DEFAULT_THEME` setting in `settings.env.txt`
- Valid theme values: `light`, `dark`, `yellow`
- `document.documentElement.setAttribute('data-theme', defaultTheme)` is called on page load, ALWAYS using the configured default theme

#### Sidebar Toggle
- Toggle button ("Show TOC" / "Hide TOC") is **leftmost** in the combined `btn-group` at top-right
- Button has `font-weight: bold` for clear visibility
- Button is inside the `btn-group` (not a separate fixed element)
- Sidebar uses `transform: translateX(-250px)` for collapse animation (NOT `width: 0`)
- `body.sidebar-collapsed #sidebar` applies `transform: translateX(-250px)`
- `body.sidebar-collapsed #content` sets `margin-left: 0`
- `transition` on `#sidebar` and `#content` for smooth animations
- The initial sidebar state is controlled by `$show_toc$` template variable (from `SHOW_TOC` setting in `settings.env.txt`)
- If `SHOW_TOC` is not `'true'`, sidebar starts collapsed
- Sidebar collapse state persisted to `localStorage` under key `sidebar-toggle`
- `DOMContentLoaded` reads `$show_toc$` metadata directly (not localStorage) to set initial state
- `document.getElementById('sidebarToggleBtn')` used to get the toggle button

#### Key JavaScript Functions
- `getStorage(key)` - returns `localStorage.getItem(key)` wrapped in try-catch
- `setStorage(key, value)` - sets `localStorage.setItem(key, value)` wrapped in try-catch
- `setTheme(theme)` - sets `data-theme` on `<html>`, updates active button, stores to `localStorage`
- Theme button click handlers use `addEventListener` (not inline `onclick`)
- Sidebar toggle click handler uses `addEventListener` (not inline `onclick`)
- `DOMContentLoaded` event listener initializes everything

#### Key CSS Architecture
- `:root` defines yellow theme CSS custom properties (default)
- `[data-theme="light"]` overrides with light theme CSS variables
- `[data-theme="dark"]` overrides with dark theme CSS variables
- `body.sidebar-collapsed #sidebar` applies `transform: translateX(-250px)`
- `body.sidebar-collapsed #content` sets `margin-left: 0`
- `transition` on `#sidebar` and `#content` for smooth animations
- `#sidebar` has `position: fixed`, `width: 250px`, `height: 100%`
- `#content` has `margin-left: 290px`
- `#sidebar nav` has `font-size: 0.9em`

#### Pandoc Template Variables in `rich.html`
- `$title$` - document title (in `<title>` tag)
- `$toc$` - table of contents (rendered inside `<nav id="toc">`)
- `$body$` - document body (rendered inside `<div id="content">`)
- `$default_theme$` - replaced by pandoc with `--metadata default_theme` value (JavaScript string literal)
- `$show_toc$` - replaced by pandoc with `--metadata show_toc` value (JavaScript string literal)
- These are pandoc template variables - they get substituted BEFORE the output is generated

#### Generation
- Preview always generated at `/tmp/resume_rich.html`
- Command: `pandoc resume.md -s --template=pandoc-templates/rich.html --toc --toc-depth=3 --metadata title="..." -o /tmp/resume_rich.html`
- Build script `build_resume.sh` generates both `{basename}_simple.html` and `{basename}_rich.html`

## Document Generation Guide

### Overview
All document generation is handled by `build_resume.sh`, which reads configuration from `settings.env.txt`. The script generates documents in 6 formats from a single Markdown source (`./resume.md`).

### Configuration (`settings.env.txt`)
- `FILE_BASENAME` - Output filename prefix
- `INPUT_FILE` - Source Markdown file
- `HTML_TEMPLATE_FILE` - Template for simple HTML (`simple.html`)
- `RICH_TEMPLATE_FILE` - Template for rich HTML (`rich.html`)
- `SHOW_TOC` - Whether sidebar starts expanded (`true`/`false`)
- `DEFAULT_THEME` - Default theme: `light`, `dark`, or `yellow`
- `ODT_TEMPLATE_FILE` - Template for ODT format
- `DOCX_TEMPLATE_FILE` - Template for DOCX format

### Output Files
| Format | Output Filename | Template | Flags |
|--------|----------------|----------|-------|
| HTML Simple | `{basename}_simple.html` | `simple.html` | `-s --toc --toc-depth=3 --metadata show_toc=... --metadata default_theme=... --embed-resources` |
| HTML Rich | `{basename}_rich.html` | `rich.html` | `-s --toc --toc-depth=3 --metadata show_toc=... --metadata default_theme=... --embed-resources` |
| Preview | `/tmp/resume_rich.html` | `rich.html` | Copy of rich HTML |
| PDF | `{basename}.pdf` | `simple.html` | `-t html --pdf-engine=wkhtmltopdf --metadata show_toc=... --metadata default_theme=...` |
| ODT | `{basename}.odt` | `default.opendocument` | `-t odt --metadata show_toc=... --metadata default_theme=...` |
| DOCX | `{basename}.docx` | `default.ms` | `--metadata show_toc=... --metadata default_theme=...` |

### Build Script (`build_resume.sh`)
Usage: `bash build_resume.sh [OUTPUT_FOLDER]`
- Default output folder: `/tmp/pandoc_builder`
- Reads all settings from `settings.env.txt`
- The `while IFS='=' read` loop parses settings; lines starting with `#` are skipped
- `SHOW_TOC` defaults to `true`, `DEFAULT_THEME` defaults to `yellow`
- `--metadata show_toc="$SHOW_TOC"` and `--metadata default_theme="$DEFAULT_THEME"` passed to ALL pandoc commands (HTML, PDF, ODT, DOCX)
- `rich.html` template uses `$default_theme$` and `$show_toc$` pandoc variables, replaced by metadata values
- Generates both HTML variants (simple + rich)
- Generates PDF, ODT, DOCX
- Copies rich HTML to `/tmp/resume_rich.html` for preview
- Skips PDF if `wkhtmltopdf` not installed

### Manual Generation Commands

**HTML Simple:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/simple.html --metadata title="Dmitry Ivanov" --metadata show_toc=true --metadata default_theme=yellow --embed-resources -o /tmp/preview_simple.html
```

**HTML Rich (Preview):**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/rich.html --metadata title="Dmitry Ivanov" --metadata show_toc=true --metadata default_theme=yellow --embed-resources -o /tmp/resume_rich.html
```

**PDF:**
```bash
pandoc resume.md -s --toc --toc-depth=3 -t html --pdf-engine=wkhtmltopdf --template=pandoc-templates/simple.html --metadata title="Dmitry Ivanov" --metadata show_toc=true --metadata default_theme=yellow -o /tmp/resume.pdf
```

**ODT:**
```bash
pandoc resume.md -s --toc --toc-depth=3 -t odt --template=pandoc-templates/default.opendocument --metadata show_toc=true --metadata default_theme=yellow -o /tmp/resume.odt
```

**DOCX:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/default.ms --metadata show_toc=true --metadata default_theme=yellow -o /tmp/resume.docx
```

### CI Pipeline (`.github/workflows/ci.yml`)
- Triggers on push/PR to `main`/`dev` branches
- `setup-file-names` job loads settings.env.txt via dotenv, extracts `SHOW_TOC` and `DEFAULT_THEME` as env vars
- `build` job passes `--metadata show_toc="${SHOW_TOC}"` and `--metadata default_theme="${DEFAULT_THEME}"` to all pandoc commands
- Generates all 6 output formats
- Uploads artifacts as GitHub Release
- Tests all generated files for existence and non-emptiness
- Uploads to GitHub Releases on manual workflow dispatch from `main`

### Notes
- All HTML generation uses `-s --toc --toc-depth=3 --embed-resources` flags
- `--metadata show_toc` and `--metadata default_theme` passed to ALL formats (HTML, PDF, ODT, DOCX)
- `rich.html` uses `$default_theme$` and `$show_toc$` pandoc template variables (replaced by pandoc with metadata values)
- PDF generation uses `simple.html` template (embedded CSS works better with wkhtmltopdf)
- ODT and DOCX use stock pandoc templates (`default.opendocument`, `default.ms`)
- `--embed-resources` ensures images and CSS are embedded for offline viewing
- The `--toc --toc-depth=3` flag generates a 3-level table of contents
