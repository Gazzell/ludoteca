import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class CollectionItemDetailSmallPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailSmallPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (Breakpoints.small.isActive(context) && context.canPop()) {
          context.pop(true);
        }
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: CollectionItemDetailPage(selectedItem: selectedItem),
      ),
    );
  }
}

class CollectionItemDetailPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Text(selectedItem?.value ?? '');
  }
}
