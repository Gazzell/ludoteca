import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/data_sources/interfaces/collection_local_source_interface.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collection/collection.dart';

class MockCollectionLocalSource extends Mock
    implements CollectionLocalSourceInterface {}

void main() {
  late CollectionRepositoryLocal repository;
  late MockCollectionLocalSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCollectionLocalSource();
    repository =
        CollectionRepositoryLocal(localDataSource: mockLocalDataSource);
  });

  group('readItemIds', () {
    test(
        'should return a list of ItemIds when localDataSource returns a list of unique strings',
        () async {
      final itemIds = ['id1', 'id2', 'id3'];
      when(() => mockLocalDataSource.readItemIds())
          .thenAnswer((_) async => itemIds);

      final result = await repository.readItemIds();

      expect(result.isRight, true);
      expect(
        result.right,
        equals(itemIds.map((id) => ItemId.fromUniqueString(id)).toList()),
      );
    });

    test(
        'should return a CacheFailure when localDataSource throws a CacheException',
        () async {
      when(() => mockLocalDataSource.readItemIds()).thenThrow(CacheException());

      final result = await repository.readItemIds();

      expect(result.isLeft, true);
      expect(
        result.left,
        isA<CacheFailure>(),
      );
    });

    test(
        'should return a ServerFailure when localDataSource throws an Exception',
        () async {
      when(() => mockLocalDataSource.readItemIds()).thenThrow(Exception());

      final result = await repository.readItemIds();

      expect(result, equals(Left(ServerFailure(stackTrace: 'Exception'))));
    });
  });

  group('readItems', () {
    test(
        'should return an List of Item when localDataSource returns an List of ItemModel',
        () async {
      const itemModelList = [
        ItemModel(
          id: 'id1',
          title: 'title1',
          instances: [],
        ),
        ItemModel(
          id: 'id2',
          title: 'title2',
          instances: [],
        ),
        ItemModel(
          id: 'id3',
          title: 'title3',
          instances: [],
        ),
      ];

      when(() => mockLocalDataSource.readItemIds())
          .thenAnswer((_) async => ['id1', 'id2', 'id3']);

      when(() => mockLocalDataSource.readItems(['id1', 'id2', 'id3']))
          .thenAnswer((_) async => itemModelList);

      final result = await repository.readItems();

      expect(result.isRight, true);
      expect(
        result.right,
        equals(itemModelList
            .map(
              (itemModel) => Item(
                  id: ItemId.fromUniqueString(itemModel.id),
                  title: itemModel.title,
                  instances: itemModel.instances),
            )
            .toList()),
      );
    });

    test(
        'should return a CacheFailure when localDataSource throws a CacheException',
        () async {
      when(() => mockLocalDataSource.readItemIds())
          .thenAnswer((_) async => ['id1', 'id2', 'id3']);

      when(() => mockLocalDataSource.readItems(['id1', 'id2', 'id3']))
          .thenThrow(CacheException());

      final result = await repository.readItems();

      expect(result.isLeft, true);
      expect(
        result.left,
        isA<CacheFailure>(),
      );
    });

    test(
        'should return a ServerFailure when localDataSource throws an Exception',
        () async {
      when(() => mockLocalDataSource.readItemIds())
          .thenAnswer((_) async => ['id1', 'id2', 'id3']);
      when(() => mockLocalDataSource.readItems(['id1', 'id2', 'id3']))
          .thenThrow(Exception());

      final result = await repository.readItems();

      expect(result, equals(Left(ServerFailure(stackTrace: 'Exception'))));
    });
  });

  group('readItem', () {
    test('should return an Item when localDataSource returns an ItemModel',
        () async {
      const itemModel = ItemModel(
        id: 'id1',
        title: 'title1',
        instances: [],
      );

      when(() => mockLocalDataSource.readItem(itemId: 'id1'))
          .thenAnswer((_) async => itemModel);

      final result = await repository.readItem(ItemId.fromUniqueString('id1'));

      expect(result.isRight, true);
      expect(
        result.right,
        equals(
          Item(
            id: ItemId.fromUniqueString(itemModel.id),
            title: itemModel.title,
            instances: itemModel.instances,
          ),
        ),
      );
    });

    test(
        'should return a CacheFailure when localDataSource throws a CacheException',
        () async {
      when(() => mockLocalDataSource.readItem(itemId: 'id1'))
          .thenThrow(CacheException());

      final result = await repository.readItem(ItemId.fromUniqueString('id1'));

      expect(result.isLeft, true);
      expect(
        result.left,
        isA<CacheFailure>(),
      );
    });

    test(
        'should return a ServerFailure when localDataSource throws an Exception',
        () async {
      when(() => mockLocalDataSource.readItem(itemId: 'id1'))
          .thenThrow(Exception());

      final result = await repository.readItem(ItemId.fromUniqueString('id1'));

      expect(result, equals(Left(ServerFailure(stackTrace: 'Exception'))));
    });
  });

  group('addItem', () {
    test('should return the Item when sucesfully added an it', () async {
      final itemToAdd = Item(
        id: ItemId.fromUniqueString('id1'),
        title: 'title1',
        instances: const [],
      );

      when(() => mockLocalDataSource.addItem(
              itemModel: ItemModel.fromItem(itemToAdd)))
          .thenAnswer((_) async => true);

      final result = await repository.addItem(itemToAdd);

      expect(result, equals(Right(itemToAdd)));
      verify(
        () => mockLocalDataSource.addItem(
          itemModel: ItemModel.fromItem(itemToAdd),
        ),
      ).called(1);
    });

    test(
        'should return a CacheFailure when localDataSource throws a CacheException',
        () async {
      final itemToAdd = Item(
        id: ItemId.fromUniqueString('id1'),
        title: 'title1',
        instances: const [],
      );

      when(() => mockLocalDataSource.addItem(
              itemModel: ItemModel.fromItem(itemToAdd)))
          .thenThrow(CacheException());

      final result = await repository.addItem(itemToAdd);

      expect(result.isLeft, true);
      expect(
        result.left,
        isA<CacheFailure>(),
      );
    });

    test(
        'should return a ServerFailure when localDataSource throws an Exception',
        () async {
      final itemToAdd = Item(
        id: ItemId.fromUniqueString('id1'),
        title: 'title1',
        instances: const [],
      );
      when(() => mockLocalDataSource.addItem(
          itemModel: ItemModel.fromItem(itemToAdd))).thenThrow(Exception());

      final result = await repository.addItem(itemToAdd);

      expect(result, equals(Left(ServerFailure(stackTrace: 'Exception'))));
    });
  });

  group('itemModelListToItemList', () {
    test('should return a List of Item when given a List of ItemModel', () {
      const itemModelList = [
        ItemModel(
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
        ),
        ItemModel(
          id: 'id2',
          title: 'title2',
          instances: [],
          bggId: 'bggId',
          imageUrl: 'imageUrl',
          thumbnailUrl: 'thumbnailUrl',
          description: 'description',
          minAge: 1,
          minPlayers: 1,
          maxPlayers: 1,
          playingTime: 1,
          author: 'author2',
          publisher: 'publisher2',
          publishYear: 2,
          complexity: 2.0,
          rating: 2.0,
        ),
      ];

      final result = repository.itemModelListToItemList(itemModelList);
      expect(result, isA<List<Item>>());
      result.forEachIndexed(
        (index, item) => expect(
          item,
          equals(
            Item(
              id: ItemId.fromUniqueString(itemModelList[index].id),
              title: itemModelList[index].title,
              instances: itemModelList[index].instances,
              bggId: itemModelList[index].bggId,
              imageUrl: itemModelList[index].imageUrl,
              thumbnailUrl: itemModelList[index].thumbnailUrl,
              description: itemModelList[index].description,
              minAge: itemModelList[index].minAge,
              minPlayers: itemModelList[index].minPlayers,
              maxPlayers: itemModelList[index].maxPlayers,
              playingTime: itemModelList[index].playingTime,
              author: itemModelList[index].author,
              publisher: itemModelList[index].publisher,
              publishYear: itemModelList[index].publishYear,
              complexity: itemModelList[index].complexity,
              rating: itemModelList[index].rating,
            ),
          ),
        ),
      );
    });
  });
}
