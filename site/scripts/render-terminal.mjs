#!/usr/bin/env node
/**
 * render-terminal.mjs — turn raw Hermes CLI captures into styled PNG screenshots.
 *
 * Pipeline:
 *   1. Read each <name>.raw file produced by capture-hermes.sh.
 *   2. Strip ANSI escape codes (we render in a single color, so escapes
 *      would only clutter the image).
 *   3. Build an SVG wrapper: macOS-style chrome on top (three traffic-light
 *      dots + centered title bar), monospace <foreignObject> body on a dark
 *      background.
 *   4. sharp rasterizes SVG → PNG at 2x DPR.
 *   5. Write to the destination dir.
 *
 * Usage:
 *   node site/scripts/render-terminal.mjs <input-dir> <output-dir>
 *
 * Defaults:
 *   input:  /tmp/hermes-captures
 *   output: site/public/lessons/hermes/L01
 */

import { readdir, readFile, mkdir } from 'node:fs/promises';
import { join, basename, extname } from 'node:path';
import sharp from 'sharp';

const TITLE_OVERRIDES = {
  'hermes-help': 'hermes --help',
  'hermes-version': 'hermes --version',
  'hermes-status': 'hermes status',
  'hermes-doctor': 'hermes doctor',
  'hermes-skills': 'hermes skills list',
};

// Per-capture line budgets. L01 is an intro lesson — these have to be
// glanceable. Show what's useful, not everything Hermes can print.
// Each entry is { maxLines, skipTop?, skipBottom?, takeFromEnd? }.
const TRUNCATIONS = {
  'hermes-help': { maxLines: 28 }, // synopsis + first ~24 subcommands
  'hermes-version': { maxLines: 5 },
  'hermes-status': { maxLines: 26, skipTop: 1 }, // drop blank line 1, keep banner + Environment + API Keys
  'hermes-doctor': { maxLines: 22 }, // banner + security/python/ssl summary
  'hermes-skills': { maxLines: 28 }, // header + 25 skill rows
};

const INPUT = process.argv[2] || '/tmp/hermes-captures';
// Default destination is src/assets/ so the PNGs flow through Astro's
// image optimization pipeline (<Image> from astro:assets). Override with a
// 2nd CLI arg if you want plain public/ output.
const OUTPUT = process.argv[3] || join(process.cwd(), 'src/assets/lessons');

const FONT_SIZE = 14;
const CHROME_HEIGHT = 36;
const PAD_X = 16;
const PAD_Y = 16;
const FONT_FAMILY = '"SF Mono", "JetBrains Mono", ui-monospace, Menlo, Consolas, monospace';

function stripAnsi(s) {
  // Drop CSI escape sequences (color, cursor, etc.) plus carriage returns.
  return s
    .replace(/\x1b\[[0-9;?]*[A-Za-z]/g, '')
    .replace(/\x1b\][^\x07]*\x07/g, '')
    .replace(/\r(?!\n)/g, '');
}

function escapeXml(s) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function splitLines(text) {
  // Preserve empty lines; trim trailing newline only.
  if (text.endsWith('\n')) text = text.slice(0, -1);
  return text.split('\n');
}

function longestLine(lines) {
  let max = 0;
  for (const l of lines) if (l.length > max) max = l.length;
  return max;
}

function buildSvg({ title, lines, width, bodyHeight }) {
  const safeLines = lines.map(escapeXml);
  const lineHeight = Math.round(FONT_SIZE * 1.45);
  const totalHeight = CHROME_HEIGHT + bodyHeight;

  // Build per-line <text> elements. Note FONT_FAMILY contains double quotes
  // — must use single quotes for the attribute delimiter.
  const tspan = (i, content) =>
    `<text x='${PAD_X}' y='${CHROME_HEIGHT + PAD_Y + FONT_SIZE + i * lineHeight}' font-family='${FONT_FAMILY}' font-size='${FONT_SIZE}' fill='#c9d1d9'>${content}</text>`;
  const tspans = safeLines.map((l, i) => tspan(i, l || ' ')).join('\n  ');

  return `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${totalHeight}" viewBox="0 0 ${width} ${totalHeight}">
  <rect width="${width}" height="${totalHeight}" fill="#0d1117"/>
  <rect x="0" y="0" width="${width}" height="${CHROME_HEIGHT}" fill="#161b22"/>
  <line x1="0" y1="${CHROME_HEIGHT - 0.5}" x2="${width}" y2="${CHROME_HEIGHT - 0.5}" stroke="#30363d" stroke-width="1"/>
  <circle cx="18" cy="${CHROME_HEIGHT / 2}" r="6" fill="#ff5f57"/>
  <circle cx="38" cy="${CHROME_HEIGHT / 2}" r="6" fill="#febc2e"/>
  <circle cx="58" cy="${CHROME_HEIGHT / 2}" r="6" fill="#28c840"/>
  <text x="${width / 2}" y="${CHROME_HEIGHT / 2 + 4}" text-anchor="middle" font-family='${FONT_FAMILY}' font-size="12" fill="#8b949e">${escapeXml(title)}</text>
  ${tspans}
</svg>`;
}

async function renderOne(name, raw) {
  const text = stripAnsi(raw);
  let lines = splitLines(text);

  // Apply per-capture truncation. Truncations are tuned for L01 brevity.
  const trunc = TRUNCATIONS[name];
  if (trunc) {
    if (trunc.skipTop) lines = lines.slice(trunc.skipTop);
    if (trunc.maxLines && lines.length > trunc.maxLines) {
      lines = lines.slice(0, trunc.maxLines);
      // Add a faint "…" indicator line so readers know it's clipped.
      lines.push('…  (output continues — see L02 for the full install walkthrough)');
    }
  }

  // Measure width with a fixed assumption: ~8.4px per monospace char at 14px.
  // Add some slack for safety.
  const CHAR_W = 8.4;
  const longest = longestLine(lines);
  const bodyWidth = Math.min(1600, Math.max(640, longest * CHAR_W + PAD_X * 2));
  const lineHeight = Math.round(FONT_SIZE * 1.45);
  const bodyHeight = lines.length * lineHeight + PAD_Y * 2;

  const title = TITLE_OVERRIDES[name] || name;
  const svg = buildSvg({ title, lines, width: Math.round(bodyWidth), bodyHeight });

  const outPath = join(OUTPUT, `${name}.png`);
  await sharp(Buffer.from(svg))
    .png({ compressionLevel: 9 })
    .toFile(outPath);

  return { name, lines: lines.length, width: Math.round(bodyWidth), height: CHROME_HEIGHT + bodyHeight, outPath };
}

async function main() {
  await mkdir(OUTPUT, { recursive: true });
  const entries = await readdir(INPUT);
  const raws = entries.filter((f) => f.endsWith('.raw'));

  console.log(`Rendering ${raws.length} captures from ${INPUT} → ${OUTPUT}`);
  for (const f of raws) {
    const name = basename(f, extname(f));
    const raw = await readFile(join(INPUT, f), 'utf8');
    try {
      const meta = await renderOne(name, raw);
      console.log(`  ✓ ${name}.png  (${meta.lines} lines, ${meta.width}×${meta.height})`);
    } catch (e) {
      console.error(`  ✗ ${name}: ${e.message}`);
      throw e;
    }
  }
  console.log('Done.');
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});