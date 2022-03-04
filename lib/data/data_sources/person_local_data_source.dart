import 'dart:convert';

import 'package:flutter_projects/core/error/server_exception.dart';
import 'package:flutter_projects/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl extends PersonLocalDataSource{
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() async {
    //TODO: refactor this
    final list = sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
    final List<String> jsonPersonsList = list;
    if (jsonPersonsList.isNotEmpty){
      return Future.value(jsonPersonsList.map((person) => PersonModel.fromJson(json.decode(person))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }

}