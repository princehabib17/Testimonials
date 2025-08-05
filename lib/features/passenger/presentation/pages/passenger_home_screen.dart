import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/neon_button.dart';
import '../widgets/destination_input.dart';
import '../widgets/gender_preference_selector.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/fare_estimate_card.dart';
import '../widgets/ride_status_card.dart';
import 'ride_status_screen.dart';
import 'trip_history_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class PassengerHomeScreen extends ConsumerStatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  ConsumerState<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends ConsumerState<PassengerHomeScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  
  LatLng? _currentLocation;
  LatLng? _destination;
  String _destinationAddress = '';
  
  String _selectedGenderPreference = 'Any';
  String _selectedPaymentMethod = 'Cash';
  double _estimatedFare = 0.0;
  
  bool _isLoading = false;
  bool _showBookingCard = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      final locationState = ref.read(locationProviderProvider);
      if (locationState.currentLocation != null) {
        _currentLocation = LatLng(
          locationState.currentLocation!.latitude,
          locationState.currentLocation!.longitude,
        );
        _addCurrentLocationMarker();
        setState(() {});
      }
    } catch (e) {
      // Handle location error
    }
  }

  void _addCurrentLocationMarker() {
    if (_currentLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      );
    }
  }

  void _addDestinationMarker() {
    if (_destination != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: _destination!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: _destinationAddress),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentLocation != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, 15),
      );
    }
  }

  void _onDestinationSelected(LatLng destination, String address) {
    setState(() {
      _destination = destination;
      _destinationAddress = address;
      _showBookingCard = true;
    });
    
    _addDestinationMarker();
    _calculateFare();
  }

  void _calculateFare() {
    if (_currentLocation != null && _destination != null) {
      // Simple fare calculation (in real app, this would use Google Directions API)
      final distance = Geolocator.distanceBetween(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        _destination!.latitude,
        _destination!.longitude,
      );
      
      // Base fare + distance fare
      _estimatedFare = 5.0 + (distance / 1000) * 2.0;
      setState(() {});
    }
  }

  Future<void> _requestRide() async {
    if (_currentLocation == null || _destination == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      ref.read(rideProviderProvider.notifier).requestRide(
        pickup: _currentLocation!,
        destination: _destination!,
        genderPreference: _selectedGenderPreference,
        paymentMethod: _selectedPaymentMethod,
      );

      // Navigate to ride status screen
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RideStatusScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleLanguage() {
    ref.read(localeProviderProvider.notifier).toggleLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';
    final locationState = ref.watch(locationProviderProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? const LatLng(24.7136, 46.6753), // Riyadh
              zoom: 15,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            mapType: MapType.normal,
            style: _getMapStyle(),
          ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: Row(
                children: [
                  // Language Toggle
                  IconButton(
                    onPressed: _toggleLanguage,
                    icon: Container(
                      padding: const EdgeInsets.all(AppDimensions.sm),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard.withOpacity(AppDimensions.glassOpacity),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                        border: Border.all(
                          color: AppColors.neonCyan.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isArabic ? 'EN' : 'عربي',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.neonCyan,
                          fontWeight: AppText.semibold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Profile Button
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(AppDimensions.sm),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard.withOpacity(AppDimensions.glassOpacity),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                        border: Border.all(
                          color: AppColors.neonCyan.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColors.neonCyan,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Destination Input
          Positioned(
            top: 100,
            left: AppDimensions.md,
            right: AppDimensions.md,
            child: DestinationInput(
              onDestinationSelected: _onDestinationSelected,
              isArabic: isArabic,
            ),
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.darkBase.withOpacity(0.8),
                    AppColors.darkBase,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Booking Card
                    if (_showBookingCard) ...[
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.md),
                        child: GlassmorphicCard(
                          child: Column(
                            children: [
                              // Gender Preference
                              GenderPreferenceSelector(
                                selectedPreference: _selectedGenderPreference,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGenderPreference = value;
                                  });
                                },
                                isArabic: isArabic,
                              ),

                              const SizedBox(height: AppDimensions.md),

                              // Payment Method
                              PaymentMethodSelector(
                                selectedMethod: _selectedPaymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentMethod = value;
                                  });
                                },
                                isArabic: isArabic,
                              ),

                              const SizedBox(height: AppDimensions.md),

                              // Fare Estimate
                              FareEstimateCard(
                                fare: _estimatedFare,
                                isArabic: isArabic,
                              ),

                              const SizedBox(height: AppDimensions.md),

                              // Request Ride Button
                              NeonButton(
                                onPressed: _isLoading ? null : _requestRide,
                                isLoading: _isLoading,
                                text: isArabic ? 'طلب الرحلة' : 'Request Ride',
                                icon: Icons.motorcycle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Bottom Navigation Bar
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            icon: Icons.home,
                            label: isArabic ? 'الرئيسية' : 'Home',
                            isSelected: true,
                            onTap: () {},
                          ),
                          _buildNavItem(
                            icon: Icons.history,
                            label: isArabic ? 'التاريخ' : 'History',
                            isSelected: false,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const TripHistoryScreen(),
                                ),
                              );
                            },
                          ),
                          _buildNavItem(
                            icon: Icons.account_balance_wallet,
                            label: isArabic ? 'المحفظة' : 'Wallet',
                            isSelected: false,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const WalletScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected 
            ? AppColors.neonCyan.withOpacity(0.1)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: isSelected 
            ? Border.all(color: AppColors.neonCyan, width: 1)
            : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: AppDimensions.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.6),
                fontWeight: isSelected ? AppText.semibold : AppText.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMapStyle() {
    return '''
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#242f3e"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#746855"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#242f3e"
          }
        ]
      },
      {
        "featureType": "administrative.locality",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#263c3f"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#6b9a76"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#38414e"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#212a37"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9ca5b3"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#746855"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#1f2835"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#f3d19c"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2f3948"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#17263c"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#515c6d"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#17263c"
          }
        ]
      }
    ]
    ''';
  }
}