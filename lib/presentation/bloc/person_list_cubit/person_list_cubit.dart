import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/error/failure.dart';
import 'package:flutter_projects/domain/entities/person_entity.dart';
import 'package:flutter_projects/domain/use_cases/get_all_persons.dart';
import 'package:flutter_projects/presentation/bloc/person_list_cubit/person_list_state.dart';

const SERVER_FAILURE_MESSAGE = "Server failure";
const CACHE_FAILURE_MESSAGE = "Cache failure";

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;
    var oldPerson = <PersonEntity>[];

    if (currentState is PersonLoaded){
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold((error) => emit(PersonError(message: _mapFailureToMessage(error))), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(persons);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error";
    }
  }
}
