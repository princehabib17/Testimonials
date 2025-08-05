import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/localization_service.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../models/user_model.dart';
import '../models/ride_model.dart';

// Locale Provider
final localeProviderProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar', 'SA')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'ar';
    final countryCode = prefs.getString('country_code') ?? 'SA';
    state = Locale(languageCode, countryCode);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? 'SA');
    state = locale;
  }

  void toggleLanguage() {
    final newLocale = state.languageCode == 'ar' 
      ? const Locale('en', 'US') 
      : const Locale('ar', 'SA');
    setLocale(newLocale);
  }
}

// Auth Provider
final authProviderProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await AuthService.getCurrentUser();
      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signIn(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await AuthService.signInWithPhone(phoneNumber);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> verifyOTP(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await AuthService.verifyOTP(otp);
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await AuthService.signOut();
      state = AuthState.initial();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}

// Location Provider
final locationProviderProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState.initial()) {
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    state = state.copyWith(isLoading: true);
    try {
      final position = await LocationService.getCurrentPosition();
      state = state.copyWith(
        currentLocation: position,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> updateLocation(Position position) async {
    state = state.copyWith(currentLocation: position);
  }

  Future<void> setDestination(LatLng destination) async {
    state = state.copyWith(destination: destination);
  }
}

// Ride Provider
final rideProviderProvider = StateNotifierProvider<RideNotifier, RideState>(
  (ref) => RideNotifier(),
);

class RideNotifier extends StateNotifier<RideState> {
  RideNotifier() : super(RideState.initial());

  void requestRide({
    required LatLng pickup,
    required LatLng destination,
    required String genderPreference,
    required String paymentMethod,
  }) {
    state = state.copyWith(
      currentRide: RideModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pickup: pickup,
        destination: destination,
        genderPreference: genderPreference,
        paymentMethod: paymentMethod,
        status: RideStatus.requested,
        createdAt: DateTime.now(),
      ),
    );
  }

  void updateRideStatus(RideStatus status) {
    if (state.currentRide != null) {
      state = state.copyWith(
        currentRide: state.currentRide!.copyWith(status: status),
      );
    }
  }

  void assignRider(String riderId, String riderName) {
    if (state.currentRide != null) {
      state = state.copyWith(
        currentRide: state.currentRide!.copyWith(
          riderId: riderId,
          riderName: riderName,
        ),
      );
    }
  }

  void completeRide() {
    if (state.currentRide != null) {
      final completedRide = state.currentRide!.copyWith(
        status: RideStatus.completed,
        completedAt: DateTime.now(),
      );
      state = state.copyWith(
        currentRide: null,
        rideHistory: [...state.rideHistory, completedRide],
      );
    }
  }
}

// UI State Provider
final uiStateProviderProvider = StateNotifierProvider<UIStateNotifier, UIState>(
  (ref) => UIStateNotifier(),
);

class UIStateNotifier extends StateNotifier<UIState> {
  UIStateNotifier() : super(UIState.initial());

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void showError(String error) {
    state = state.copyWith(error: error);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void setBottomNavIndex(int index) {
    state = state.copyWith(bottomNavIndex: index);
  }
}

// State Models
class AuthState {
  final UserModel? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });

  factory AuthState.initial() => AuthState();

  AuthState copyWith({
    UserModel? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class LocationState {
  final Position? currentLocation;
  final LatLng? destination;
  final bool isLoading;
  final String? error;

  LocationState({
    this.currentLocation,
    this.destination,
    this.isLoading = false,
    this.error,
  });

  factory LocationState.initial() => LocationState();

  LocationState copyWith({
    Position? currentLocation,
    LatLng? destination,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class RideState {
  final RideModel? currentRide;
  final List<RideModel> rideHistory;
  final bool isLoading;
  final String? error;

  RideState({
    this.currentRide,
    this.rideHistory = const [],
    this.isLoading = false,
    this.error,
  });

  factory RideState.initial() => RideState();

  RideState copyWith({
    RideModel? currentRide,
    List<RideModel>? rideHistory,
    bool? isLoading,
    String? error,
  }) {
    return RideState(
      currentRide: currentRide ?? this.currentRide,
      rideHistory: rideHistory ?? this.rideHistory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UIState {
  final bool isLoading;
  final String? error;
  final int bottomNavIndex;

  UIState({
    this.isLoading = false,
    this.error,
    this.bottomNavIndex = 0,
  });

  factory UIState.initial() => UIState();

  UIState copyWith({
    bool? isLoading,
    String? error,
    int? bottomNavIndex,
  }) {
    return UIState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
    );
  }
}