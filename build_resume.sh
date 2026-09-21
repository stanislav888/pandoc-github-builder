#!/usr/bin/env bash
set -uo pipefail

OUTPUT_FOLDER="${1:-/tmp/pandoc_builder}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_FILE="${SCRIPT_DIR}/settings.env.txt"

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "ERROR: settings.env.txt not found at $SETTINGS_FILE"
    exit 1
fi

while IFS='=' read -r key value; do
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | tr -d '"' | xargs)
case "$key" in
        FILE_BASENAME) FILE_BASENAME="$value" ;;
        INPUT_FILE) INPUT_FILE="$value" ;;
        HTML_TEMPLATE_FILE) HTML_TEMPLATE_FILE="$value" ;;
        RICH_TEMPLATE_FILE) RICH_TEMPLATE_FILE="$value" ;;
        ODT_TEMPLATE_FILE) ODT_TEMPLATE_FILE="$value" ;;
        DOCX_TEMPLATE_FILE) DOCX_TEMPLATE_FILE="$value" ;;
    esac
done < "$SETTINGS_FILE"

INPUT_FILE="${INPUT_FILE:-./resume.md}"
FILE_BASENAME="${FILE_BASENAME:-resume}"
HTML_TEMPLATE_FILE="${HTML_TEMPLATE_FILE:-${SCRIPT_DIR}/pandoc-templates/simple.html}"
RICH_TEMPLATE_FILE="${RICH_TEMPLATE_FILE:-${SCRIPT_DIR}/pandoc-templates/rich.html}"
ODT_TEMPLATE_FILE="${ODT_TEMPLATE_FILE:-./pandoc-templates/default.opendocument}"
DOCX_TEMPLATE_FILE="${DOCX_TEMPLATE_FILE:-./pandoc-templates/default.ms}"
INPUT_FORMAT="markdown"

mkdir -p "$OUTPUT_FOLDER"

echo "=========================================="
echo "  Pandoc Resume Builder"
echo "=========================================="
echo "Output folder:  $OUTPUT_FOLDER"
echo "Input file:     $INPUT_FILE"
echo "Basename:       $FILE_BASENAME"
echo "=========================================="

HAS_PANDOC=false
HAS_WKHTML=false
command -v pandoc >/dev/null 2>&1 && HAS_PANDOC=true
command -v wkhtmltopdf >/dev/null 2>&1 && HAS_WKHTML=true

if [ "$HAS_PANDOC" = false ]; then
    echo ""
    echo "ERROR: pandoc is not installed. Cannot proceed."
    echo "Install pandoc to generate documents."
    echo ""
    exit 1
fi

if [ "$HAS_WKHTML" = false ]; then
    echo ""
    echo "WARNING: wkhtmltopdf not found. PDF generation will be skipped."
    echo "Install wkhtmltopdf to enable PDF output."
    echo ""
fi

PDF_OUTPUT="${OUTPUT_FOLDER}/${FILE_BASENAME}.pdf"
HTML_SIMPLE="${OUTPUT_FOLDER}/${FILE_BASENAME}_simple.html"
HTML_RICH="${OUTPUT_FOLDER}/${FILE_BASENAME}_rich.html"
ODT_OUTPUT="${OUTPUT_FOLDER}/${FILE_BASENAME}.odt"
DOCX_OUTPUT="${OUTPUT_FOLDER}/${FILE_BASENAME}.docx"
PREVIEW_HTML="/tmp/resume_rich.html"

echo ""
echo "--- Generating HTML (simple) ---"
pandoc "$INPUT_FILE" \
    -s \
    --toc \
    --toc-depth=3 \
    --template="$HTML_TEMPLATE_FILE" \
    --metadata title="$FILE_BASENAME" \
    --embed-resources \
    -o "$HTML_SIMPLE" \
    -f "$INPUT_FORMAT"
echo "  -> $HTML_SIMPLE"

echo ""
echo "--- Generating HTML (rich) ---"
pandoc "$INPUT_FILE" \
    -s \
    --toc \
    --toc-depth=3 \
    --template="$RICH_TEMPLATE_FILE" \
    --metadata title="$FILE_BASENAME" \
    --embed-resources \
    -o "$HTML_RICH" \
    -f "$INPUT_FORMAT"
cp "$HTML_RICH" "$PREVIEW_HTML"
echo "  -> $HTML_RICH"
echo "  -> $PREVIEW_HTML (preview)"

if [ "$HAS_WKHTML" = true ]; then
    echo ""
    echo "--- Generating PDF ---"
    pandoc "$INPUT_FILE" \
        -t html \
        --pdf-engine=wkhtmltopdf \
        --template="$HTML_TEMPLATE_FILE" \
        --metadata title="$FILE_BASENAME" \
        --embed-resources \
        -o "$PDF_OUTPUT" \
        -f "$INPUT_FORMAT"
    echo "  -> $PDF_OUTPUT"
else
    echo ""
    echo "--- PDF generation SKIPPED (wkhtmltopdf not available) ---"
fi

echo ""
echo "--- Generating ODT ---"
pandoc "$INPUT_FILE" \
    -t odt \
    --template="$ODT_TEMPLATE_FILE" \
    -o "$ODT_OUTPUT" \
    -f "$INPUT_FORMAT"
echo "  -> $ODT_OUTPUT"

echo ""
echo "--- Generating DOCX ---"
pandoc "$INPUT_FILE" \
    --template="$DOCX_TEMPLATE_FILE" \
    -o "$DOCX_OUTPUT" \
    -f "$INPUT_FORMAT"
echo "  -> $DOCX_OUTPUT"

echo ""
echo "=========================================="
echo "  Build complete!"
echo "=========================================="
echo "  HTML Simple: $HTML_SIMPLE"
echo "  HTML Rich:   $HTML_RICH"
echo "  ODT:         $ODT_OUTPUT"
echo "  DOCX:        $DOCX_OUTPUT"
[ "$HAS_WKHTML" = true ] && echo "  PDF:         $PDF_OUTPUT" || echo "  PDF:         (skipped - wkhtmltopdf not available)"
echo "  Preview:     $PREVIEW_HTML"
echo "=========================================="
