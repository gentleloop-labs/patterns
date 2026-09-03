export type TrustItem = {
  title: string;
  description: string;
  href: string;
  linkLabel: string;
};

export const trustItems: TrustItem[] = [
  {
    title: 'Built from lived experience',
    description: 'Created by someone who lives with OCD and uses ERP tools in ordinary life.',
    href: '/about/aftaab-siddiqui',
    linkLabel: 'Meet the builder'
  },
  {
    title: 'Evidence, with sources',
    description: 'Educational claims are checked against reliable guidance and published research.',
    href: '/editorial-policy',
    linkLabel: 'Read the policy'
  },
  {
    title: 'Private and inspectable',
    description: 'Your OCD content stays on your device, and the app is open source.',
    href: '/privacy',
    linkLabel: 'See how privacy works'
  }
];

export type LoopStep = {
  id: 'obsession' | 'distress' | 'compulsion' | 'relief';
  label: string;
  note: string;
  detail: string;
  reinforcement: string;
  nextResponse: string;
};

export const loopSteps: LoopStep[] = [
  {
    id: 'obsession',
    label: 'Obsession',
    note: 'An intrusive thought latches on',
    detail: 'A thought, image, urge, sensation, or doubt arrives and feels unusually important.',
    reinforcement:
      'Trying to prove, suppress, or completely resolve it can teach the brain that it required an answer.',
    nextResponse:
      'Name the thought without deciding what it means, then notice what OCD asks you to do next.'
  },
  {
    id: 'distress',
    label: 'Distress',
    note: 'Anxiety makes it feel urgent',
    detail:
      'Discomfort rises, and urgency can make the feared possibility feel more likely than it is.',
    reinforcement:
      'Treating distress as a signal that you must act keeps attention locked on the threat.',
    nextResponse:
      'Let the discomfort be present for a moment without using the feeling itself as evidence.'
  },
  {
    id: 'compulsion',
    label: 'Compulsion',
    note: 'A ritual promises certainty or relief',
    detail:
      'Checking, reassurance, avoidance, confessing, washing, or mental review offers a way to feel safer.',
    reinforcement:
      'The ritual may reduce anxiety briefly, which makes the same response more tempting next time.',
    nextResponse:
      'When it is appropriate and safe, pause or delay the ritual instead of completing it automatically.'
  },
  {
    id: 'relief',
    label: 'Relief',
    note: 'It fades - briefly',
    detail:
      'The anxiety drops, but the certainty rarely lasts. A new doubt or urge eventually takes its place.',
    reinforcement:
      'Brief relief teaches the brain that the compulsion worked and that the next alarm deserves another ritual.',
    nextResponse:
      'Notice the short-lived relief, record the pattern if useful, and return attention to what matters now.'
  }
];

export type Testimonial = {
  quote: string;
  attribution: string;
};

export const testimonials: Testimonial[] = [
  {
    quote:
      'The layout is really nice and simple enough that I can actually see myself sticking with it.',
    attribution: 'Anonymous Patterns user'
  },
  {
    quote:
      "I'm excited to use Patterns to better understand my thoughts and notice recurring patterns.",
    attribution: 'Anonymous Patterns user'
  },
  {
    quote: 'Downloaded it and made my first entry. Really useful app.',
    attribution: 'Anonymous Patterns user'
  },
  {
    quote:
      "I really appreciate the care you've put into creating something that helps people support themselves.",
    attribution: 'Anonymous Patterns user'
  }
];

export const testimonialEditDisclosure = 'Excerpts lightly edited for length and clarity.';
export const testimonialOutcomeDisclosure =
  'Individual experiences are personal and are not evidence of a clinical outcome.';
