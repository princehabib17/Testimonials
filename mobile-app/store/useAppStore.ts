import { create } from 'zustand';

export type AppThemePreference = 'system' | 'light' | 'dark';

interface AppState {
  hasSeenOnboarding: boolean;
  themePreference: AppThemePreference;
  setHasSeenOnboarding: (seen: boolean) => void;
  setThemePreference: (pref: AppThemePreference) => void;
}

export const useAppStore = create<AppState>((set) => ({
  hasSeenOnboarding: false,
  themePreference: 'system',
  setHasSeenOnboarding: (seen) => set({ hasSeenOnboarding: seen }),
  setThemePreference: (pref) => set({ themePreference: pref }),
}));