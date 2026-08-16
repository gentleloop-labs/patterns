export type FaqItem = {
  question: string;
  /** Plain-text answer used for FAQPage JSON-LD (no markup). */
  answer: string;
};

export const faqs: FaqItem[] = [
  {
    question: 'Is Patterns a replacement for therapy?',
    answer:
      'No. Patterns is a self-reflection and tracking tool that supports your own journaling and ERP practice. It does not diagnose, treat, or cure OCD, and it is not a substitute for care from a qualified clinician. The most effective treatment for OCD is Exposure and Response Prevention (ERP), ideally guided by an OCD-trained therapist.'
  },
  {
    question: 'What is OCD?',
    answer:
      'OCD (obsessive-compulsive disorder) is a loop between obsessions - unwanted, intrusive thoughts, images, or urges that cause distress - and compulsions, the repeated actions or mental rituals people do to relieve that distress. The relief is brief, which reinforces the cycle and makes the urge return stronger.'
  },
  {
    question: 'What is ERP?',
    answer:
      'ERP stands for Exposure and Response Prevention. It involves gradually facing the thoughts and situations that trigger obsessions (exposure) while choosing not to perform the usual compulsion (response prevention). Over time this teaches the brain that anxiety fades on its own, without the ritual.'
  },
  {
    question: 'How does the Compulsion Delay Tool work?',
    answer:
      'When you feel an urge, you start a delay instead of acting on it immediately. Patterns helps you wait out the wave for a set period and record how it went. Delaying a compulsion is a form of response prevention - it gives the urge time to peak and fall and shows you that the discomfort is tolerable.'
  },
  {
    question: 'What is the 0–10 distress scale?',
    answer:
      'Patterns lets you rate how distressed you feel from 0 to 10. Clinicians call this SUDS (Subjective Units of Distress). Tracking it over time lets you see anxiety actually rise and fall, which is central to ERP and makes your progress visible.'
  },
  {
    question: 'Is my data private?',
    answer:
      'Yes. Everything you record stays on your device. Patterns has no accounts, no cloud sync, and no remote analytics or advertising trackers. A small set of product-usage counters remains on-device and is never uploaded. Your entries are never sold, shared, or uploaded. The app is open source, so anyone can verify this.'
  },
  {
    question: 'Which platforms is Patterns available on?',
    answer:
      'Patterns is a mobile app available for iPhone and Android. You can download it from the App Store or Google Play.'
  },
  {
    question: 'How much does Patterns cost?',
    answer:
      'Patterns is free to download, and the journal, the OCD log, the Y-BOCS self-check, guided ERP, the compulsion delay tool, and the emergency toolkit are all free with no time limit. Patterns Pro is an optional one-time unlock for the deeper ERP tools: exposure ladders, exposure materials, urge surfing, response prevention, structured programs, and the extra insights. Pro is $39.99 in the US on iPhone and Android, with local pricing elsewhere. It is one payment, never a subscription and nothing to renew. If you already own Pro, nothing changes and you are never charged again. Patterns is open source, and optional tips and GitHub Sponsors are there if you would like to contribute beyond that.'
  },
  {
    question: 'Can I back up or move my data?',
    answer:
      'Yes. You can manually export all of your entries to a JSON backup file and import it again later or on another device. Importing replaces the current local journal and OCD entries in the app.'
  },
  {
    question: 'Can I lock the app?',
    answer:
      'Yes. On mobile you can enable an optional app lock that uses Face ID, Touch ID, or your device passcode, so your reflections stay private even if someone else has your phone.'
  },
  {
    question: 'Does Patterns work offline?',
    answer:
      'Completely. Patterns is local-first and needs no internet connection to journal, track, or review your patterns. Your journal entries and OCD records are not sent to a server.'
  },
  {
    question: 'I think I might have OCD. What should I do?',
    answer:
      'Only a qualified mental-health professional can assess and diagnose OCD. If intrusive thoughts and compulsions are affecting your life, consider reaching out to a clinician or an OCD specialist. Reaching out for help is a sign of strength. Patterns can help you track what you are experiencing so you can share clear notes with them.'
  }
];
