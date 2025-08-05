import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onChanged;
  final bool isArabic;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final methods = [
      {
        'value': 'Apple Pay',
        'label': 'Apple Pay',
        'icon': Icons.apple,
      },
      {
        'value': 'Mada',
        'label': isArabic ? 'مدى' : 'Mada',
        'icon': Icons.credit_card,
      },
      {
        'value': 'Credit/Debit',
        'label': isArabic ? 'بطاقة ائتمان/مدى' : 'Credit/Debit',
        'icon': Icons.credit_card_outlined,
      },
      {
        'value': 'Cash',
        'label': isArabic ? 'نقداً' : 'Cash',
        'icon': Icons.money,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'طريقة الدفع' : 'Payment Method',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.warmWhite,
            fontWeight: AppText.semibold,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        Wrap(
          spacing: AppDimensions.sm,
          runSpacing: AppDimensions.sm,
          children: methods.map((method) {
            final isSelected = selectedMethod == method['value'];
            return GestureDetector(
              onTap: () => onChanged(method['value']!),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: AppDimensions.sm,
                ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      method['icon'] as IconData,
                      color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.7),
                      size: 16,
                    ),
                    const SizedBox(width: AppDimensions.xs),
                    Text(
                      method['label']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.7),
                        fontWeight: isSelected ? AppText.semibold : AppText.regular,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}