import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ludoteca/i18n/strings.g.dart';

Widget withMaterialAppTranslation(Widget child) {
  return TranslationProvider(
    child: Builder(
      builder: (context) {
        return MaterialApp(
          home: child,
          locale: const Locale('en'),
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        );
      }
    ),
  );
}
