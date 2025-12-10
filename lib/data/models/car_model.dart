import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

/// Car Rental Model
@JsonSerializable()
class CarModel extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final String description;
  final String destinationId;
  final List<String> images;
  final double pricePerDay;
  final String currency;
  final String transmission; // Automatic, Manual
  final String fuelType; // Petrol, Diesel, Electric, Hybrid
  final int seats;
  final int doors;
  final List<String> features;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;
  final DateTime createdAt;

  const CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.description,
    required this.destinationId,
    required this.images,
    required this.pricePerDay,
    required this.currency,
    required this.transmission,
    required this.fuelType,
    required this.seats,
    required this.doors,
    required this.features,
    required this.rating,
    required this.reviewsCount,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        model,
        year,
        description,
        destinationId,
        images,
        pricePerDay,
        currency,
        transmission,
        fuelType,
        seats,
        doors,
        features,
        rating,
        reviewsCount,
        isFeatured,
        createdAt,
      ];
}
