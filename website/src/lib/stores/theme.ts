import { browser } from '$app/environment';
import { writable } from 'svelte/store';

export type Theme = 'dark' | 'light';

const STORAGE_KEY = 'patterns-theme';

function getInitialTheme(): Theme {
  if (!browser) return 'dark';
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored === 'light' || stored === 'dark') return stored;
  } catch {
    // Storage can be blocked; fall through to the system setting.
  }
  // No explicit choice yet: follow the visitor's system setting.
  return window.matchMedia?.('(prefers-color-scheme: light)').matches ? 'light' : 'dark';
}

function createThemeStore() {
  const { subscribe, set, update } = writable<Theme>(getInitialTheme());

  return {
    subscribe,
    toggle: () => {
      const apply = () =>
        update((current) => {
          const next = current === 'dark' ? 'light' : 'dark';
          if (browser) {
            try {
              localStorage.setItem(STORAGE_KEY, next);
            } catch {
              // Storage can be blocked; the switch still applies to this page.
            }
            document.documentElement.dataset.theme = next;
          }
          return next;
        });

      // Cross-fade the whole page between themes where supported, instead of
      // every colour snapping at once.
      const root = browser ? document.documentElement : null;
      const reduce = browser && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      if (!root || reduce || !document.startViewTransition) {
        apply();
        return;
      }
      root.classList.add('theme-transition');
      const transition = document.startViewTransition(apply);
      transition.finished.finally(() => root.classList.remove('theme-transition'));
    },
    init: () => {
      if (!browser) return;
      const theme = getInitialTheme();
      document.documentElement.dataset.theme = theme;
      set(theme);
    }
  };
}

export const theme = createThemeStore();
