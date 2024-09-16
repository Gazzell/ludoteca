import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

void main() {
  group('Item', () {
    test('should create empty item', () {
      final item = Item.empty();

      expect(item.id.value, isNot(''));
      expect(item.title, '');
      expect(item.instances, []);
    });

    test('should create an Item from an ItemModel', () {
      const itemModel = ItemModel(
        id: 'id1',
        title: 'title1',
        instances: [],
        bggId: 'bggId',
        imageUrl: 'imageUrl',
        thumbnailUrl: 'thumbnailUrl',
        description: 'description',
        minAge: 1,
        minPlayers: 1,
        maxPlayers: 1,
        playingTime: 1,
        author: 'author',
        publisher: 'publisher',
        publishYear: 1,
        complexity: 1.0,
        rating: 1.0,
      );

      expect(
        Item.fromItemModel(itemModel),
        equals(
          Item(
            id: ItemId.fromUniqueString(itemModel.id),
            title: itemModel.title,
            instances: itemModel.instances
                .map((id) => ItemInstanceId.fromUniqueString(id))
                .toList(),
            bggId: itemModel.bggId,
            imageUrl: itemModel.imageUrl,
            thumbnailUrl: itemModel.thumbnailUrl,
            description: itemModel.description,
            minAge: itemModel.minAge,
            minPlayers: itemModel.minPlayers,
            maxPlayers: itemModel.maxPlayers,
            playingTime: itemModel.playingTime,
            author: itemModel.author,
            publisher: itemModel.publisher,
            publishYear: itemModel.publishYear,
            complexity: itemModel.complexity,
            rating: itemModel.rating,
          ),
        ),
      );
    });
  });
}
