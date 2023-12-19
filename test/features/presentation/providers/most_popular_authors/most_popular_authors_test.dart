import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/providers/most_popular_authors_list/most_popular_authors_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MostPopularAuthorsProvider authorsListProvider;
  late MockGetMostPopularAuthorsUseCase useCase;

  setUp(() {
    useCase = MockGetMostPopularAuthorsUseCase();
    authorsListProvider =
        MostPopularAuthorsProvider(allAuthorsUsecase: useCase);
  });

  final testJson = fixtureReader('most_popular_authors.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();

  test('initial state should be MostPopularAuthorsListLoading', () async {
    //assert
    expect(authorsListProvider.state, MostPopularAuthorsListLoading());
  });

  group('getAllAuthors', () {
    test(
        'should emit [MostPopularAuthorsListLoading , MostPopularAuthorsListLoaded]',
        () async {
      when(useCase.execute())
          .thenAnswer((realInvocation) async => Right(testModel));

      authorsListProvider.getAllAuthorsEvent();

      expect(
          authorsListProvider.state, equals(MostPopularAuthorsListLoading()));
      expect(authorsListProvider.state, isA<MostPopularAuthorsListLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorsListProvider.state, isA<MostPopularAuthorsListLoaded>());
      expect(
          (authorsListProvider.state as MostPopularAuthorsListLoaded).authors,
          equals(testModel));
    });

    test(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when occurred ServerFailure error',
        () async {
      when(useCase.execute()).thenAnswer((_) async => Left(ServerFailure()));

      authorsListProvider.getAllAuthorsEvent();

      expect(
          authorsListProvider.state, equals(MostPopularAuthorsListLoading()));
      expect(authorsListProvider.state, isA<MostPopularAuthorsListLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorsListProvider.state, isA<MostPopularAuthorsListError>());
      expect((authorsListProvider.state as MostPopularAuthorsListError).message,
          equals(FailureMessageConstants.serverFailureMessage));
    });

    test(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when occurred ConnectionFailure error',
        () async {
      when(useCase.execute())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      authorsListProvider.getAllAuthorsEvent();

      expect(
          authorsListProvider.state, equals(MostPopularAuthorsListLoading()));
      expect(authorsListProvider.state, isA<MostPopularAuthorsListLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorsListProvider.state, isA<MostPopularAuthorsListError>());
      expect((authorsListProvider.state as MostPopularAuthorsListError).message,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when data is unsuccessful',
        () async {
      when(useCase.execute()).thenThrow('Something went wrong');

      authorsListProvider.getAllAuthorsEvent();

      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorsListProvider.state, isA<MostPopularAuthorsListError>());
      expect((authorsListProvider.state as MostPopularAuthorsListError).message,
          equals('Something went wrong'));
    });
  });
}
