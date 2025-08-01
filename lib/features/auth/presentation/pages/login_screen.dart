import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_container.dart';
import '../widgets/neon_button.dart';
import '../widgets/phone_input_field.dart';
import '../widgets/otp_input_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isOtpSent = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final phoneNumber = _phoneController.text.trim();
      await ref.read(authProviderProvider.notifier).signIn(phoneNumber);
      
      setState(() {
        _isOtpSent = true;
        _isLoading = false;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(localeProviderProvider).languageCode == 'ar' 
                ? 'تم إرسال رمز التحقق' 
                : 'OTP sent successfully',
            ),
            backgroundColor: AppColors.neonGreen,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final otp = _otpController.text.trim();
      await ref.read(authProviderProvider.notifier).verifyOTP(otp);
      
      // Navigation will be handled by the auth provider
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
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
    final authState = ref.watch(authProviderProvider);

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
            children: [
              // Language Toggle Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.md),
                  child: IconButton(
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
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: AppDimensions.xxl),

                        // Logo and Title
                        Column(
                          children: [
                            // Logo
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                                gradient: AppColors.neonGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonCyan.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.motorcycle,
                                size: 40,
                                color: AppColors.darkBase,
                              ),
                            )
                                .animate()
                                .scale(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.elasticOut,
                                ),

                            const SizedBox(height: AppDimensions.lg),

                            // Title
                            Text(
                              isArabic ? 'مرحباً بك في موتو رحلة' : 'Welcome to MotoRihla',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.warmWhite,
                                fontWeight: AppText.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 200))
                                .slideY(
                                  begin: 0.3,
                                  end: 0,
                                  duration: const Duration(milliseconds: 600),
                                ),

                            const SizedBox(height: AppDimensions.sm),

                            // Subtitle
                            Text(
                              isArabic 
                                ? 'سجل دخولك لطلب رحلة آمنة وسريعة'
                                : 'Sign in to book safe and fast rides',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.warmWhite.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 400)),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.xxl),

                        // Login Form
                        GlassmorphicContainer(
                          child: Column(
                            children: [
                              if (!_isOtpSent) ...[
                                // Phone Number Input
                                PhoneInputField(
                                  controller: _phoneController,
                                  label: isArabic ? 'رقم الهاتف' : 'Phone Number',
                                  hint: isArabic ? 'أدخل رقم هاتفك' : 'Enter your phone number',
                                ),

                                const SizedBox(height: AppDimensions.lg),

                                // Send OTP Button
                                NeonButton(
                                  onPressed: _isLoading ? null : _sendOTP,
                                  isLoading: _isLoading,
                                  text: isArabic ? 'إرسال رمز التحقق' : 'Send OTP',
                                ),
                              ] else ...[
                                // OTP Input
                                OTPInputField(
                                  controller: _otpController,
                                  label: isArabic ? 'رمز التحقق' : 'OTP Code',
                                  hint: isArabic ? 'أدخل رمز التحقق' : 'Enter OTP code',
                                ),

                                const SizedBox(height: AppDimensions.lg),

                                // Verify OTP Button
                                NeonButton(
                                  onPressed: _isLoading ? null : _verifyOTP,
                                  isLoading: _isLoading,
                                  text: isArabic ? 'تحقق' : 'Verify',
                                ),

                                const SizedBox(height: AppDimensions.md),

                                // Resend OTP
                                TextButton(
                                  onPressed: _isLoading ? null : () {
                                    setState(() {
                                      _isOtpSent = false;
                                      _otpController.clear();
                                    });
                                  },
                                  child: Text(
                                    isArabic ? 'إعادة إرسال الرمز' : 'Resend OTP',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.neonCyan,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 600))
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              duration: const Duration(milliseconds: 600),
                            ),

                        // Error Message
                        if (_errorMessage != null) ...[
                          const SizedBox(height: AppDimensions.md),
                          Container(
                            padding: const EdgeInsets.all(AppDimensions.md),
                            decoration: BoxDecoration(
                              color: AppColors.neonOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                              border: Border.all(
                                color: AppColors.neonOrange.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: AppColors.neonOrange,
                                  size: 20,
                                ),
                                const SizedBox(width: AppDimensions.sm),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.neonOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .fadeIn()
                              .shake(),
                        ],

                        const SizedBox(height: AppDimensions.xxl),

                        // Footer
                        Column(
                          children: [
                            Text(
                              isArabic ? 'باستخدام التطبيق، أنت توافق على' : 'By using the app, you agree to our',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.warmWhite.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navigate to terms
                                  },
                                  child: Text(
                                    isArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.neonCyan,
                                    ),
                                  ),
                                ),
                                Text(
                                  isArabic ? 'و' : ' and ',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.warmWhite.withOpacity(0.6),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navigate to privacy
                                  },
                                  child: Text(
                                    isArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.neonCyan,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 800)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}