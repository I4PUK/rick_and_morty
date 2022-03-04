import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/locator_service.dart' as di;
import 'package:flutter_projects/locator_service.dart';
import 'package:flutter_projects/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_projects/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_projects/presentation/pages/person_screen.dart';

Future<void> main() async {
  //Регистрируем все библиотеки, затем создаем интерфейс.
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PersonListCubit>(create: (context) => sl<PersonListCubit>()),
      BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
    ], child: MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: HomePage(),
    ),);
  }
}
