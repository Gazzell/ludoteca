import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/app.dart';

import 'i18n/strings.g.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsFlutterBinding.ensureInitialized(); // add this
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const App()));
}
