import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/neon_button.dart';

class RideStatusScreen extends ConsumerStatefulWidget {
  const RideStatusScreen({super.key});

  @override
  ConsumerState<RideStatusScreen> createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends ConsumerState<RideStatusScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() {
    // Mock ride data - in real app, this would come from the ride provider
    final currentLocation = const LatLng(24.7136, 46.6753); // Riyadh
    final destination = const LatLng(24.7236, 46.6853);
    
    _markers.addAll([
      Marker(
        markerId: const MarkerId('pickup'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Pickup Location'),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: destination,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Fit bounds to show both markers
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: const LatLng(24.7036, 46.6653),
          northeast: const LatLng(24.7336, 46.6953),
        ),
        50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';
    final rideState = ref.watch(rideProviderProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.7136, 46.6753),
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
          ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
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
                        Icons.arrow_back,
                        color: AppColors.neonCyan,
                        size: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // TODO: Show ride details
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
                        Icons.info_outline,
                        color: AppColors.neonCyan,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Ride Status Card
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
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Driver Info Card
                      GlassmorphicCard(
                        child: Column(
                          children: [
                            // Driver Profile
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.neonCyan.withOpacity(0.2),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.neonCyan,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: AppDimensions.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ahmed Al-Rashid',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.warmWhite,
                                          fontWeight: AppText.semibold,
                                        ),
                                      ),
                                      const SizedBox(height: AppDimensions.xs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppColors.neonOrange,
                                            size: 16,
                                          ),
                                          const SizedBox(width: AppDimensions.xs),
                                          Text(
                                            '4.8 (127 rides)',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.warmWhite.withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // TODO: Call driver
                                      },
                                      icon: Container(
                                        padding: const EdgeInsets.all(AppDimensions.sm),
                                        decoration: BoxDecoration(
                                          color: AppColors.neonGreen.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                                          border: Border.all(
                                            color: AppColors.neonGreen,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.phone,
                                          color: AppColors.neonGreen,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // TODO: Message driver
                                      },
                                      icon: Container(
                                        padding: const EdgeInsets.all(AppDimensions.sm),
                                        decoration: BoxDecoration(
                                          color: AppColors.neonCyan.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                                          border: Border.all(
                                            color: AppColors.neonCyan,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.message,
                                          color: AppColors.neonCyan,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: AppDimensions.md),

                            // Vehicle Info
                            Container(
                              padding: const EdgeInsets.all(AppDimensions.md),
                              decoration: BoxDecoration(
                                color: AppColors.darkCard.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                                border: Border.all(
                                  color: AppColors.warmWhite.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.motorcycle,
                                    color: AppColors.neonCyan,
                                    size: 24,
                                  ),
                                  const SizedBox(width: AppDimensions.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Honda CBR 600RR',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.warmWhite,
                                            fontWeight: AppText.medium,
                                          ),
                                        ),
                                        Text(
                                          'Red • ABC-1234',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.warmWhite.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppDimensions.md),

                            // Ride Status
                            Container(
                              padding: const EdgeInsets.all(AppDimensions.md),
                              decoration: BoxDecoration(
                                color: AppColors.neonGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                                border: Border.all(
                                  color: AppColors.neonGreen.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: AppColors.neonGreen,
                                    size: 20,
                                  ),
                                  const SizedBox(width: AppDimensions.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isArabic ? 'السائق في الطريق' : 'Driver arriving',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.neonGreen,
                                            fontWeight: AppText.semibold,
                                          ),
                                        ),
                                        Text(
                                          'ETA: 3 min',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.warmWhite.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppDimensions.md),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: NeonButton(
                              onPressed: () {
                                // TODO: Cancel ride
                              },
                              text: isArabic ? 'إلغاء الرحلة' : 'Cancel Ride',
                              isOutlined: true,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.md),
                          Expanded(
                            child: NeonButton(
                              onPressed: () {
                                // TODO: Share ride
                              },
                              text: isArabic ? 'مشاركة' : 'Share',
                              icon: Icons.share,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}