# AGENTS.md

# Project: Pandoc Templates Collection

## Overview
A collection of templates for generating documents via Pandoc from Markdown sources.
Current templates: `default.ms`, `default.opendocument`, `rich.html`.

## Goal
Generate clean, responsive documents from Markdown via Pandoc using Bootstrap 5 templates.
The working template is `pandoc-templates/rich.html`. Target markdown document is `./resume.md`.

## Rules
- New templates go into `pandoc-templates/`.
- Working template: `pandoc-templates/rich.html`.
- The template must use standard Pandoc variables: `$title$`, `$body$`, `$toc$`.
- `rich.html` should NOT be treated as read-only - it has been explicitly modified by the user with UI features and should be treated as the working template.
- Do not modify existing templates (`default.ms`, `default.opendocument`) unless explicitly asked.
- Always use standard Bootstrap's stylesheets for any HTML code.
- Any exceptional changes to Bootstrap styles wanted by user should be implemented in a 'diff' approach only to that case. Try to change common style instead of creating a new one.
- Do not create your own stylesheets until you can not implement it with Bootstrap's common stylesheets.
- Any style or script should be included into webpage to get offline viewer experience. Use 'pandoc --embed-resources=true' to reach that.
- Do not manipulate with git without explicit user command to add\delete new\outdated files under version control.
- The preview output is `${OUTPUT_FOLDER}/${FILE_BASENAME}_rich.html` (same as the rich HTML output)
- Use CDNs if possible to pull scripts & stylesheets during document generation.
- Embed any necessary style or necessary scripts into the pandoc template.
- Always call 'build_resume.sh' at an end of any project changes.

## Permissions
See `opencode.json` for read/write restrictions. In short:
- Read: only project files, `~/.config/opencode/**`, and `/var/log/**`.
- Write: only inside the project directory and `/tmp/**`.

### Reference Files
- `.agents/preferences.md` — user preferences and design decisions (do not modify unless explicitly asked by user)
- `.agents/notes.md` — implementation details and technical reference (maintain yourself when implementation details change)

### Skills Workflow
- `.agents/skills/` — standard directory where user adds skill files
- `.agents/skill-docs/` — LLM's working copy. If a skill is found in `.agents/skills/`, move it here and create documentation
- LLM does NOT proactively search `.agents/skills/` on each run
- LLM loads skills only when user explicitly gives a command to do so
- **Rule:** Never add new skills to `.agents/skill-docs/` directly — always add to `.agents/skills/` first, then LLM move to `.agents/skill-docs/` with appropriate handling
- Any new skills added by user go into `.agents/skills/`

## Document Generation Guide

All document generation is handled by `build_resume.sh`, which reads configuration from `settings.env.txt`.

### Configuration (`settings.env.txt`)
- `FILE_BASENAME` - Output filename prefix
- `INPUT_FILE` - Source Markdown file
- `RICH_TEMPLATE_FILE` - Template for rich HTML (`rich.html`)
- `SHOW_TOC` - Whether sidebar starts expanded by default (`true`/`false`)
- `DEFAULT_THEME` - Default theme: `light`, `dark`, or `yellow`
- `ODT_TEMPLATE_FILE` - Template for ODT format
- `DOCX_TEMPLATE_FILE` - Template for DOCX format

### Output Files
| Format | Output Filename | Template |
|--------|----------------|----------|
| HTML Rich | `{basename}_rich.html` | `rich.html` |
| Preview | `${OUTPUT_FOLDER}/${FILE_BASENAME}_rich.html` | same as rich HTML output |
| PDF | `{basename}.pdf` | `rich.html` |
| ODT | `{basename}.odt` | `default.opendocument` |
| DOCX | `{basename}.docx` | `default.ms` |

### CI Pipeline (`.github/workflows/ci.yml`)
- Triggers on push/PR to `main`/`dev` branches
- `setup-file-names` job loads settings.env.txt via dotenv, extracts `SHOW_TOC` and `DEFAULT_THEME` as env vars
- `build` job passes `--metadata show_toc` and `--metadata default_theme` to all pandoc commands
- Generates all output formats
- Uploads artifacts as GitHub Release
- Tests all generated files for existence and non-emptiness
