import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/app.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const App());
}
