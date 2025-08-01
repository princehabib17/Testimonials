import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/neon_button.dart';

class RiderHomeScreen extends ConsumerStatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  ConsumerState<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends ConsumerState<RiderHomeScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      appBar: AppBar(
        title: Text(
          isArabic ? 'موتو رحلة - السائق' : 'MotoRihla - Rider',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.warmWhite,
            fontWeight: AppText.semibold,
          ),
        ),
        backgroundColor: AppColors.darkBase,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Rider profile
            },
            icon: Icon(
              Icons.person,
              color: AppColors.neonCyan,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          children: [
            // Online/Offline Toggle
            GlassmorphicCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        _isOnline ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: _isOnline ? AppColors.neonGreen : AppColors.neonOrange,
                        size: 32,
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isOnline 
                                ? (isArabic ? 'متصل' : 'Online')
                                : (isArabic ? 'غير متصل' : 'Offline'),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: _isOnline ? AppColors.neonGreen : AppColors.neonOrange,
                                fontWeight: AppText.semibold,
                              ),
                            ),
                            Text(
                              _isOnline 
                                ? (isArabic ? 'جاهز لاستقبال الطلبات' : 'Ready to receive requests')
                                : (isArabic ? 'غير متاح للطلبات' : 'Not available for requests'),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.warmWhite.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.lg),
                  NeonButton(
                    onPressed: () {
                      setState(() {
                        _isOnline = !_isOnline;
                      });
                    },
                    text: _isOnline 
                      ? (isArabic ? 'اذهب أوفلاين' : 'Go Offline')
                      : (isArabic ? 'اذهب أونلاين' : 'Go Online'),
                    backgroundColor: _isOnline ? AppColors.neonOrange : AppColors.neonGreen,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 200)),

            const SizedBox(height: AppDimensions.lg),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: GlassmorphicCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.today,
                          color: AppColors.neonCyan,
                          size: 32,
                        ),
                        const SizedBox(height: AppDimensions.sm),
                        Text(
                          '12',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.neonCyan,
                            fontWeight: AppText.bold,
                          ),
                        ),
                        Text(
                          isArabic ? 'اليوم' : 'Today',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.warmWhite.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Expanded(
                  child: GlassmorphicCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: AppColors.neonGreen,
                          size: 32,
                        ),
                        const SizedBox(height: AppDimensions.sm),
                        Text(
                          '350 SAR',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.neonGreen,
                            fontWeight: AppText.bold,
                          ),
                        ),
                        Text(
                          isArabic ? 'الأرباح' : 'Earnings',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.warmWhite.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: const Duration(milliseconds: 400)),

            const SizedBox(height: AppDimensions.lg),

            // Quick Actions
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'الإجراءات السريعة' : 'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.history,
                          title: isArabic ? 'التاريخ' : 'History',
                          onTap: () {
                            // TODO: Ride history
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.account_balance_wallet,
                          title: isArabic ? 'الأرباح' : 'Earnings',
                          onTap: () {
                            // TODO: Earnings screen
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.settings,
                          title: isArabic ? 'الإعدادات' : 'Settings',
                          onTap: () {
                            // TODO: Settings screen
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.help_outline,
                          title: isArabic ? 'المساعدة' : 'Help',
                          onTap: () {
                            // TODO: Help screen
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 600)),

            const Spacer(),

            // Status Message
            if (!_isOnline)
              GlassmorphicCard(
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.neonOrange,
                      size: 24,
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    Expanded(
                      child: Text(
                        isArabic 
                          ? 'أنت غير متصل حالياً. اضغط على "اذهب أونلاين" لبدء استقبال الطلبات.'
                          : 'You are currently offline. Tap "Go Online" to start receiving requests.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.warmWhite.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.md),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withOpacity(0.6),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: AppColors.neonCyan.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.neonCyan,
              size: 32,
            ),
            const SizedBox(height: AppDimensions.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.warmWhite,
                fontWeight: AppText.medium,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}