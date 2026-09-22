# Pandoc Templates Collection

A collection of templates for generating documents via Pandoc from Markdown sources.

## Templates

| Template | Description |
|----------|---------------------------------|
| `rich.html` | Template with 3-button theme control (Light/Dark/Yellow) and sidebar toggle |
| `default.opendocument` | Stock ODT template |
| `default.ms` | Stock DOCX template |

## Features of the `rich.html` template

- **3-Button Theme Control**: Light, Dark, Yellow (default)
- **Sidebar Toggle**: "Hide TOC" / "Show TOC" button
- **Responsive Design**: Bootstrap 5 grid system
- **Offline Viewer**: `pandoc --embed-resources` embeds all assets into the html file 

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

## CI Pipeline

See `.github/workflows/ci.yml` for the GitHub Actions pipeline that generates all formats on push/PR, validates settings, deploys to GitHub Pages, and uploads to GitHub Releases.

## Hyperlinks to Resume Files

At the `deploy-pages` step of the CI pipeline, the direct links to each generated file are printed in the build logs:

For instance:  

Resume (HTML):  [https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume_rich.html](https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume_rich.html)  
Resume (PDF):   [https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.pdf](https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.pdf)  
Resume (DOCX):  [https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.docx](https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.docx)  
Resume (ODT):   [https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.odt](https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.odt)  


