# Mobile App (Expo + React Native)

## Run the app

- Web (quick preview):
  - `npm install`
  - `npm run web`
  - Open the URL printed by Expo in your browser

- Android emulator:
  - Ensure Android Studio + emulator installed and running
  - `npm run android`

- iOS (Mac required):
  - Use an iPhone simulator via Xcode, or install the Expo Go app on your device
  - `npm run ios`

- Physical device (Expo Go):
  - Install Expo Go on your phone
  - Run `npm start` and scan the QR code with the Expo Go app

## Tech stack
- Expo Router
- React Native 0.79 + React 19
- @tanstack/react-query for server state
- Zustand for local state
- Expo Haptics

## Project structure
- `app/` — routes and screens (Expo Router)
- `components/` — shared UI components
- `store/` — Zustand store

## Notes
- Trending tab demonstrates infinite scroll with React Query.
- Dark mode follows system by default; customize in `components/Themed.tsx`.