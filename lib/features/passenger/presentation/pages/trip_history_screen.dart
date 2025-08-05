import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';

class TripHistoryScreen extends ConsumerWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      appBar: AppBar(
        title: Text(
          isArabic ? 'سجل الرحلات' : 'Trip History',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.warmWhite,
            fontWeight: AppText.semibold,
          ),
        ),
        backgroundColor: AppColors.darkBase,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.neonCyan,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.md),
        itemCount: 10, // Mock data
        itemBuilder: (context, index) {
          return GlassmorphicCard(
            margin: const EdgeInsets.only(bottom: AppDimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Header
                Row(
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
                            'Riyadh → Jeddah',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.warmWhite,
                              fontWeight: AppText.semibold,
                            ),
                          ),
                          Text(
                            'March 15, 2024 • 2:30 PM',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warmWhite.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.sm,
                        vertical: AppDimensions.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                        border: Border.all(
                          color: AppColors.neonGreen,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isArabic ? 'مكتمل' : 'Completed',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.neonGreen,
                          fontWeight: AppText.medium,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.md),

                // Trip Details
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? 'السائق' : 'Driver',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warmWhite.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            'Ahmed Al-Rashid',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.warmWhite,
                              fontWeight: AppText.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? 'السعر' : 'Fare',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warmWhite.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            '25.50 SAR',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.neonGreen,
                              fontWeight: AppText.semibold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? 'التقييم' : 'Rating',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warmWhite.withOpacity(0.7),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.neonOrange,
                                size: 16,
                              ),
                              const SizedBox(width: AppDimensions.xs),
                              Text(
                                '4.8',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.warmWhite,
                                  fontWeight: AppText.medium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.md),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: View trip details
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.neonCyan,
                          side: const BorderSide(color: AppColors.neonCyan),
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
                        ),
                        child: Text(
                          isArabic ? 'التفاصيل' : 'Details',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: AppText.medium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Rate trip
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.neonOrange,
                          side: const BorderSide(color: AppColors.neonOrange),
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
                        ),
                        child: Text(
                          isArabic ? 'تقييم' : 'Rate',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: AppText.medium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: index * 100));
        },
      ),
    );
  }
}