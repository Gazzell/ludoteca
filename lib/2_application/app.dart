import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/core/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CollectionRepository>(
      create: (context) => CollectionRepositoryMock(
        bggDataSource: BggDataSource(),
      ),
      child: MaterialApp.router(
        title: 'Ludoteca app',
        routerConfig: routes,
        themeMode: ThemeMode.system,
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 239, 43, 187),
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 239, 43, 187),
          ),
        ),
      ),
    );
  }
}
