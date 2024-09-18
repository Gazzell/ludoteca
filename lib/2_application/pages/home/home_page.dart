import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:ludoteca/2_application/core/page_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.home_outlined,
    name: 'home',
    child: HomePage(),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('body-small-and-up'),
            builder: (context) => Container(
              color: colorScheme.primaryContainer,
              child: const Center(
                child: Column(
                  children: [
                    Expanded(child: Text('Home')),
                  ],
                ),
              ),
            ),
          )
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.largeAndUp: SlotLayout.from(
            key: const Key('secondary-body-medium-and-up'),
            builder: (context) => const Placeholder(),
          )
        },
      ),
    );
  }
}
