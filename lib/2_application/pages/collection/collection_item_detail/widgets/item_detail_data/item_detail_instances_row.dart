import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

class ItemDetailInstancesRow extends StatelessWidget {
  final ItemInstance itemInstance;
  final int index;
  const ItemDetailInstancesRow(
      {super.key, required this.index, required this.itemInstance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = itemInstance.status == ItemInstanceStatus.unavailable;
    final isBorrowed = isAvailable && itemInstance.borrowedAt != null;
    return Card(
      color: isAvailable
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              '#${index.toString()}',
              style: theme.textTheme.headlineSmall,
            ),
            const Spacer(),
            Visibility(
              visible: isBorrowed,
              child: Row(
                children: [
                  const Icon(Icons.arrow_outward_rounded),
                  Text(
                    isBorrowed
                        ? DateFormat.yMMMd().format(itemInstance.borrowedAt!)
                        : '',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              child: Visibility(
                visible: itemInstance.incidences != null &&
                    itemInstance.incidences!.isNotEmpty,
                child: Chip(
                  backgroundColor: theme.colorScheme.errorContainer,
                  shape: const CircleBorder(),
                  label: Text(
                    '!${itemInstance.incidences!.length}',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
