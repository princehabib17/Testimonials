import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';

class OTPInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final bool enabled;
  final int length;

  const OTPInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.enabled = true,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.md,
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'OTP code is required';
        }
        if (value.length < length) {
          return 'OTP code must be $length digits';
        }
        return null;
      },
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: AppColors.warmWhite,
        fontWeight: AppText.bold,
        letterSpacing: 8,
      ),
    );
  }
}