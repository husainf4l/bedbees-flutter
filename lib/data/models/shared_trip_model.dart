import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_trip_model.g.dart';

/// Shared Trip Model
@JsonSerializable()
class SharedTripModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String destinationId;
  final String destinationName;
  final DateTime startDate;
  final DateTime endDate;
  final int maxParticipants;
  final int currentParticipants;
  final double estimatedCost;
  final String currency;
  final String creatorId;
  final String creatorName;
  final String? creatorImage;
  final List<String> interests; // Adventure, Cultural, Food, etc.
  final String tripType; // Backpacking, Luxury, Budget, etc.
  final List<Participant> participants;
  final String status; // Open, Full, In Progress, Completed
  final DateTime createdAt;

  const SharedTripModel({
    required this.id,
    required this.title,
    required this.description,
    required this.destinationId,
    required this.destinationName,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.estimatedCost,
    required this.currency,
    required this.creatorId,
    required this.creatorName,
    this.creatorImage,
    required this.interests,
    required this.tripType,
    required this.participants,
    required this.status,
    required this.createdAt,
  });

  factory SharedTripModel.fromJson(Map<String, dynamic> json) =>
      _$SharedTripModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharedTripModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        destinationId,
        destinationName,
        startDate,
        endDate,
        maxParticipants,
        currentParticipants,
        estimatedCost,
        currency,
        creatorId,
        creatorName,
        creatorImage,
        interests,
        tripType,
        participants,
        status,
        createdAt,
      ];
}

/// Participant
@JsonSerializable()
class Participant extends Equatable {
  final String userId;
  final String name;
  final String? profileImage;
  final DateTime joinedAt;

  const Participant({
    required this.userId,
    required this.name,
    this.profileImage,
    required this.joinedAt,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  @override
  List<Object?> get props => [userId, name, profileImage, joinedAt];
}
