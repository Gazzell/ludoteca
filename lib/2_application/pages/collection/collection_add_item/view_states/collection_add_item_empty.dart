import 'package:flutter/material.dart';
import 'package:ludoteca/i18n/strings.g.dart';

class CollectionAddItemEmpty extends StatelessWidget {
  const CollectionAddItemEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Text(t.collectionNoItemSelected);
  }
}
