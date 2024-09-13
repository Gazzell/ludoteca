import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_bgg_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class BggRepositoryMock extends Mock implements BggRepository {}

void main() {
  final fakeItem = Item(
    id: ItemId.fromUniqueString('0'),
    title: 'title',
    instances: const [],
    bggId: '122',
    imageUrl: '',
    thumbnailUrl: '',
    description: 'longDescription',
    minPlayers: 1,
    maxPlayers: 4,
    playingTime: 130,
    author: 'author',
    publisher: 'publisher',
    publishYear: 2000,
    complexity: 3.2,
    rating: 6.5,
  );

  group('GetBggItemDetail use case', () {
    group('should return Right', () {
      test('with an ItemDetail', () async {
        final mockBggRepository = BggRepositoryMock();
        when(() => mockBggRepository.getItem('0')).thenAnswer(
          (_) async => Right(fakeItem),
        );

        final getItemDetailUseCase = GetBggItem(
          bggRepository: mockBggRepository,
        );

        final result =
            await getItemDetailUseCase(GetBggItemParams(itemId: '0'));

        expect(result, Right<Failure, Item>(fakeItem));

        verify(() => mockBggRepository.getItem('0')).called(1);
      });
    });

    group('should return left', () {
      test('with a ServerFailure if threw an exception', () async {
        final mockBggRepository = BggRepositoryMock();
        when(() => mockBggRepository.getItem('0')).thenThrow(
          Exception('something went wrong'),
        );

        final getItemDetailUseCase =
            GetBggItem(bggRepository: mockBggRepository);

        final result =
            await getItemDetailUseCase(GetBggItemParams(itemId: '0'));

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: something went wrong'),
        );

        verify(() => mockBggRepository.getItem('0')).called(1);
      });
    });
  });
}
