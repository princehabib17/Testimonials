# MotoRihla - Saudi Motorcycle-Hailing App

A modern, bilingual motorcycle ride-hailing platform built with Flutter, featuring a 2025 UI aesthetic with glassmorphism effects and neon accents.

## 🚀 Features

### Core Functionality
- **Real-time Ride Booking**: Request motorcycle rides with live tracking
- **Bilingual Support**: Full Arabic (RTL) and English (LTR) support
- **Gender Preference**: Choose Any/Male/Female riders
- **Multiple Payment Methods**: Apple Pay, Mada, Credit/Debit, Cash
- **Live Map Integration**: Google Maps with custom dark theme
- **Fare Estimation**: Real-time price calculation
- **Ride Status Tracking**: Real-time updates on ride progress

### 2025 UI Design
- **Glassmorphism Effects**: Blur backgrounds with neon borders
- **Neon Color Palette**: Cyan, Magenta, Green accents
- **Dark Theme**: Ultra-modern dark interface
- **Smooth Animations**: 180ms easeOutQuad transitions
- **Responsive Design**: Optimized for mobile and tablet

### Technical Features
- **Cross-platform**: iOS 14+ / Android 10+
- **State Management**: Riverpod for reactive state
- **Authentication**: Firebase Auth with phone verification
- **Real-time Communication**: Socket.IO integration
- **Location Services**: GPS tracking and geocoding
- **Payment Integration**: HyperPay support

## 📱 Screenshots

### Passenger App
- **Home Screen**: Map with destination input and booking interface
- **Ride Status**: Real-time tracking with driver information
- **Trip History**: Past rides with ratings and reviews
- **Wallet**: Balance management and transaction history
- **Profile**: User settings and preferences

### Rider App
- **Online/Offline Toggle**: One-tap status switching
- **Incoming Requests**: Accept/decline ride requests
- **Active Ride**: Navigation and ride management
- **Earnings**: Daily/weekly/monthly income tracking
- **Profile**: KYC documents and vehicle information

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **UI Components**: Custom glassmorphic widgets
- **Maps**: Google Maps Flutter
- **Animations**: Flutter Animate

### Backend (Planned)
- **Runtime**: Node.js + NestJS
- **Database**: PostgreSQL
- **Cache**: Redis
- **Real-time**: Socket.IO
- **Payments**: HyperPay integration

### Services
- **Authentication**: Firebase Auth
- **Push Notifications**: Firebase Cloud Messaging
- **Maps & Geocoding**: Google Maps API
- **Payments**: HyperPay (Mada, Apple Pay support)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10.0+
- Dart SDK 3.0.0+
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/moto-rihla.git
   cd moto-rihla
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project
   - Add Android/iOS apps
   - Download `google-services.json` and `GoogleService-Info.plist`
   - Place in `android/app/` and `ios/Runner/` respectively

4. **Configure Google Maps**
   - Get Google Maps API key
   - Update `lib/core/constants/app_constants.dart`
   - Add key to `android/app/src/main/AndroidManifest.xml`

5. **Run the app**
   ```bash
   flutter run
   ```

### Environment Setup

Create `.env` file in the root directory:
```env
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
FIREBASE_PROJECT_ID=your_firebase_project_id
HYPERPAY_URL=https://payments.hyperpay.com
API_BASE_URL=https://api.motorihla.com
SOCKET_URL=wss://socket.motorihla.com
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # App constants and config
│   ├── models/            # Data models
│   ├── providers/         # State management
│   ├── services/          # Business logic
│   └── theme/             # UI theme and styling
├── features/
│   ├── auth/              # Authentication screens
│   ├── passenger/         # Passenger app features
│   ├── rider/             # Rider app features
│   └── shared/            # Shared components
└── main.dart              # App entry point
```

## 🎨 Design System

### Color Palette
- **Dark Base**: `#0C0C0E`
- **Neon Cyan**: `#00F0FF`
- **Accent Magenta**: `#FF006E`
- **Warm White**: `#F5F5F5`
- **Neon Green**: `#00FF88`
- **Neon Orange**: `#FF6B35`

### Typography
- **Primary**: SF Pro Display (iOS), Roboto Flex (Android)
- **Weights**: 400 (Regular), 500 (Medium), 600 (Semibold), 700 (Bold)

### Spacing
- **XS**: 4px, **SM**: 8px, **MD**: 16px, **LG**: 24px, **XL**: 32px, **XXL**: 48px

### Animations
- **Duration**: 150ms (fast), 300ms (normal), 500ms (slow)
- **Curves**: easeOutQuad, elasticOut

## 🔧 Configuration

### Supported Cities
- Riyadh
- Jeddah
- Dammam

### Payment Methods
- Apple Pay
- Mada
- Credit/Debit Cards
- Cash

### Gender Preferences
- Any Rider
- Male Rider
- Female Rider

## 📊 Performance Metrics

### Target KPIs
- **Trip Acceptance**: ≥92%
- **Avg. Pickup Time**: ≤5 min
- **App Crash Rate**: <0.2%
- **App Store Rating**: ≥4.6
- **Rider Retention**: ≥60% monthly active

### Performance Goals
- **TTI**: <3s on mid-range Android (4G)
- **Image Size**: ≤100kB (PNG/WebP)
- **Accessibility**: WCAG 2.2 AA compliance

## 🔒 Security & Compliance

### Data Protection
- PCI DSS compliance via HyperPay
- GDPR-style data export/delete
- Encrypted data transmission
- Secure API authentication

### Safety Features
- SOS button with live GPS sharing
- 24/7 support line integration
- Real-time incident reporting
- Driver KYC verification

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### E2E Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 📦 Build & Deploy

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### CI/CD
- GitHub Actions for automated testing
- Staging deployment on every push
- Production deployment via manual approval

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [Wiki](https://github.com/your-username/moto-rihla/wiki)
- **Issues**: [GitHub Issues](https://github.com/your-username/moto-rihla/issues)
- **Email**: support@motorihla.com

## 🗺️ Roadmap

### Phase 1 (Current)
- [x] Core Flutter app structure
- [x] Authentication system
- [x] Passenger booking flow
- [x] 2025 UI implementation
- [x] Bilingual support

### Phase 2 (Next)
- [ ] Rider app development
- [ ] Real-time communication
- [ ] Payment integration
- [ ] Admin dashboard

### Phase 3 (Future)
- [ ] Advanced analytics
- [ ] AI-powered features
- [ ] Multi-city expansion
- [ ] Enterprise solutions

---

**Built with ❤️ for Saudi Arabia's motorcycle community**