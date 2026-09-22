# Resume Builder – GitHub Actions CI/CD Pipeline

Automated CI/CD pipeline that builds a professional resume from Markdown using Pandoc. Generates PDF, DOCX, ODT, and live HTML formats, with optional manual publishing to GitHub Releases and GitHub Pages.

## 🚀 Quick Start

### 1. Fork this repository

Click **Fork** on the [source repository](https://github.com/stanislav888/pandoc-github-builder) to create your own copy.

### 2. Clone your fork

```bash
git clone https://github.com/<YOUR_GITHUB_USERNAME>/pandoc-github-builder.git
cd pandoc-github-builder
```

Alternatively, use the GitHub web editor to edit all the files within your fork.

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

- Go to **Actions** → **Build Resume** → select the latest run.
- Under **Artifacts** (very bottom), download `Resume`.

Any intermediate version can be downloaded from artifacts; no release required.

---

## Publishing a Release and Deploying to Pages

Both publishing jobs run automatically as part of the workflow on the `main` branch. No manual trigger is required. Pushes to `dev` only build and test artifacts; they do not publish anything. Download them as described at #6 above.

### Release

When the workflow runs on the `main` branch, the `upload-release` job creates or overwrites the `resume-latest` release under **Releases**.

The release contains all formats: PDF, DOCX, ODT, HTML. Each run overwrites the previous release — only the latest version is kept.

### Deploy to GitHub Pages

When the workflow runs on the `main` branch, the `deploy-pages` job publishes the generated HTML resume to GitHub Pages and prints direct links to all generated files in the workflow log.

Before the first deployment, GitHub Pages must be enabled and the deployment branches must be allowed. This is a one-time setup per repository.

1. Go to **Settings** → **Pages**.
2. Set **Source** to **GitHub Actions**.
3. Go to **Settings** → **Environments** → **github-pages** → **Deployment branches and tags**.
4. Add a rule for the `main` branch.

Without these settings, the `deploy-pages` job fails with `Get Pages site failed` or `Branch ... is not allowed to deploy`.

After this setup, the `deploy-pages` job publishes the contents of the `release/` folder to `https://<username>.github.io/<repository>/`. Every generated file becomes available at a direct URL formed as `<page-url>/<file-name>`, for example `https://<username>.github.io/<repository>/<file_basename>_rich.html`. The workflow log lists the root URL and the direct links to all the files.

A log example:

```log
Root URL:       https://stanislav888.github.io/pandoc-github-builder/
Resume (HTML):  https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume_rich.html
Resume (PDF):   https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.pdf
Resume (DOCX):  https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.docx
Resume (ODT):   https://stanislav888.github.io/pandoc-github-builder/Dmitry_Ivanov_C++_Software_Developer_resume.odt
```

---

## 📁 Project Structure

```
├── .github/workflows/ci.yml      # Pipeline definition
├── resume.md                     # Your Markdown resume
├── settings.env.txt              # Configuration (edit FILE_BASENAME)
├── pandoc-templates/             # Pandoc templates
│   ├── rich.html                 # Rich HTML template (themes, sidebar)
│   ├── pdf.html                  # PDF template (for wkhtmltopdf)
│   ├── default.opendocument
│   └── default.ms
└── README.md
```

---

## ⚙️ How It Works

1. A push to `main` or `dev` triggers the workflow.
2. `settings.env.txt` is loaded and required variables are validated.
3. Pandoc and wkhtmltopdf are installed on a GitHub virtual machine.
4. All document formats are generated inside the virtual machine.
5. Artifacts are saved (available for 7 days).
6. Deployment jobs runs in case of the `main` branch

---

## 📝 Templates

This project uses the **Pandoc template format**. 

| Template | Source | License |
|----------|--------|---------|
| `rich.html` | Custom (AI‑generated) | MIT |
| `pdf.html` | Custom (AI‑generated) | MIT |
| `default.opendocument` | Pandoc stock | GPL-2.0-or-later |
| `default.ms` | Pandoc stock | GPL-2.0-or-later |

## License

All original content in this repository is distributed under the **MIT License** (`SPDX: MIT`).

---

## 🙏 Acknowledgements

- [Pandoc](https://pandoc.org/) – Document converter
- [wkhtmltopdf](https://wkhtmltopdf.org/) – HTML to PDF renderer
- [GitHub Actions](https://github.com/features/actions) – Automation platform

---

> **P.S.** This is a home lab for training CI/CD skills in GitHub Actions and the AI automated  coding. 
