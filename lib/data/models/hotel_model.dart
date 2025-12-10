import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

/// Hotel Model
@JsonSerializable()
class HotelModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String destinationId;
  final String address;
  final String city;
  final String country;
  final List<String> images;
  final double rating;
  final int reviewsCount;
  final double pricePerNight;
  final String currency;
  final List<String> amenities;
  final MapLocation location;
  final String? phone;
  final String? email;
  final String? website;
  final int starRating; // 1-5 stars
  final bool isFeatured;
  final DateTime createdAt;

  const HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.destinationId,
    required this.address,
    required this.city,
    required this.country,
    required this.images,
    required this.rating,
    required this.reviewsCount,
    required this.pricePerNight,
    required this.currency,
    required this.amenities,
    required this.location,
    this.phone,
    this.email,
    this.website,
    required this.starRating,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        destinationId,
        address,
        city,
        country,
        images,
        rating,
        reviewsCount,
        pricePerNight,
        currency,
        amenities,
        location,
        phone,
        email,
        website,
        starRating,
        isFeatured,
        createdAt,
      ];
}

/// Map Location
@JsonSerializable()
class MapLocation extends Equatable {
  final double latitude;
  final double longitude;

  const MapLocation({
    required this.latitude,
    required this.longitude,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) =>
      _$MapLocationFromJson(json);

  Map<String, dynamic> toJson() => _$MapLocationToJson(this);

  @override
  List<Object?> get props => [latitude, longitude];
}
