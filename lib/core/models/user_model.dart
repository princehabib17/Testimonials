import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserType { passenger, rider }

enum UserStatus { pending, active, suspended, verified }

@JsonSerializable()
class UserModel {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final UserType userType;
  final UserStatus status;
  final String? profileImage;
  final String? city;
  final String? gender;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final DateTime? lastActive;
  
  // Rider-specific fields
  final String? licenseNumber;
  final String? istimaraNumber;
  final String? istiqdamNumber;
  final String? vehicleModel;
  final String? vehicleColor;
  final String? vehiclePlate;
  final bool isOnline;
  final double? currentLat;
  final double? currentLng;
  final double rating;
  final int totalRides;
  final double totalEarnings;
  
  // Passenger-specific fields
  final List<String>? savedAddresses;
  final String? defaultPaymentMethod;
  final double walletBalance;
  final List<String>? favoriteRiders;

  UserModel({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    required this.userType,
    required this.status,
    this.profileImage,
    this.city,
    this.gender,
    this.dateOfBirth,
    required this.createdAt,
    this.lastActive,
    
    // Rider fields
    this.licenseNumber,
    this.istimaraNumber,
    this.istiqdamNumber,
    this.vehicleModel,
    this.vehicleColor,
    this.vehiclePlate,
    this.isOnline = false,
    this.currentLat,
    this.currentLng,
    this.rating = 0.0,
    this.totalRides = 0,
    this.totalEarnings = 0.0,
    
    // Passenger fields
    this.savedAddresses,
    this.defaultPaymentMethod,
    this.walletBalance = 0.0,
    this.favoriteRiders,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    UserType? userType,
    UserStatus? status,
    String? profileImage,
    String? city,
    String? gender,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    DateTime? lastActive,
    
    // Rider fields
    String? licenseNumber,
    String? istimaraNumber,
    String? istiqdamNumber,
    String? vehicleModel,
    String? vehicleColor,
    String? vehiclePlate,
    bool? isOnline,
    double? currentLat,
    double? currentLng,
    double? rating,
    int? totalRides,
    double? totalEarnings,
    
    // Passenger fields
    List<String>? savedAddresses,
    String? defaultPaymentMethod,
    double? walletBalance,
    List<String>? favoriteRiders,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      status: status ?? this.status,
      profileImage: profileImage ?? this.profileImage,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      
      // Rider fields
      licenseNumber: licenseNumber ?? this.licenseNumber,
      istimaraNumber: istimaraNumber ?? this.istimaraNumber,
      istiqdamNumber: istiqdamNumber ?? this.istiqdamNumber,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      isOnline: isOnline ?? this.isOnline,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      
      // Passenger fields
      savedAddresses: savedAddresses ?? this.savedAddresses,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      walletBalance: walletBalance ?? this.walletBalance,
      favoriteRiders: favoriteRiders ?? this.favoriteRiders,
    );
  }

  bool get isRider => userType == UserType.rider;
  bool get isPassenger => userType == UserType.passenger;
  bool get isVerified => status == UserStatus.verified;
  bool get isActive => status == UserStatus.active;
  
  String get displayName => name ?? phoneNumber;
  String get initials => name?.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join('').toUpperCase() ?? 'U';
}