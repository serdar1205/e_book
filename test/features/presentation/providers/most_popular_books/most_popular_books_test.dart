import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/providers/most_popular_books/most_popular_books_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MostPopularBooksProvider mostPopularBooksProvider;
  late MockGetMostPopularBooksUseCase useCase;

  setUp(() {
    useCase = MockGetMostPopularBooksUseCase();
    mostPopularBooksProvider = MostPopularBooksProvider(useCase);
  });

  final testJson = fixtureReader('most_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularBooksModel.fromMap(e)).toList();

  test('initial state should be MostPopularBooksLoading', () async {
    //assert
    expect(mostPopularBooksProvider.state, const MostPopularBooksLoading());
  });

  group('getMostPopularBooks event', () {
    test('should emit [MostPopularBooksLoading , MostPopularBooksLoaded]',
        () async {
      when(useCase.execute())
          .thenAnswer((realInvocation) async => Right(testModel));

      mostPopularBooksProvider.getMostPopularBooks();

      expect(mostPopularBooksProvider.state, equals(MostPopularBooksLoading()));
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksLoaded>());
      expect(
          (mostPopularBooksProvider.state as MostPopularBooksLoaded)
              .mostPopularBooksEntity,
          equals(testModel));
    });

    test(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when occurred ServerFailure error',
        () async {
      when(useCase.execute()).thenAnswer((_) async => Left(ServerFailure()));

      mostPopularBooksProvider.getMostPopularBooks();

      expect(mostPopularBooksProvider.state,
          equals(const MostPopularBooksLoading()));
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksError>());
      expect((mostPopularBooksProvider.state as MostPopularBooksError).error,
          equals(FailureMessageConstants.serverFailureMessage));
    });
    test(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when occurred ConnectionFailure error',
        () async {
      when(useCase.execute())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      mostPopularBooksProvider.getMostPopularBooks();

      expect(mostPopularBooksProvider.state,
          equals(const MostPopularBooksLoading()));
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksError>());
      expect((mostPopularBooksProvider.state as MostPopularBooksError).error,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when data is unsuccessful',
        () async {
      when(useCase.execute()).thenThrow('Something went wrong');

      mostPopularBooksProvider.getMostPopularBooks();


      // Assert again after the async operation
      expect(mostPopularBooksProvider.state, isA<MostPopularBooksError>());
      expect((mostPopularBooksProvider.state as MostPopularBooksError).error,
          equals('Something went wrong'));
    });
  });
}
