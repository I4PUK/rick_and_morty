import 'package:flutter_projects/data/models/location_model.dart';
import 'package:flutter_projects/domain/entities/location_entity.dart';
import 'package:flutter_projects/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required int id,
    required String name,
    required String status,
    required String gender,
    required LocationEntity? origin,
    required LocationEntity? location,
    required String image,
    required List<String> episode,
    required DateTime created,
  }) : super(
          id: id,
          name: name,
          status: status,
          gender: gender,
          origin: origin!,
          location: location!,
          image: image,
          episode: episode,
          created: created,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        gender: json['gender'],
        origin: json['origin'] != null
            ? LocationModel.fromJson(json['origin'])
            : null,
        location: json['location'] != null
            ? LocationModel.fromJson(json['location'])
            : null,
        image: json['image'],
        episode:
            (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
        created: DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'gender': gender,
        'origin': origin,
        'location': location,
        'image': image,
        'episode': episode,
        'created': created.toIso8601String(),
      };
}
