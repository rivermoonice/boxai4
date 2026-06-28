// Content collections for the Boxmining AI Academy site.
//
// Lessons live at the repo root under `lessons/<module>/L##-<slug>.md`,
// outside the Astro project's `src/`. We read them via a custom loader that
// resolves paths relative to the project root.
//
// Each lesson is a markdown file with this structure:
//
//     # Lesson Title
//
//     **Last tested and updated:** Month YYYY
//
//     ---
//
//     (body)
//
// The loader parses the title and the "Last tested" date, derives the module
// from the directory name, and derives the lesson number from the filename.
// Every field is type-checked against the Zod schema.

import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { readFile, readdir, stat } from 'node:fs/promises';
import { join, resolve, dirname, basename, relative } from 'node:path';
import { fileURLToPath } from 'node:url';

const PROJECT_ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..');
const LESSONS_DIR = join(PROJECT_ROOT, 'lessons');

const MODULES = ['hermes', 'ai-models', 'ai-projects'] as const;
type ModuleName = (typeof MODULES)[number];

const moduleMeta: Record<ModuleName, { title: string; description: string; order: number; accent: string }> = {
  hermes: {
    title: 'Hermes Agent',
    description: 'The open-source AI harness for research, automation, and multi-channel workflows.',
    order: 1,
    accent: '#7c5cff',
  },
  'ai-models': {
    title: 'AI Model Comparison',
    description: 'Tier lists, the Anthropic family, Chinese open-weight, cost-efficient picks, and a decision framework.',
    order: 2,
    accent: '#0ea5a4',
  },
  'ai-projects': {
    title: 'New AI Projects',
    description: 'Coding with Claude Code, vibe vs real coding, niche directories, and the AI-business stack.',
    order: 3,
    accent: '#ea7a3b',
  },
};

function parseLesson(md: string, filePath: string) {
  // Strip the "**Last tested..." line; we'll keep it as updatedDate but
  // remove it from the rendered body so we don't duplicate the date.
  const lines = md.split('\n');
  let title = '';
  let updatedRaw: string | null = null;
  let bodyStart = 0;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (!title && line.startsWith('# ')) {
      title = line.slice(2).trim();
      continue;
    }
    if (line.startsWith('**Last tested and updated:**')) {
      updatedRaw = line.replace('**Last tested and updated:**', '').trim();
      bodyStart = i + 1;
      // skip the following '---' separator if present
      if (lines[bodyStart] && lines[bodyStart].trim() === '---') {
        bodyStart += 1;
      }
      break;
    }
  }

  // body = the lesson content after the date separator
  const body = lines.slice(bodyStart).join('\n').trim();

  // Parse "Month YYYY" into a Date. Month name → number.
  let updatedDate: Date | null = null;
  if (updatedRaw) {
    const m = updatedRaw.match(/^([A-Za-z]+)\s+(\d{4})$/);
    if (m) {
      const monthName = m[1].toLowerCase();
      const year = Number(m[2]);
      const monthIdx = [
        'january', 'february', 'march', 'april', 'may', 'june',
        'july', 'august', 'september', 'october', 'november', 'december',
      ].indexOf(monthName);
      if (monthIdx >= 0) {
        updatedDate = new Date(Date.UTC(year, monthIdx, 1));
      }
    }
  }

  return { title, updatedDate, updatedRaw, body, filePath };
}

async function readAllLessons() {
  const all: any[] = [];
  for (const mod of MODULES) {
    const dir = join(LESSONS_DIR, mod);
    let entries: string[] = [];
    try {
      entries = await readdir(dir);
    } catch {
      continue;
    }
    for (const name of entries) {
      if (!name.endsWith('.md')) continue;
      if (name.startsWith('L00-')) continue; // skip the smoke test
      const filePath = join(dir, name);
      const st = await stat(filePath);
      if (!st.isFile()) continue;
      const raw = await readFile(filePath, 'utf8');
      const parsed = parseLesson(raw, filePath);

      // Derive lesson number from filename: L01-...md → 1
      const numMatch = name.match(/^L(\d+)-/);
      if (!numMatch) continue;
      const order = Number(numMatch[1]);

      // Slug from filename
      const slug = name.replace(/\.md$/, '').toLowerCase();

      // id = "module/slug"
      const id = `${mod}/${slug}`;

      // Derive a one-line summary from the first paragraph after the title
      // block. We look for the first H2 ("## 1. Introduction & Hook")
      // and take the sentence immediately before it.
      const bodyLines = parsed.body.split('\n');
      let summary = '';
      for (let i = 0; i < bodyLines.length; i++) {
        const l = bodyLines[i];
        if (l.startsWith('## 1.') || l.startsWith('## 2.') || l.startsWith('## 3.')) {
          // collect non-empty lines immediately before this heading
          const before: string[] = [];
          for (let j = i - 1; j >= 0; j--) {
            const bj = bodyLines[j].trim();
            if (!bj) continue;
            if (bj.startsWith('#')) break;
            before.unshift(bj);
          }
          // take the first sentence-ish chunk
          summary = before.join(' ').slice(0, 280);
          if (summary.length === 280) summary += '…';
          break;
        }
      }

      // Estimate reading time (~200 wpm) from the body
      const words = parsed.body
        .replace(/```[\s\S]*?```/g, '') // strip code blocks
        .replace(/[#*_>`-]/g, ' ')
        .split(/\s+/)
        .filter(Boolean).length;
      const readingMinutes = Math.max(1, Math.round(words / 200));

      all.push({
        id,
        module: mod,
        slug,
        order,
        title: parsed.title,
        summary,
        body: parsed.body,
        source: {
          repoPath: relative(PROJECT_ROOT, filePath),
          updatedRaw: parsed.updatedRaw,
        },
        updatedDate: parsed.updatedDate ?? new Date('2026-06-01'),
        readingMinutes,
        accent: moduleMeta[mod].accent,
      });
    }
  }
  return all;
}

const lessons = defineCollection({
  loader: async () => {
    return await readAllLessons();
  },
  schema: z.object({
    module: z.enum(MODULES),
    slug: z.string(),
    order: z.number().int().positive(),
    title: z.string(),
    summary: z.string(),
    body: z.string(),
    source: z.object({
      repoPath: z.string(),
      updatedRaw: z.string().nullable(),
    }),
    updatedDate: z.date(),
    readingMinutes: z.number(),
    accent: z.string(),
  }),
});

export const collections = { lessons };

export { MODULES, moduleMeta };
export type { ModuleName };