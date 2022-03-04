import 'dart:convert';

import 'package:flutter_projects/core/error/server_exception.dart';
import 'package:flutter_projects/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPersons(String query);
}

class PersonRemoteDataSourceImpl extends PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  //https://rickandmortyapi.com/api/character/?page=$page
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl("https://rickandmortyapi.com/api/character/?page=$page");

  //https://rickandmortyapi.com/api/character/?name=$query
  @override
  Future<List<PersonModel>> searchPersons(String query) => _getPersonFromUrl("https://rickandmortyapi.com/api/character/?name=$query");

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client.get(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
