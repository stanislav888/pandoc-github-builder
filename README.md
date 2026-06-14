# Resume Builder – GitHub Actions CI/CD Pipeline

Automated CI/CD pipeline that builds a professional resume from Markdown using Pandoc. Generates PDF, DOCX, ODT, and live HTML formats with manual GitHub Releases.

## 🚀 Quick Start

### 1. Fork this repository

Click **Fork** on the [source repository](https://github.com/stanislav888/pandoc-github-builder) to create your own copy.

### 2. Clone your fork

```bash
git clone https://github.com/<YOUR_GIHUB_USERNAME>/pandoc-github-builder.git
cd pandoc-github-builder
```

### 3. Replace the resume content

Edit `resume.md` with your own Markdown resume.

### 4. Configure base filename (required)

Edit `settings.env.txt` and change `FILE_BASENAME`:

```env
FILE_BASENAME="Your_Name_Position_Resume"
```

All other variables can remain as is.

### 5. Push to GitHub

```bash
git commit -am "Update resume"
git push origin main
```

### 6. Download generated files

- Go to **Actions** → **Build Resume** → select latest run
- Under **Artifacts**, download `Resume`

> Any intermediate version can be downloaded from artifacts; no release required.

---

## 📦 Publishing a Release (Manual)

Triggered manually from `main` branch only:

1. **Actions** → **Build Resume** → **Run workflow** (select `main` branch)
2. After completion, a `resume-latest` release appears in **Releases**

Contains all formats: PDF, DOCX, ODT, HTML.
> Each manual workflow run overwrites previous release – only the latest version is kept.
---

## 📁 Project Structure

```
├── .github/workflows/ci.yml      # Pipeline definition
├── resume.md                      # Your Markdown resume
├── settings.env.txt               # Configuration (edit FILE_BASENAME)
├── pandoc-templates/              # Pandoc templates
│   ├── sidebar-green-template.html
│   ├── default.opendocument
│   └── default.ms
└── README.md
```

---

## ⚙️ How It Works

1. Push to `main` or `dev` → triggers workflow
2. Loads `settings.env.txt` and validates required variables
3. Installs Pandoc and wkhtmltopdf to a GitHub virtual machine
4. Generates all document formats inside the virtual machine
5. Saves artifacts (available for 7 days)
6. Manual release (optional) publishes to GitHub Releases

---

## 📝 Templates

This project uses **Pandoc template format**. The HTML template (`sidebar-green-template.html`) was generated with the assistance of an AI chatbot.

Templates are sourced from Pandoc distribution:

| Template | Source | License |
|----------|--------|---------|
| `default.opendocument` | Pandoc stock | GPL-2.0-or-later |
| `default.ms` | Pandoc stock | GPL-2.0-or-later |
| `sidebar-green-template.html` | Custom (AI‑generated) | MIT |

All original content in this repository is distributed under **MIT License** (`SPDX: MIT`).

---

## 🙏 Acknowledgements

- [Pandoc](https://pandoc.org/) – Document converter
- [wkhtmltopdf](https://wkhtmltopdf.org/) – HTML to PDF renderer
- [GitHub Actions](https://github.com/features/actions) – Automation platform

---
