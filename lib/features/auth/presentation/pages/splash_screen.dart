import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import 'login_screen.dart';
import '../../passenger/presentation/pages/passenger_home_screen.dart';
import '../../rider/presentation/pages/rider_home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _startAnimations();
    _checkAuthAndNavigate();
  }

  void _startAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    final authState = ref.read(authProviderProvider);
    
    if (authState.isAuthenticated) {
      final user = authState.user;
      if (user != null) {
        if (user.isRider) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const RiderHomeScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PassengerHomeScreen(),
            ),
          );
        }
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkBase,
              AppColors.darkSurface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and App Name
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo Container
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                        gradient: AppColors.neonGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonCyan.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.motorcycle,
                          size: 60,
                          color: AppColors.darkBase,
                        ),
                      ),
                    )
                        .animate(controller: _logoController)
                        .scale(
                          begin: const Offset(0, 0),
                          end: const Offset(1, 1),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.elasticOut,
                        )
                        .then()
                        .shimmer(
                          duration: const Duration(seconds: 2),
                          color: AppColors.warmWhite.withOpacity(0.3),
                        ),

                    const SizedBox(height: AppDimensions.xl),

                    // App Name
                    Text(
                      isArabic ? AppStrings.appNameAr : AppStrings.appName,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        background: Paint()
                          ..shader = AppColors.neonGradient.createShader(
                            const Rect.fromLTWH(0, 0, 200, 50),
                          ),
                      ),
                    )
                        .animate(controller: _textController)
                        .fadeIn(duration: const Duration(milliseconds: 800))
                        .slideY(
                          begin: 0.3,
                          end: 0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutQuad,
                        ),

                    const SizedBox(height: AppDimensions.md),

                    // Tagline
                    Text(
                      isArabic ? 'رحلة آمنة وسريعة' : 'Safe & Fast Rides',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.warmWhite.withOpacity(0.7),
                      ),
                    )
                        .animate(controller: _textController)
                        .fadeIn(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 600),
                        ),
                  ],
                ),
              ),

              // Loading Indicator
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Glassmorphic Loading Container
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.lg),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard.withOpacity(AppDimensions.glassOpacity),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                        border: Border.all(
                          color: AppColors.neonCyan.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonCyan.withOpacity(0.1),
                            blurRadius: AppDimensions.blurRadius,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Loading Animation
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.neonCyan,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimensions.md),
                          Text(
                            isArabic ? AppStrings.loadingAr : AppStrings.loading,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.warmWhite.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 1000))
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                          duration: const Duration(milliseconds: 500),
                        ),
                  ],
                ),
              ),

              // Bottom Spacing
              const SizedBox(height: AppDimensions.xxl),
            ],
          ),
        ),
      ),
    );
  }
}