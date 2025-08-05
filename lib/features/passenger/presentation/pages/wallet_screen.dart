import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/neon_button.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      appBar: AppBar(
        title: Text(
          isArabic ? 'المحفظة' : 'Wallet',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: Column(
          children: [
            // Balance Card
            GlassmorphicCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.neonGreen,
                        size: 32,
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'الرصيد الحالي' : 'Current Balance',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.warmWhite.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              '150.75 SAR',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.neonGreen,
                                fontWeight: AppText.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.lg),
                  Row(
                    children: [
                      Expanded(
                        child: NeonButton(
                          onPressed: () {
                            // TODO: Add money
                          },
                          text: isArabic ? 'إضافة مال' : 'Add Money',
                          icon: Icons.add,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: NeonButton(
                          onPressed: () {
                            // TODO: Withdraw money
                          },
                          text: isArabic ? 'سحب' : 'Withdraw',
                          icon: Icons.remove,
                          isOutlined: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 200)),

            const SizedBox(height: AppDimensions.lg),

            // Payment Methods
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'طرق الدفع' : 'Payment Methods',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  _buildPaymentMethod(
                    icon: Icons.apple,
                    title: 'Apple Pay',
                    subtitle: isArabic ? 'مضاف' : 'Added',
                    isSelected: true,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  _buildPaymentMethod(
                    icon: Icons.credit_card,
                    title: isArabic ? 'مدى' : 'Mada',
                    subtitle: isArabic ? 'مضاف' : 'Added',
                    isSelected: false,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  _buildPaymentMethod(
                    icon: Icons.credit_card_outlined,
                    title: isArabic ? 'بطاقة ائتمان' : 'Credit Card',
                    subtitle: isArabic ? 'إضافة' : 'Add',
                    isSelected: false,
                    isAdd: true,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 400)),

            const SizedBox(height: AppDimensions.lg),

            // Transaction History
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isArabic ? 'سجل المعاملات' : 'Transaction History',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.warmWhite,
                          fontWeight: AppText.semibold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: View all transactions
                        },
                        child: Text(
                          isArabic ? 'عرض الكل' : 'View All',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.neonCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.md),
                  _buildTransaction(
                    icon: Icons.add,
                    title: isArabic ? 'إضافة رصيد' : 'Add Money',
                    subtitle: 'March 15, 2024',
                    amount: '+50.00 SAR',
                    isPositive: true,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  _buildTransaction(
                    icon: Icons.motorcycle,
                    title: isArabic ? 'رحلة' : 'Ride',
                    subtitle: 'March 14, 2024',
                    amount: '-25.50 SAR',
                    isPositive: false,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  _buildTransaction(
                    icon: Icons.remove,
                    title: isArabic ? 'سحب رصيد' : 'Withdraw',
                    subtitle: 'March 10, 2024',
                    amount: '-100.00 SAR',
                    isPositive: false,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    bool isAdd = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: BoxDecoration(
        color: isSelected 
          ? AppColors.neonCyan.withOpacity(0.2)
          : AppColors.darkCard.withOpacity(0.6),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(
          color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.7),
            size: 24,
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? AppColors.neonCyan : AppColors.warmWhite,
                    fontWeight: AppText.medium,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warmWhite.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: AppColors.neonCyan,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildTransaction({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required bool isPositive,
  }) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(AppDimensions.sm),
            decoration: BoxDecoration(
              color: isPositive 
                ? AppColors.neonGreen.withOpacity(0.2)
                : AppColors.neonOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            ),
            child: Icon(
              icon,
              color: isPositive ? AppColors.neonGreen : AppColors.neonOrange,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.warmWhite,
                    fontWeight: AppText.medium,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warmWhite.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isPositive ? AppColors.neonGreen : AppColors.neonOrange,
              fontWeight: AppText.semibold,
            ),
          ),
        ],
      ),
    );
  }
}