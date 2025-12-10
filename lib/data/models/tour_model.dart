import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour_model.g.dart';

/// Tour Model
@JsonSerializable()
class TourModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String destinationId;
  final List<String> images;
  final double price;
  final String currency;
  final String duration; // e.g., "3 hours", "Full day"
  final List<String> included;
  final List<String> excluded;
  final double rating;
  final int reviewsCount;
  final String? meetingPoint;
  final String? startTime;
  final int maxGroupSize;
  final List<String> languages;
  final String difficulty; // Easy, Moderate, Hard
  final bool isFeatured;
  final DateTime createdAt;

  const TourModel({
    required this.id,
    required this.name,
    required this.description,
    required this.destinationId,
    required this.images,
    required this.price,
    required this.currency,
    required this.duration,
    required this.included,
    required this.excluded,
    required this.rating,
    required this.reviewsCount,
    this.meetingPoint,
    this.startTime,
    required this.maxGroupSize,
    required this.languages,
    required this.difficulty,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) =>
      _$TourModelFromJson(json);

  Map<String, dynamic> toJson() => _$TourModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        destinationId,
        images,
        price,
        currency,
        duration,
        included,
        excluded,
        rating,
        reviewsCount,
        meetingPoint,
        startTime,
        maxGroupSize,
        languages,
        difficulty,
        isFeatured,
        createdAt,
      ];
}
