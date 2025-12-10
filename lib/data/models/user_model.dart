import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User Model (Traveler)
@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String country;
  final String preferredLanguage;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.country,
    required this.preferredLanguage,
    this.profileImage,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phone,
        country,
        preferredLanguage,
        profileImage,
        createdAt,
        updatedAt,
      ];
}

/// Provider Model
@JsonSerializable()
class ProviderModel extends Equatable {
  final String id;
  final String businessName;
  final String category;
  final String country;
  final String city;
  final String email;
  final String phone;
  final String? businessLogo;
  final String? description;
  final bool isVerified;
  final double? rating;
  final int? totalReviews;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProviderModel({
    required this.id,
    required this.businessName,
    required this.category,
    required this.country,
    required this.city,
    required this.email,
    required this.phone,
    this.businessLogo,
    this.description,
    this.isVerified = false,
    this.rating,
    this.totalReviews,
    required this.createdAt,
    this.updatedAt,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        businessName,
        category,
        country,
        city,
        email,
        phone,
        businessLogo,
        description,
        isVerified,
        rating,
        totalReviews,
        createdAt,
        updatedAt,
      ];
}

/// Auth Response Model
@JsonSerializable()
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String userType; // 'traveler' or 'provider'
  final UserModel? user;
  final ProviderModel? provider;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userType,
    this.user,
    this.provider,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
