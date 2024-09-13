import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/0_data/data_sources/hive_local_data_source.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_local.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/app.dart';

import 'i18n/strings.g.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  final localDataSource = HiveLocalDataSource();
  await localDataSource.init();

  runApp(
    TranslationProvider(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<BggRepository>(
            create: (context) => BggRepository(bggDataSource: BggDataSource()),
          ),
          RepositoryProvider<CollectionRepository>(
            create: (context) =>
                CollectionRepositoryLocal(localDataSource: localDataSource),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
