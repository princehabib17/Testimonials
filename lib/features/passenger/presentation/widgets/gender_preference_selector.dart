import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class GenderPreferenceSelector extends StatelessWidget {
  final String selectedPreference;
  final Function(String) onChanged;
  final bool isArabic;

  const GenderPreferenceSelector({
    super.key,
    required this.selectedPreference,
    required this.onChanged,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final preferences = [
      {'value': 'Any', 'label': isArabic ? 'أي سائق' : 'Any Rider'},
      {'value': 'Male', 'label': isArabic ? 'سائق ذكر' : 'Male Rider'},
      {'value': 'Female', 'label': isArabic ? 'سائق أنثى' : 'Female Rider'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'تفضيل الجنس' : 'Gender Preference',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.warmWhite,
            fontWeight: AppText.semibold,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        Wrap(
          spacing: AppDimensions.sm,
          children: preferences.map((preference) {
            final isSelected = selectedPreference == preference['value'];
            return FilterChip(
              label: Text(
                preference['label']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.darkBase : AppColors.warmWhite,
                  fontWeight: isSelected ? AppText.semibold : AppText.regular,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onChanged(preference['value']!);
              },
              backgroundColor: AppColors.darkCard.withOpacity(0.6),
              selectedColor: AppColors.neonCyan,
              checkmarkColor: AppColors.darkBase,
              side: BorderSide(
                color: isSelected ? AppColors.neonCyan : AppColors.warmWhite.withOpacity(0.3),
                width: 1,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}