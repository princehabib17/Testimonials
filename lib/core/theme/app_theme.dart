import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonCyan,
        secondary: AppColors.accentMagenta,
        surface: AppColors.darkSurface,
        background: AppColors.darkBase,
        onPrimary: AppColors.darkBase,
        onSecondary: AppColors.warmWhite,
        onSurface: AppColors.warmWhite,
        onBackground: AppColors.warmWhite,
        error: AppColors.neonOrange,
        onError: AppColors.warmWhite,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.darkBase,
      
      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBase,
        foregroundColor: AppColors.warmWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.sfProDisplay(
          fontSize: 20,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: AppColors.darkCard.withOpacity(0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        margin: const EdgeInsets.all(AppDimensions.md),
      ),
      
      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonCyan,
          foregroundColor: AppColors.darkBase,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.xl,
            vertical: AppDimensions.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.sfProDisplay(
            fontSize: 16,
            fontWeight: AppText.semibold,
          ),
        ),
      ),
      
      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.neonCyan,
          side: const BorderSide(color: AppColors.neonCyan, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.xl,
            vertical: AppDimensions.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.sfProDisplay(
            fontSize: 16,
            fontWeight: AppText.semibold,
          ),
        ),
      ),
      
      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.neonCyan,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: AppDimensions.sm,
          ),
          textStyle: GoogleFonts.sfProDisplay(
            fontSize: 14,
            fontWeight: AppText.medium,
          ),
        ),
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.neonCyan, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.neonOrange, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.md,
        ),
        hintStyle: GoogleFonts.sfProDisplay(
          fontSize: 16,
          color: AppColors.warmWhite.withOpacity(0.6),
        ),
        labelStyle: GoogleFonts.sfProDisplay(
          fontSize: 16,
          color: AppColors.warmWhite,
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sfProDisplay(
          fontSize: 32,
          fontWeight: AppText.bold,
          color: AppColors.warmWhite,
        ),
        displayMedium: GoogleFonts.sfProDisplay(
          fontSize: 28,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        displaySmall: GoogleFonts.sfProDisplay(
          fontSize: 24,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        headlineLarge: GoogleFonts.sfProDisplay(
          fontSize: 22,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        headlineMedium: GoogleFonts.sfProDisplay(
          fontSize: 20,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        headlineSmall: GoogleFonts.sfProDisplay(
          fontSize: 18,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite,
        ),
        titleLarge: GoogleFonts.sfProDisplay(
          fontSize: 16,
          fontWeight: AppText.semibold,
          color: AppColors.warmWhite,
        ),
        titleMedium: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite,
        ),
        titleSmall: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite.withOpacity(0.8),
        ),
        bodyLarge: GoogleFonts.sfProDisplay(
          fontSize: 16,
          fontWeight: AppText.regular,
          color: AppColors.warmWhite,
        ),
        bodyMedium: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.regular,
          color: AppColors.warmWhite,
        ),
        bodySmall: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.regular,
          color: AppColors.warmWhite.withOpacity(0.8),
        ),
        labelLarge: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite,
        ),
        labelMedium: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite.withOpacity(0.8),
        ),
        labelSmall: GoogleFonts.sfProDisplay(
          fontSize: 10,
          fontWeight: AppText.medium,
          color: AppColors.warmWhite.withOpacity(0.6),
        ),
      ),
      
      // Bottom navigation bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.neonCyan,
        unselectedItemColor: AppColors.warmWhite.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      // Floating action button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.neonCyan,
        foregroundColor: AppColors.darkBase,
        elevation: 8,
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.darkCard,
        thickness: 1,
        space: AppDimensions.md,
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.warmWhite,
        size: AppDimensions.iconSize,
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkCard.withOpacity(0.6),
        selectedColor: AppColors.neonCyan,
        labelStyle: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.medium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
      ),
    );
  }
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color scheme for light theme (fallback)
      colorScheme: const ColorScheme.light(
        primary: AppColors.neonCyan,
        secondary: AppColors.accentMagenta,
        surface: Colors.white,
        background: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkBase,
        onBackground: AppColors.darkBase,
        error: AppColors.neonOrange,
        onError: Colors.white,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: Colors.white,
      
      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkBase,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.sfProDisplay(
          fontSize: 20,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shadowColor: AppColors.darkBase.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        margin: const EdgeInsets.all(AppDimensions.md),
      ),
      
      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonCyan,
          foregroundColor: AppColors.darkBase,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.xl,
            vertical: AppDimensions.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.sfProDisplay(
            fontSize: 16,
            fontWeight: AppText.semibold,
          ),
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sfProDisplay(
          fontSize: 32,
          fontWeight: AppText.bold,
          color: AppColors.darkBase,
        ),
        displayMedium: GoogleFonts.sfProDisplay(
          fontSize: 28,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        displaySmall: GoogleFonts.sfProDisplay(
          fontSize: 24,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        headlineLarge: GoogleFonts.sfProDisplay(
          fontSize: 22,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        headlineMedium: GoogleFonts.sfProDisplay(
          fontSize: 20,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        headlineSmall: GoogleFonts.sfProDisplay(
          fontSize: 18,
          fontWeight: AppText.medium,
          color: AppColors.darkBase,
        ),
        titleLarge: GoogleFonts.sfProDisplay(
          fontSize: 16,
          fontWeight: AppText.semibold,
          color: AppColors.darkBase,
        ),
        titleMedium: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.medium,
          color: AppColors.darkBase,
        ),
        titleSmall: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.medium,
          color: AppColors.darkBase.withOpacity(0.8),
        ),
        bodyLarge: GoogleFonts.sfProDisplay(
          fontSize: 16,
          fontWeight: AppText.regular,
          color: AppColors.darkBase,
        ),
        bodyMedium: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.regular,
          color: AppColors.darkBase,
        ),
        bodySmall: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.regular,
          color: AppColors.darkBase.withOpacity(0.8),
        ),
        labelLarge: GoogleFonts.sfProDisplay(
          fontSize: 14,
          fontWeight: AppText.medium,
          color: AppColors.darkBase,
        ),
        labelMedium: GoogleFonts.sfProDisplay(
          fontSize: 12,
          fontWeight: AppText.medium,
          color: AppColors.darkBase.withOpacity(0.8),
        ),
        labelSmall: GoogleFonts.sfProDisplay(
          fontSize: 10,
          fontWeight: AppText.medium,
          color: AppColors.darkBase.withOpacity(0.6),
        ),
      ),
    );
  }
}