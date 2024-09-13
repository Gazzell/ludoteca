import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/i18n/strings.g.dart';
import 'package:mocktail/mocktail.dart';

class MockBggRepository extends Mock implements BggRepository {}

Widget withMaterialAppTranslation(Widget child) {
  return TranslationProvider(
    child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CollectionRepository>(
            create: (context) => CollectionRepositoryMock(),
          ),
          RepositoryProvider<BggRepository>(
            create: (context) => MockBggRepository(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            home: child,
            locale: const Locale('en'),
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        })),
  );
}
