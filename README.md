# Pandoc Templates Collection

A collection of templates for generating documents via Pandoc from Markdown sources.

## Templates

| Template | Description |
|----------|---------------------------------|
| `rich.html` | Template with 3-button theme control (Light/Dark/Yellow) and sidebar toggle |
| `default.opendocument` | Stock ODT template |
| `default.ms` | Stock DOCX template |

## Quick Start

### Build all documents from Markdown

```bash
bash build_resume.sh [OUTPUT_FOLDER]
```

Default output folder: `/tmp/pandoc_builder`
CI output folder: `./release`

### Output files

- `{basename}_rich.html` - Rich HTML with theme switching (also the preview)
- `{basename}.pdf` - PDF (requires wkhtmltopdf)
- `{basename}.odt` - OpenDocument
- `{basename}.docx` - Word document

### Configuration

Edit `settings.env.txt` to configure:
- `FILE_BASENAME` - Output filename prefix (default: `Dmitry_Ivanov_C++_Software_Developer_resume`)
- `INPUT_FILE` - Source Markdown file (default: `./resume.md`)
- `RICH_TEMPLATE_FILE` - Template for rich HTML (default: `./pandoc-templates/rich.html`)
- `SHOW_TOC` - Whether sidebar starts expanded (`true`/`false`, default: `true`)
- `DEFAULT_THEME` - Default theme: `light`, `dark`, or `yellow` (default: `yellow`)
- `ODT_TEMPLATE_FILE` - Template for ODT format (default: `./pandoc-templates/default.opendocument`)
- `DOCX_TEMPLATE_FILE` - Template for DOCX format (default: `./pandoc-templates/default.ms`)

## Manual Generation

**HTML Rich:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/rich.html --metadata title="Title" --metadata show_toc=true -o output.html
```

**PDF:**
```bash
pandoc resume.md -s --toc --toc-depth=3 -t html --pdf-engine=wkhtmltopdf --template=pandoc-templates/rich.html --metadata title="Title" --metadata show_toc=true -o output.pdf
```

**ODT:**
```bash
pandoc resume.md -s -t odt --template=pandoc-templates/default.opendocument -o output.odt
```

**DOCX:**
```bash
pandoc resume.md -s --template=pandoc-templates/default.ms -o output.docx
```

## CI Pipeline

See `.github/workflows/ci.yml` for the GitHub Actions pipeline that generates all formats on push/PR, validates settings, deploys to GitHub Pages, and uploads to GitHub Releases.

## Features of `rich.html`

- **3-Button Theme Control**: Light, Dark, Yellow (default)
- **Sidebar Toggle**: "Hide TOC" / "Show TOC" button
- **CSS Custom Properties**: All themes driven by `--*` variables
- **localStorage Persistence**: Theme and sidebar state saved
- **Responsive Design**: Bootstrap 5 grid system
- **Offline Viewer**: `--embed-resources` embeds all assets

## Development

- Target markdown source: `./resume.md`
- Working template: `pandoc-templates/rich.html`
- Preview output: `/tmp/pandoc_builder/{basename}_rich.html`
- See `AGENTS.md` for detailed UI preferences and design decisions
