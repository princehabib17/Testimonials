import 'package:json_annotation/json_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'ride_model.g.dart';

enum RideStatus { 
  requested, 
  accepted, 
  arrived, 
  started, 
  completed, 
  cancelled 
}

enum PaymentStatus { 
  pending, 
  completed, 
  failed, 
  refunded 
}

@JsonSerializable()
class RideModel {
  final String id;
  final String passengerId;
  final String? riderId;
  final String? riderName;
  final String? riderPhone;
  final String? riderImage;
  final double? riderRating;
  
  final LatLng pickup;
  final String pickupAddress;
  final LatLng destination;
  final String destinationAddress;
  
  final String genderPreference;
  final String paymentMethod;
  final double estimatedFare;
  final double? actualFare;
  final double? tip;
  
  final RideStatus status;
  final PaymentStatus paymentStatus;
  
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? arrivedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  
  final int? estimatedDuration; // in minutes
  final double? estimatedDistance; // in km
  final int? actualDuration; // in minutes
  final double? actualDistance; // in km
  
  final String? cancellationReason;
  final String? notes;
  final double? passengerRating;
  final String? passengerReview;
  final double? riderRating;
  final String? riderReview;

  RideModel({
    required this.id,
    required this.passengerId,
    this.riderId,
    this.riderName,
    this.riderPhone,
    this.riderImage,
    this.riderRating,
    
    required this.pickup,
    required this.pickupAddress,
    required this.destination,
    required this.destinationAddress,
    
    required this.genderPreference,
    required this.paymentMethod,
    required this.estimatedFare,
    this.actualFare,
    this.tip,
    
    required this.status,
    this.paymentStatus = PaymentStatus.pending,
    
    required this.createdAt,
    this.acceptedAt,
    this.arrivedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    
    this.estimatedDuration,
    this.estimatedDistance,
    this.actualDuration,
    this.actualDistance,
    
    this.cancellationReason,
    this.notes,
    this.passengerRating,
    this.passengerReview,
    this.riderRating,
    this.riderReview,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) => _$RideModelFromJson(json);
  Map<String, dynamic> toJson() => _$RideModelToJson(this);

  RideModel copyWith({
    String? id,
    String? passengerId,
    String? riderId,
    String? riderName,
    String? riderPhone,
    String? riderImage,
    double? riderRating,
    
    LatLng? pickup,
    String? pickupAddress,
    LatLng? destination,
    String? destinationAddress,
    
    String? genderPreference,
    String? paymentMethod,
    double? estimatedFare,
    double? actualFare,
    double? tip,
    
    RideStatus? status,
    PaymentStatus? paymentStatus,
    
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? arrivedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    
    int? estimatedDuration,
    double? estimatedDistance,
    int? actualDuration,
    double? actualDistance,
    
    String? cancellationReason,
    String? notes,
    double? passengerRating,
    String? passengerReview,
    double? riderRating,
    String? riderReview,
  }) {
    return RideModel(
      id: id ?? this.id,
      passengerId: passengerId ?? this.passengerId,
      riderId: riderId ?? this.riderId,
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      riderImage: riderImage ?? this.riderImage,
      riderRating: riderRating ?? this.riderRating,
      
      pickup: pickup ?? this.pickup,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      destination: destination ?? this.destination,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      
      genderPreference: genderPreference ?? this.genderPreference,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      tip: tip ?? this.tip,
      
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      arrivedAt: arrivedAt ?? this.arrivedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      estimatedDistance: estimatedDistance ?? this.estimatedDistance,
      actualDuration: actualDuration ?? this.actualDuration,
      actualDistance: actualDistance ?? this.actualDistance,
      
      cancellationReason: cancellationReason ?? this.cancellationReason,
      notes: notes ?? this.notes,
      passengerRating: passengerRating ?? this.passengerRating,
      passengerReview: passengerReview ?? this.passengerReview,
      riderRating: riderRating ?? this.riderRating,
      riderReview: riderReview ?? this.riderReview,
    );
  }

  bool get isActive => status == RideStatus.requested || 
                      status == RideStatus.accepted || 
                      status == RideStatus.arrived || 
                      status == RideStatus.started;
  
  bool get isCompleted => status == RideStatus.completed;
  bool get isCancelled => status == RideStatus.cancelled;
  bool get hasRider => riderId != null;
  
  double get totalFare => (actualFare ?? estimatedFare) + (tip ?? 0);
  
  Duration? get duration {
    if (startedAt == null || completedAt == null) return null;
    return completedAt!.difference(startedAt!);
  }
  
  String get statusText {
    switch (status) {
      case RideStatus.requested:
        return 'Requested';
      case RideStatus.accepted:
        return 'Accepted';
      case RideStatus.arrived:
        return 'Arrived';
      case RideStatus.started:
        return 'In Progress';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';
    }
  }
  
  String get statusTextAr {
    switch (status) {
      case RideStatus.requested:
        return 'مطلوب';
      case RideStatus.accepted:
        return 'مقبول';
      case RideStatus.arrived:
        return 'وصل';
      case RideStatus.started:
        return 'قيد التنفيذ';
      case RideStatus.completed:
        return 'مكتمل';
      case RideStatus.cancelled:
        return 'ملغي';
    }
  }
}