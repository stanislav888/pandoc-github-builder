# User Preferences

## No Emojis
Never use emojis in any generated content, code, documentation, or comments. Use plain text or appropriate symbols only when semantically necessary.

## Theme Control
- 3-button theme switcher: **Light**, **Dark**, **Yellow**
- Default theme: **Yellow** (via `DEFAULT_THEME` in `settings.env.txt`)
- Theme buttons use `data-theme-btn` attribute with values `light`, `dark`, `yellow`
- Theme selection persisted to `localStorage` under key `pandoc-theme`
- Theme switching uses `data-theme` attribute on `<html>` element, NOT `<body>`

## Sidebar
- Toggle button "Show TOC" / "Hide TOC" at top-right (leftmost in btn-group)
- **Desktop (> 768px)**: Sidebar fixed on the left, 250px wide, content has `margin-left: 290px`
- **Mobile (<= 768px)**: Sidebar stacks at top, full-width, content has no margin
- Sidebar collapse uses `transform: translateX(-250px)` — NOT `width: 0`
- Toggle state persisted to `localStorage` under key `sidebar-toggle`
- Initial sidebar state controlled by `SHOW_TOC` setting in `settings.env.txt` (default: `true`)

## JavaScript Rules
- `localStorage` calls always wrapped in `try-catch` for `file://` protocol compatibility
- All JS initialization uses `DOMContentLoaded` event — no inline `onclick` handlers

## Project Rules
- Working template: `pandoc-templates/rich.html`
- Do NOT modify `default.ms` or `default.opendocument` unless explicitly asked
- Do NOT create custom stylesheets until Bootstrap's common stylesheets cannot implement the feature
- Any exceptional Bootstrap changes should be implemented as a diff only to that case
- Always generate output documents aside of gitlab CI pipelines
- Always report example documents generated at the end of a task
