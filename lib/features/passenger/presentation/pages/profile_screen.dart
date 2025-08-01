import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/localization_service.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/neon_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderProvider);
    final isArabic = locale.languageCode == 'ar';
    final authState = ref.watch(authProviderProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBase,
      appBar: AppBar(
        title: Text(
          isArabic ? 'الملف الشخصي' : 'Profile',
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
            // Profile Header
            GlassmorphicCard(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.neonCyan.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      color: AppColors.neonCyan,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  Text(
                    authState.user?.displayName ?? 'User',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  Text(
                    authState.user?.phoneNumber ?? '+966 50 123 4567',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.warmWhite.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  NeonButton(
                    onPressed: () {
                      // TODO: Edit profile
                    },
                    text: isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile',
                    icon: Icons.edit,
                    isOutlined: true,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 200)),

            const SizedBox(height: AppDimensions.lg),

            // Settings Section
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'الإعدادات' : 'Settings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  _buildSettingItem(
                    icon: Icons.language,
                    title: isArabic ? 'اللغة' : 'Language',
                    subtitle: isArabic ? 'العربية' : 'English',
                    onTap: () {
                      ref.read(localeProviderProvider.notifier).toggleLanguage();
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.notifications,
                    title: isArabic ? 'الإشعارات' : 'Notifications',
                    subtitle: isArabic ? 'مفعلة' : 'Enabled',
                    onTap: () {
                      // TODO: Notification settings
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.security,
                    title: isArabic ? 'الخصوصية' : 'Privacy',
                    subtitle: isArabic ? 'إعدادات الخصوصية' : 'Privacy Settings',
                    onTap: () {
                      // TODO: Privacy settings
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.help_outline,
                    title: isArabic ? 'المساعدة' : 'Help',
                    subtitle: isArabic ? 'الدعم والمساعدة' : 'Support & Help',
                    onTap: () {
                      // TODO: Help center
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.info_outline,
                    title: isArabic ? 'حول' : 'About',
                    subtitle: 'MotoRihla v1.0.0',
                    onTap: () {
                      // TODO: About app
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 400)),

            const SizedBox(height: AppDimensions.lg),

            // Preferences Section
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'التفضيلات' : 'Preferences',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  _buildPreferenceItem(
                    icon: Icons.person,
                    title: isArabic ? 'تفضيل الجنس' : 'Gender Preference',
                    subtitle: isArabic ? 'أي سائق' : 'Any Rider',
                    onTap: () {
                      // TODO: Gender preference settings
                    },
                  ),
                  _buildPreferenceItem(
                    icon: Icons.payment,
                    title: isArabic ? 'طريقة الدفع الافتراضية' : 'Default Payment',
                    subtitle: 'Apple Pay',
                    onTap: () {
                      // TODO: Payment method settings
                    },
                  ),
                  _buildPreferenceItem(
                    icon: Icons.location_on,
                    title: isArabic ? 'الموقع الافتراضي' : 'Default Location',
                    subtitle: isArabic ? 'الرياض' : 'Riyadh',
                    onTap: () {
                      // TODO: Location settings
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 600)),

            const SizedBox(height: AppDimensions.lg),

            // Account Actions
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'الحساب' : 'Account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.warmWhite,
                      fontWeight: AppText.semibold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  _buildActionItem(
                    icon: Icons.download,
                    title: isArabic ? 'تصدير البيانات' : 'Export Data',
                    subtitle: isArabic ? 'تحميل بياناتك' : 'Download your data',
                    onTap: () {
                      // TODO: Export data
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.delete_outline,
                    title: isArabic ? 'حذف الحساب' : 'Delete Account',
                    subtitle: isArabic ? 'حذف نهائي' : 'Permanent deletion',
                    onTap: () {
                      // TODO: Delete account
                    },
                    isDestructive: true,
                  ),
                  const SizedBox(height: AppDimensions.md),
                  NeonButton(
                    onPressed: () {
                      ref.read(authProviderProvider.notifier).signOut();
                      Navigator.of(context).pop();
                    },
                    text: isArabic ? 'تسجيل الخروج' : 'Logout',
                    icon: Icons.logout,
                    backgroundColor: AppColors.neonOrange,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppDimensions.sm),
        decoration: BoxDecoration(
          color: AppColors.neonCyan.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Icon(
          icon,
          color: AppColors.neonCyan,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.warmWhite,
          fontWeight: AppText.medium,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.warmWhite.withOpacity(0.7),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.warmWhite.withOpacity(0.5),
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppDimensions.sm),
        decoration: BoxDecoration(
          color: AppColors.neonGreen.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Icon(
          icon,
          color: AppColors.neonGreen,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.warmWhite,
          fontWeight: AppText.medium,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.warmWhite.withOpacity(0.7),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.warmWhite.withOpacity(0.5),
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppDimensions.sm),
        decoration: BoxDecoration(
          color: isDestructive 
            ? AppColors.neonOrange.withOpacity(0.2)
            : AppColors.neonPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppColors.neonOrange : AppColors.neonPurple,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isDestructive ? AppColors.neonOrange : AppColors.warmWhite,
          fontWeight: AppText.medium,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.warmWhite.withOpacity(0.7),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.warmWhite.withOpacity(0.5),
        size: 16,
      ),
      onTap: onTap,
    );
  }
}