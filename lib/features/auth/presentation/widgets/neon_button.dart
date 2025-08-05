import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class NeonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final IconData? icon;
  final bool isOutlined;

  const NeonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.radiusMd),
        gradient: isOutlined ? null : (backgroundColor != null ? null : AppColors.neonGradient),
        color: isOutlined ? Colors.transparent : backgroundColor,
        border: isOutlined ? Border.all(
          color: AppColors.neonCyan,
          width: 2,
        ) : null,
        boxShadow: isOutlined ? null : [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.radiusMd),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.xl,
              vertical: AppDimensions.md,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isOutlined ? AppColors.neonCyan : AppColors.darkBase,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: isOutlined ? AppColors.neonCyan : AppColors.darkBase,
                            size: 20,
                          ),
                          const SizedBox(width: AppDimensions.sm),
                        ],
                        Text(
                          text,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: textColor ?? (isOutlined ? AppColors.neonCyan : AppColors.darkBase),
                            fontWeight: AppText.semibold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}