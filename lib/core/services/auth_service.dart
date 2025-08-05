import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? _verificationId;

  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // In a real app, you would fetch user data from your backend
        // For now, we'll create a mock user
        return UserModel(
          id: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          userType: UserType.passenger, // Default to passenger
          status: UserStatus.active,
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  // Sign in with phone number
  static Future<void> signInWithPhone(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (Android only)
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Verify OTP
  static Future<UserModel> verifyOTP(String otp) async {
    try {
      if (_verificationId == null) {
        throw Exception('No verification ID available');
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        throw Exception('Failed to sign in with OTP');
      }

      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', user.uid);
      await prefs.setString('phone_number', user.phoneNumber ?? '');

      // In a real app, you would create/fetch user data from your backend
      return UserModel(
        id: user.uid,
        phoneNumber: user.phoneNumber ?? '',
        userType: UserType.passenger, // Default to passenger
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      
      // Clear local data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('phone_number');
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  // Get current Firebase user
  static User? getCurrentFirebaseUser() {
    return _auth.currentUser;
  }

  // Update user profile
  static Future<void> updateUserProfile(UserModel user) async {
    try {
      // In a real app, you would update user data in your backend
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', user.toJson().toString());
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Delete account
  static Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        
        // Clear local data
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}