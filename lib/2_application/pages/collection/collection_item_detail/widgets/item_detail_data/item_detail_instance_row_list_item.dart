import 'package:flutter/widgets.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

class ItemDetailListInstanceListItem extends StatelessWidget {
  final ItemInstance itemInstance;
  const ItemDetailListInstanceListItem({super.key, required this.itemInstance});

  @override
  Widget build(BuildContext context) {
    return Text(itemInstance.id.value);
  }
}
