import 'package:equatable/equatable.dart';
import 'package:flutter_projects/domain/entities/location_entity.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime created;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        status,
        gender,
        origin,
        location,
        image,
        episode,
        created,
      ];
}
