# Pandoc Templates Collection

A collection of templates for generating documents via Pandoc from Markdown sources.

## Templates

| Template | Description |
|----------|-------------|
| `simple.html` | Basic HTML template with minimal styling |
| `rich.html` | Bootstrap 5 template with 3-button theme control (Light/Dark/Yellow) and sidebar toggle |
| `default.opendocument` | Stock ODT template |
| `default.ms` | Stock DOCX template |

## Quick Start

### Build all documents from Markdown

```bash
bash build_resume.sh [OUTPUT_FOLDER]
```

Default output folder: `/tmp/pandoc_builder`

### Output files

- `{basename}_simple.html` - Basic HTML
- `{basename}_rich.html` - Rich HTML with theme switching
- `/tmp/resume_rich.html` - Preview of rich HTML
- `{basename}.pdf` - PDF (requires wkhtmltopdf)
- `{basename}.odt` - OpenDocument
- `{basename}.docx` - Word document

### Configuration

Edit `settings.env.txt` to configure:
- `FILE_BASENAME` - Output filename prefix
- `INPUT_FILE` - Source Markdown file
- `HTML_TEMPLATE_FILE` - Template for simple HTML
- `RICH_TEMPLATE_FILE` - Template for rich HTML
- `ODT_TEMPLATE_FILE` - Template for ODT format
- `DOCX_TEMPLATE_FILE` - Template for DOCX format

## Manual Generation

**HTML Simple:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/simple.html --metadata title="Title" --embed-resources -o output.html
```

**HTML Rich:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/rich.html --metadata title="Title" --embed-resources -o output.html
```

**PDF:**
```bash
pandoc resume.md -s --toc --toc-depth=3 -t html --pdf-engine=wkhtmltopdf --template=pandoc-templates/simple.html --metadata title="Title" -o output.pdf
```

**ODT:**
```bash
pandoc resume.md -s --toc --toc-depth=3 -t odt --template=pandoc-templates/default.opendocument -o output.odt
```

**DOCX:**
```bash
pandoc resume.md -s --toc --toc-depth=3 --template=pandoc-templates/default.ms -o output.docx
```

## CI Pipeline

See `.github/workflows/ci.yml` for the GitHub Actions pipeline that generates all formats on push/PR and uploads to GitHub Releases.

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
- Simple template: `pandoc-templates/simple.html`
- Preview output: `/tmp/resume_rich.html`
- See `AGENTS.md` for detailed UI preferences and design decisions
