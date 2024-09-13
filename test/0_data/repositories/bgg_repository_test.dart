import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';

class MockBggDataSource extends Mock implements BggDataSource {}

void main() {
  group('BggRepository', () {
    late BggRepository bggRepository;
    late MockBggDataSource mockBggDataSource;

    setUp(() {
      mockBggDataSource = MockBggDataSource();
      bggRepository = BggRepository(bggDataSource: mockBggDataSource);
    });

    test('getItem should return Right with valid item', () async {
      // Arrange
      const itemModel = ItemModel(
        id: '123',
        title: 'title',
        imageUrl: 'imageUrl',
        description: 'description',
        minAge: 1,
        minPlayers: 1,
        maxPlayers: 1,
        playingTime: 1,
      );

      when(() => mockBggDataSource.getItem(id: itemModel.id))
          .thenAnswer((_) => Future.value(itemModel));

      final result = await bggRepository.getItem(itemModel.id);

      expect(result, equals(Right(bggRepository.modelToItem(itemModel))));
    });

    test('getItem should return Left with ServerFailure on exception',
        () async {
      when(() => mockBggDataSource.getItem(id: '123'))
          .thenThrow(Exception('whatever'));

      final result = await bggRepository.getItem('123');

      expect(result.isLeft, true);
      expect(result.left, isA<ServerFailure>());
    });

    test('modelToItem should return Item', () {
      // Arrange
      const itemModel = ItemModel(
        id: '123',
        title: 'title',
        imageUrl: 'imageUrl',
        description: 'description',
        minAge: 1,
        minPlayers: 1,
        maxPlayers: 1,
        playingTime: 1,
      );

      // Act
      final result = bggRepository.modelToItem(itemModel);

      // Assert
      expect(
          result,
          equals(Item(
            id: ItemId.fromUniqueString(itemModel.id),
            title: itemModel.title,
            imageUrl: itemModel.imageUrl,
            description: itemModel.description,
            minAge: itemModel.minAge,
            minPlayers: itemModel.minPlayers,
            maxPlayers: itemModel.maxPlayers,
            playingTime: itemModel.playingTime,
            instances: const [],
          )));
    });
  });
}
