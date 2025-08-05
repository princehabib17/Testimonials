import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final bool enabled;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: AppDimensions.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: AppDimensions.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: AppDimensions.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neonCyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  border: Border.all(
                    color: AppColors.neonCyan.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '+966',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.neonCyan,
                    fontWeight: AppText.medium,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.sm),
              Container(
                width: 1,
                height: 20,
                color: AppColors.warmWhite.withOpacity(0.3),
              ),
            ],
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        if (value.length < 9) {
          return 'Phone number must be at least 9 digits';
        }
        if (value.length > 10) {
          return 'Phone number must be at most 10 digits';
        }
        return null;
      },
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.warmWhite,
      ),
    );
  }
}