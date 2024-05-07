import 'package:flutter/material.dart';
import 'package:ludoteca/i18n/strings.g.dart';

Widget withTranslationProvider(Widget child) {
  return TranslationProvider(child: child);
}