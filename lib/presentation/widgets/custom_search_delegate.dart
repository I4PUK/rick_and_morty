import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/domain/entities/person_entity.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_event.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_projects/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final List<String> _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Компонент с правой строки поиска
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Компонент с правой строки поиска
    return IconButton(
      onPressed: () => close(context, null),
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // активируется при нажатии на кнопку поиска

    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query));

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(child: const CircularProgressIndicator());
        } else if (state is PersonSearchLoaded) {
          final person = state.persons;
          if (person.isEmpty) {
            return _showErrorText('No character with this name was found');
          }
          return Container(
            child: ListView.builder(
              itemCount: person.isNotEmpty ? person.length : 0,
              itemBuilder: (context, int index) {
                PersonEntity result = person[index];
                return SearchResult(personResult: result);
              },
            ),
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(child: const Icon(Icons.now_wallpaper));
        }
      },
    );
  }

  Widget _showErrorText(errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Обработка того что вводит пользователь
    if (query.isNotEmpty) return Container();
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => Text(
        _suggestions[index],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _suggestions.length,
    );
  }
}
