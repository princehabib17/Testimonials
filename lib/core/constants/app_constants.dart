import 'package:flutter/material.dart';

class AppColors {
  // 2025 UI Palette
  static const Color darkBase = Color(0xFF0C0C0E);
  static const Color neonCyan = Color(0xFF00F0FF);
  static const Color accentMagenta = Color(0xFFFF006E);
  static const Color warmWhite = Color(0xFFF5F5F5);
  
  // Additional colors
  static const Color darkSurface = Color(0xFF1A1A1C);
  static const Color darkCard = Color(0xFF2A2A2C);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonOrange = Color(0xFFFF6B35);
  static const Color neonPurple = Color(0xFF8B5CF6);
  
  // Gradients
  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonCyan, neonGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient magentaGradient = LinearGradient(
    colors: [accentMagenta, neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppDimensions {
  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Border radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  
  // Glassmorphism
  static const double blurRadius = 16.0;
  static const double glassOpacity = 0.15;
  
  // Icons
  static const double iconSize = 24.0;
  static const double iconStroke = 2.0;
}

class AppAnimations {
  // Motion specs
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  // Curves
  static const Curve easeOutQuad = Curves.easeOutQuad;
  static const Curve spring = Curves.elasticOut;
}

class AppText {
  // Font families
  static const String sfProDisplay = 'SF Pro Display';
  static const String robotoFlex = 'Roboto Flex';
  
  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class AppStrings {
  // App name
  static const String appName = 'MotoRihla';
  static const String appNameAr = 'موتو رحلة';
  
  // Common
  static const String loading = 'Loading...';
  static const String loadingAr = 'جاري التحميل...';
  static const String error = 'Error';
  static const String errorAr = 'خطأ';
  static const String success = 'Success';
  static const String successAr = 'نجح';
  static const String cancel = 'Cancel';
  static const String cancelAr = 'إلغاء';
  static const String confirm = 'Confirm';
  static const String confirmAr = 'تأكيد';
  static const String retry = 'Retry';
  static const String retryAr = 'إعادة المحاولة';
}

class AppRoutes {
  // Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  
  // Passenger
  static const String passengerHome = '/passenger/home';
  static const String rideStatus = '/passenger/ride-status';
  static const String tripHistory = '/passenger/trip-history';
  static const String wallet = '/passenger/wallet';
  static const String profile = '/passenger/profile';
  
  // Rider
  static const String riderHome = '/rider/home';
  static const String incomingRequests = '/rider/incoming-requests';
  static const String activeRide = '/rider/active-ride';
  static const String earnings = '/rider/earnings';
  static const String riderProfile = '/rider/profile';
}

class AppConfig {
  // API
  static const String baseUrl = 'https://api.motorihla.com';
  static const String socketUrl = 'wss://socket.motorihla.com';
  
  // Maps
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  
  // Payments
  static const String hyperpayUrl = 'https://payments.hyperpay.com';
  
  // Cities
  static const List<String> supportedCities = [
    'Riyadh',
    'Jeddah', 
    'Dammam',
  ];
  
  // Gender preferences
  static const List<String> genderPreferences = [
    'Any',
    'Male',
    'Female',
  ];
  
  // Payment methods
  static const List<String> paymentMethods = [
    'Apple Pay',
    'Mada',
    'Credit/Debit',
    'Cash',
  ];
}