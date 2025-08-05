import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _languageCodeKey = 'language_code';
  static const String _countryCodeKey = 'country_code';
  
  static const Locale arabic = Locale('ar', 'SA');
  static const Locale english = Locale('en', 'US');
  
  static const List<Locale> supportedLocales = [arabic, english];

  // Get current locale
  static Future<Locale> getCurrentLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey) ?? 'ar';
    final countryCode = prefs.getString(_countryCodeKey) ?? 'SA';
    return Locale(languageCode, countryCode);
  }

  // Set locale
  static Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode);
    await prefs.setString(_countryCodeKey, locale.countryCode ?? 'SA');
  }

  // Toggle between Arabic and English
  static Future<Locale> toggleLanguage() async {
    final currentLocale = await getCurrentLocale();
    final newLocale = currentLocale.languageCode == 'ar' ? english : arabic;
    await setLocale(newLocale);
    return newLocale;
  }

  // Check if current locale is Arabic
  static Future<bool> isArabic() async {
    final locale = await getCurrentLocale();
    return locale.languageCode == 'ar';
  }

  // Check if current locale is English
  static Future<bool> isEnglish() async {
    final locale = await getCurrentLocale();
    return locale.languageCode == 'en';
  }

  // Get text direction
  static TextDirection getTextDirection(Locale locale) {
    return locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }

  // Get localized string
  static String getLocalizedString(String key, Locale locale) {
    final translations = _getTranslations(locale);
    return translations[key] ?? key;
  }

  // Get translations map
  static Map<String, String> _getTranslations(Locale locale) {
    if (locale.languageCode == 'ar') {
      return _arabicTranslations;
    } else {
      return _englishTranslations;
    }
  }

  // Arabic translations
  static const Map<String, String> _arabicTranslations = {
    // App
    'app_name': 'موتو رحلة',
    'welcome': 'مرحباً بك',
    'loading': 'جاري التحميل...',
    'error': 'خطأ',
    'success': 'نجح',
    'cancel': 'إلغاء',
    'confirm': 'تأكيد',
    'retry': 'إعادة المحاولة',
    'save': 'حفظ',
    'delete': 'حذف',
    'edit': 'تعديل',
    'close': 'إغلاق',
    'back': 'رجوع',
    'next': 'التالي',
    'done': 'تم',
    
    // Auth
    'login': 'تسجيل الدخول',
    'register': 'إنشاء حساب',
    'phone_number': 'رقم الهاتف',
    'enter_phone': 'أدخل رقم هاتفك',
    'send_otp': 'إرسال رمز التحقق',
    'otp_code': 'رمز التحقق',
    'enter_otp': 'أدخل رمز التحقق',
    'verify': 'تحقق',
    'resend_otp': 'إعادة إرسال الرمز',
    'invalid_phone': 'رقم هاتف غير صحيح',
    'invalid_otp': 'رمز تحقق غير صحيح',
    
    // Passenger
    'book_ride': 'طلب رحلة',
    'where_to': 'إلى أين؟',
    'pickup_location': 'موقع الانطلاق',
    'destination': 'الوجهة',
    'enter_destination': 'أدخل وجهتك',
    'fare_estimate': 'تقدير السعر',
    'gender_preference': 'تفضيل الجنس',
    'any_rider': 'أي سائق',
    'male_rider': 'سائق ذكر',
    'female_rider': 'سائق أنثى',
    'payment_method': 'طريقة الدفع',
    'cash': 'نقداً',
    'card': 'بطاقة',
    'apple_pay': 'Apple Pay',
    'mada': 'مدى',
    'request_ride': 'طلب الرحلة',
    'ride_status': 'حالة الرحلة',
    'trip_history': 'سجل الرحلات',
    'wallet': 'المحفظة',
    'profile': 'الملف الشخصي',
    
    // Rider
    'go_online': 'اذهب أونلاين',
    'go_offline': 'اذهب أوفلاين',
    'incoming_requests': 'الطلبات الواردة',
    'active_ride': 'الرحلة النشطة',
    'earnings': 'الأرباح',
    'accept': 'قبول',
    'decline': 'رفض',
    'start_ride': 'بدء الرحلة',
    'end_ride': 'إنهاء الرحلة',
    'navigate': 'التنقل',
    
    // Ride Status
    'requested': 'مطلوب',
    'accepted': 'مقبول',
    'arrived': 'وصل',
    'in_progress': 'قيد التنفيذ',
    'completed': 'مكتمل',
    'cancelled': 'ملغي',
    'driver_arriving': 'السائق في الطريق',
    'driver_arrived': 'السائق وصل',
    'ride_started': 'بدأت الرحلة',
    'ride_completed': 'انتهت الرحلة',
    
    // Payment
    'payment': 'الدفع',
    'total_fare': 'إجمالي السعر',
    'tip': 'إكرامية',
    'add_tip': 'إضافة إكرامية',
    'payment_successful': 'تم الدفع بنجاح',
    'payment_failed': 'فشل في الدفع',
    'insufficient_balance': 'رصيد غير كافي',
    
    // Rating
    'rate_ride': 'قيّم الرحلة',
    'rate_driver': 'قيّم السائق',
    'rate_passenger': 'قيّم الراكب',
    'excellent': 'ممتاز',
    'good': 'جيد',
    'average': 'متوسط',
    'poor': 'ضعيف',
    'terrible': 'سيء',
    'add_review': 'أضف تقييم',
    'optional': 'اختياري',
    
    // Profile
    'personal_info': 'المعلومات الشخصية',
    'name': 'الاسم',
    'email': 'البريد الإلكتروني',
    'phone': 'الهاتف',
    'city': 'المدينة',
    'gender': 'الجنس',
    'male': 'ذكر',
    'female': 'أنثى',
    'date_of_birth': 'تاريخ الميلاد',
    'settings': 'الإعدادات',
    'language': 'اللغة',
    'notifications': 'الإشعارات',
    'privacy': 'الخصوصية',
    'help': 'المساعدة',
    'about': 'حول',
    'logout': 'تسجيل الخروج',
    
    // Wallet
    'balance': 'الرصيد',
    'add_money': 'إضافة مال',
    'transaction_history': 'سجل المعاملات',
    'amount': 'المبلغ',
    'date': 'التاريخ',
    'status': 'الحالة',
    'pending': 'قيد الانتظار',
    'completed': 'مكتمل',
    'failed': 'فشل',
    
    // Errors
    'network_error': 'خطأ في الشبكة',
    'location_error': 'خطأ في الموقع',
    'permission_denied': 'تم رفض الإذن',
    'service_unavailable': 'الخدمة غير متوفرة',
    'try_again': 'حاول مرة أخرى',
    'contact_support': 'تواصل مع الدعم',
  };

  // English translations
  static const Map<String, String> _englishTranslations = {
    // App
    'app_name': 'MotoRihla',
    'welcome': 'Welcome',
    'loading': 'Loading...',
    'error': 'Error',
    'success': 'Success',
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'retry': 'Retry',
    'save': 'Save',
    'delete': 'Delete',
    'edit': 'Edit',
    'close': 'Close',
    'back': 'Back',
    'next': 'Next',
    'done': 'Done',
    
    // Auth
    'login': 'Login',
    'register': 'Register',
    'phone_number': 'Phone Number',
    'enter_phone': 'Enter your phone number',
    'send_otp': 'Send OTP',
    'otp_code': 'OTP Code',
    'enter_otp': 'Enter OTP code',
    'verify': 'Verify',
    'resend_otp': 'Resend OTP',
    'invalid_phone': 'Invalid phone number',
    'invalid_otp': 'Invalid OTP code',
    
    // Passenger
    'book_ride': 'Book Ride',
    'where_to': 'Where to?',
    'pickup_location': 'Pickup Location',
    'destination': 'Destination',
    'enter_destination': 'Enter destination',
    'fare_estimate': 'Fare Estimate',
    'gender_preference': 'Gender Preference',
    'any_rider': 'Any Rider',
    'male_rider': 'Male Rider',
    'female_rider': 'Female Rider',
    'payment_method': 'Payment Method',
    'cash': 'Cash',
    'card': 'Card',
    'apple_pay': 'Apple Pay',
    'mada': 'Mada',
    'request_ride': 'Request Ride',
    'ride_status': 'Ride Status',
    'trip_history': 'Trip History',
    'wallet': 'Wallet',
    'profile': 'Profile',
    
    // Rider
    'go_online': 'Go Online',
    'go_offline': 'Go Offline',
    'incoming_requests': 'Incoming Requests',
    'active_ride': 'Active Ride',
    'earnings': 'Earnings',
    'accept': 'Accept',
    'decline': 'Decline',
    'start_ride': 'Start Ride',
    'end_ride': 'End Ride',
    'navigate': 'Navigate',
    
    // Ride Status
    'requested': 'Requested',
    'accepted': 'Accepted',
    'arrived': 'Arrived',
    'in_progress': 'In Progress',
    'completed': 'Completed',
    'cancelled': 'Cancelled',
    'driver_arriving': 'Driver arriving',
    'driver_arrived': 'Driver arrived',
    'ride_started': 'Ride started',
    'ride_completed': 'Ride completed',
    
    // Payment
    'payment': 'Payment',
    'total_fare': 'Total Fare',
    'tip': 'Tip',
    'add_tip': 'Add Tip',
    'payment_successful': 'Payment successful',
    'payment_failed': 'Payment failed',
    'insufficient_balance': 'Insufficient balance',
    
    // Rating
    'rate_ride': 'Rate Ride',
    'rate_driver': 'Rate Driver',
    'rate_passenger': 'Rate Passenger',
    'excellent': 'Excellent',
    'good': 'Good',
    'average': 'Average',
    'poor': 'Poor',
    'terrible': 'Terrible',
    'add_review': 'Add Review',
    'optional': 'Optional',
    
    // Profile
    'personal_info': 'Personal Info',
    'name': 'Name',
    'email': 'Email',
    'phone': 'Phone',
    'city': 'City',
    'gender': 'Gender',
    'male': 'Male',
    'female': 'Female',
    'date_of_birth': 'Date of Birth',
    'settings': 'Settings',
    'language': 'Language',
    'notifications': 'Notifications',
    'privacy': 'Privacy',
    'help': 'Help',
    'about': 'About',
    'logout': 'Logout',
    
    // Wallet
    'balance': 'Balance',
    'add_money': 'Add Money',
    'transaction_history': 'Transaction History',
    'amount': 'Amount',
    'date': 'Date',
    'status': 'Status',
    'pending': 'Pending',
    'completed': 'Completed',
    'failed': 'Failed',
    
    // Errors
    'network_error': 'Network error',
    'location_error': 'Location error',
    'permission_denied': 'Permission denied',
    'service_unavailable': 'Service unavailable',
    'try_again': 'Try again',
    'contact_support': 'Contact support',
  };
}