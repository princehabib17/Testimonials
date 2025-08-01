import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppDimensions.lg),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withOpacity(AppDimensions.glassOpacity),
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(
          color: borderColor ?? AppColors.neonCyan.withOpacity(0.3),
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.1),
            blurRadius: AppDimensions.blurRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}