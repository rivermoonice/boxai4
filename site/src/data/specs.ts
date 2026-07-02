// Spec pages index — kept in a separate module so Astro can resolve it
// from the static-paths chunk at build time.

export const SPEC_PAGES: Record<string, { file: string; title: string; description: string }> = {
  'brand-spec': {
    file: 'brand-specification.md',
    title: 'Brand specification',
    description: 'The visual identity, UX principles, color system, and redesign acceptance criteria for the academy.',
  },
  'lesson-spec': {
    file: 'ai-academy-lesson-specification.md',
    title: 'Lesson specification',
    description: 'The 12-section spec every Boxmining AI Academy lesson must satisfy.',
  },
  'channel-identity': {
    file: 'ChannelIdentity.md',
    title: 'Channel identity',
    description: 'Voice, register, beliefs, recurring themes, and recurring framings from the BoxminingAI channel.',
  },
};

export const SPEC_SLUGS = Object.keys(SPEC_PAGES);
