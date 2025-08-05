import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class FareEstimateCard extends StatelessWidget {
  final double fare;
  final bool isArabic;

  const FareEstimateCard({
    super.key,
    required this.fare,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Icons.attach_money,
            color: AppColors.neonGreen,
            size: 24,
          ),
          const SizedBox(width: AppDimensions.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'تقدير السعر' : 'Fare Estimate',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warmWhite.withOpacity(0.7),
                  ),
                ),
                Text(
                  '${fare.toStringAsFixed(2)} SAR',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.neonGreen,
                    fontWeight: AppText.bold,
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
            ),
            child: Text(
              isArabic ? 'تقدير' : 'Estimate',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.neonGreen,
                fontWeight: AppText.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}