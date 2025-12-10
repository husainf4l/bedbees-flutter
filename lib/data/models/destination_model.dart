import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'destination_model.g.dart';

/// Destination Model
@JsonSerializable()
class DestinationModel extends Equatable {
  final String id;
  final String name;
  final String country;
  final String? city;
  final String heroImage;
  final List<String> gallery;
  final String description;
  final List<String> highlights;
  final String? bestTimeToVisit;
  final WeatherInfo? weatherInfo;
  final String? safetyInfo;
  final List<String> tips;
  final List<Neighborhood> neighborhoods;
  final List<String>? popularHotels;
  final List<String>? popularTours;
  final List<String>? popularActivities;
  final MapLocation? mapLocation;
  final List<String> categories;
  final double? rating;
  final int? reviewsCount;
  final bool isFeatured;
  final DateTime createdAt;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.country,
    this.city,
    required this.heroImage,
    required this.gallery,
    required this.description,
    required this.highlights,
    this.bestTimeToVisit,
    this.weatherInfo,
    this.safetyInfo,
    required this.tips,
    required this.neighborhoods,
    this.popularHotels,
    this.popularTours,
    this.popularActivities,
    this.mapLocation,
    required this.categories,
    this.rating,
    this.reviewsCount,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        city,
        heroImage,
        gallery,
        description,
        highlights,
        bestTimeToVisit,
        weatherInfo,
        safetyInfo,
        tips,
        neighborhoods,
        popularHotels,
        popularTours,
        popularActivities,
        mapLocation,
        categories,
        rating,
        reviewsCount,
        isFeatured,
        createdAt,
      ];
}

/// Weather Info
@JsonSerializable()
class WeatherInfo extends Equatable {
  final String? currentTemp;
  final String? description;
  final String? humidity;
  final String? windSpeed;

  const WeatherInfo({
    this.currentTemp,
    this.description,
    this.humidity,
    this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);

  @override
  List<Object?> get props => [currentTemp, description, humidity, windSpeed];
}

/// Neighborhood
@JsonSerializable()
class Neighborhood extends Equatable {
  final String name;
  final String description;
  final String? image;

  const Neighborhood({
    required this.name,
    required this.description,
    this.image,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) =>
      _$NeighborhoodFromJson(json);

  Map<String, dynamic> toJson() => _$NeighborhoodToJson(this);

  @override
  List<Object?> get props => [name, description, image];
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
