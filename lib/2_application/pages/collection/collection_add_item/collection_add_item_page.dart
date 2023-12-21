import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionAddItemPage extends StatelessWidget {
  final bool showAppBar;
  final String? title;

  const CollectionAddItemPage({super.key, this.showAppBar = false, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? ''),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
            )
          : null,
      body: Builder(
        builder: (context) {
          return const Placeholder();
        },
      ),
    );
  }
}
