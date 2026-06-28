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
// from the directory name, derives the lesson number from the filename, and
// uses Astro's `renderMarkdown()` to compile the body to HTML using the same
// Shiki pipeline as MDX pages.

import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { readFile, readdir, stat } from 'node:fs/promises';
import { join, resolve, dirname, relative } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

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

function parseLesson(md: string) {
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
      // Skip blank lines and the horizontal rule separator that follows
      while (bodyStart < lines.length) {
        const next = lines[bodyStart].trim();
        if (next === '' || next === '---') {
          bodyStart += 1;
          continue;
        }
        break;
      }
      break;
    }
  }

  const body = lines.slice(bodyStart).join('\n').trim();

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

  return { title, updatedDate, updatedRaw, body };
}

function deriveSummary(body: string): string {
  const lines = body.split('\n');
  for (let i = 0; i < lines.length; i++) {
    const l = lines[i];
    if (l.startsWith('## 1.') || l.startsWith('## 2.') || l.startsWith('## 3.')) {
      const before: string[] = [];
      for (let j = i - 1; j >= 0; j--) {
        const bj = lines[j].trim();
        if (!bj) continue;
        if (bj.startsWith('#')) break;
        before.unshift(bj);
      }
      let summary = before.join(' ').slice(0, 280);
      if (summary.length === 280) summary += '…';
      return summary;
    }
  }
  return '';
}

function deriveDescription(body: string, fallback: string): string {
  const lines = body.split('\n');
  for (const raw of lines) {
    const line = raw.trim();
    if (line.length < 50) continue;
    if (line.startsWith('#') || line.startsWith('>') || line.startsWith('-') ||
        line.startsWith('|') || line.startsWith('*') || line.startsWith('```')) continue;
    let desc = line
      .replace(/\*\*([^*]+)\*\*/g, '$1')
      .replace(/`([^`]+)`/g, '$1')
      .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1');
    if (desc.length > 200) desc = desc.slice(0, 197).trim() + '…';
    return desc;
  }
  return fallback;
}

function estimateReadingMinutes(body: string): number {
  const words = body
    .replace(/```[\s\S]*?```/g, '')
    .replace(/[#*_>`-]/g, ' ')
    .split(/\s+/)
    .filter(Boolean).length;
  return Math.max(1, Math.round(words / 200));
}

const lessons = defineCollection({
  loader: {
    name: 'lessons-fs',
    load: async ({ store, renderMarkdown }) => {
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
          if (name.startsWith('L00-')) continue;

          const filePath = join(dir, name);
          const st = await stat(filePath);
          if (!st.isFile()) continue;

          const raw = await readFile(filePath, 'utf8');
          const parsed = parseLesson(raw);

          const numMatch = name.match(/^L(\d+)-/);
          if (!numMatch) continue;
          const order = Number(numMatch[1]);
          const slug = name.replace(/\.md$/, '').toLowerCase();
          const id = `${mod}/${slug}`;

          // Render the body through Astro's markdown pipeline. This gives us
          // Shiki highlighting and the same component treatment as MDX files.
          const rendered = await renderMarkdown(parsed.body, {
            fileURL: pathToFileURL(filePath),
          });
          const bodyHtml = (rendered as { html?: string }).html ?? String(rendered);

          const summary = deriveSummary(parsed.body);
          const description = deriveDescription(parsed.body, parsed.title);

          store.set({
            id,
            data: {
              module: mod,
              slug,
              order,
              title: parsed.title,
              summary,
              bodyHtml: String(bodyHtml),
              body: parsed.body,
              description,
              source: {
                repoPath: relative(PROJECT_ROOT, filePath),
                updatedRaw: parsed.updatedRaw,
              },
              updatedDate: parsed.updatedDate ?? new Date('2026-06-01'),
              readingMinutes: estimateReadingMinutes(parsed.body),
              accent: moduleMeta[mod].accent,
            },
          });
        }
      }
    },
  },
  schema: z.object({
    module: z.enum(MODULES),
    slug: z.string(),
    order: z.number().int().positive(),
    title: z.string(),
    summary: z.string(),
    bodyHtml: z.string(),
    body: z.string(),
    description: z.string(),
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