import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/error/failure.dart';
import 'package:flutter_projects/domain/use_cases/search_person.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_event.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = "Server failure";
const CACHE_FAILURE_MESSAGE = "Cache failure";

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>(
      (event, emit) async {
        emit(PersonSearchLoading());

        final failureOrPerson =
            await searchPerson(SearchPersonParams(query: event.personQuery));
        emit(
          failureOrPerson.fold(
            (failure) =>
                PersonSearchError(message: _mapFailureToMessage(failure)),
            (person) => PersonSearchLoaded(persons: person),
          ),
        );
      },
    );
  }

  // BLoC less 7.2.0
  //
  // @override
  // Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
  //   if (event is SearchPersons) {
  //     yield* _mapFetchPersonsToState(event.personQuery);
  //   }
  // }
  //
  // Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
  //   yield PersonSearchLoading();
  //   final failureOrPerson =
  //       await searchPerson(SearchPersonParams(query: personQuery));
  //   yield failureOrPerson.fold((failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
  //       (person) => PersonSearchLoaded(person));
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error";
    }
  }
}
