import 'package:flutter_projects/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity{
  const LocationModel({name, url}) : super(name, url);

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(name: json['name'], url: json['url']);

  Map<String, dynamic> toJson() => {
    'name' : name,
    'url' : url,
  };
}