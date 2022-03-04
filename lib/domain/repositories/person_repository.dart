import 'package:dartz/dartz.dart';
import 'package:flutter_projects/core/error/failure.dart';
import 'package:flutter_projects/domain/entities/person_entity.dart';

// contract for repository
abstract class PersonRepository{
  Future<Either<Failure,List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure,List<PersonEntity>>> searchPerson(String query);
}