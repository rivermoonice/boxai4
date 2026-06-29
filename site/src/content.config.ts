// Content collections for the Boxmining AI Academy site.
//
// Lessons live at `site/src/content/lessons/<module>/L##-<slug>.{md,mdx}`.
// The collection uses Astro's `glob` loader, so MDX lessons (with inline
// components like <Quiz> and <TerminalScreenshot>) and plain markdown lessons
// (rendered to HTML) flow through the same route and the same render() call.
//
// Each lesson is a file with this structure:
//
//     ---
//     title: "..."
//     module: hermes
//     slug: l01-what-is-hermes-agent
//     order: 1
//     updatedDate: 2026-06-01
//     updatedRaw: "June 2026"
//     summary: "..."
//     description: "..."
//     readingMinutes: 12
//     accent: "#7c5cff"
//     ---
//
//     # Lesson Title
//
//     (body)
//
// `module`, `slug`, `order`, `accent` are derived in the migration script
// that produced these files. `updatedDate` and `updatedRaw` are taken from
// the "Last tested and updated" line in the body (which is still present for
// backwards-compatibility reads).

import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

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

const lessons = defineCollection({
  loader: glob({
  pattern: ['**/*.{md,mdx}', '!**/_skeletons/**'],
  base: './src/content/lessons',
}),
  schema: z.object({
    title: z.string(),
    summary: z.string().default(''),
    description: z.string().default(''),
    module: z.enum(MODULES),
    slug: z.string(),
    order: z.number().int().nonnegative(),
    updatedDate: z.date(),
    updatedRaw: z.string().nullable().default(null),
    readingMinutes: z.number().default(1),
    accent: z.string(),
  }),
});

export const collections = { lessons };

export { MODULES, moduleMeta };
export type { ModuleName };
