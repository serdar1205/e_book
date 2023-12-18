import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late AwardedBooksProvider awardedBooksProvider;
  late MockGetAwardedBooksUseCase useCase;

  setUp(() {
    useCase = MockGetAwardedBooksUseCase();
    awardedBooksProvider = AwardedBooksProvider(useCase);
  });

  final testJson = fixtureReader('awarded_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();

  test('initial state should be BookDetailsLoading', () async {
    //assert
    expect(awardedBooksProvider.state, AwardedBooksLoading());
  });

  group('getAwardedBooks event', () {
    test('should emit [AwardedBooksLoading , AwardedBooksLoaded]', () async {
      when(useCase.execute()).thenAnswer((_) async => Right(testModel));

      awardedBooksProvider.getAwardedBooks();

      expect(awardedBooksProvider.state, equals(AwardedBooksLoading()));
      expect(awardedBooksProvider.state, isA<AwardedBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(awardedBooksProvider.state, isA<AwardedBooksLoaded>());
      expect(
          (awardedBooksProvider.state as AwardedBooksLoaded).awardedBooksEntity,
          equals(testModel));
    });

    test(
        'should emit [AwardedBooksLoading, AwardedBooksError] when occurred ServerFailure error',
        () async {
      when(useCase.execute()).thenAnswer((_) async => Left(ServerFailure()));

      awardedBooksProvider.getAwardedBooks();

      expect(awardedBooksProvider.state, equals(AwardedBooksLoading()));
      expect(awardedBooksProvider.state, isA<AwardedBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(awardedBooksProvider.state, isA<AwardedBooksError>());
      expect((awardedBooksProvider.state as AwardedBooksError).error,
          equals(FailureMessageConstants.serverFailureMessage));
    });

    test(
        'should emit [AwardedBooksLoading, AwardedBooksError] when occurred ConnectionFailure error',
        () async {
      when(useCase.execute())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      awardedBooksProvider.getAwardedBooks();

      expect(awardedBooksProvider.state, equals(AwardedBooksLoading()));
      expect(awardedBooksProvider.state, isA<AwardedBooksLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(awardedBooksProvider.state, isA<AwardedBooksError>());
      expect((awardedBooksProvider.state as AwardedBooksError).error,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [AwardedBooksLoading, AwardedBooksError] when data is unsuccessful',
        () async {
      when(useCase.execute()).thenThrow('Something went wrong');

      awardedBooksProvider.getAwardedBooks();

      // Assert again after the async operation
      expect(awardedBooksProvider.state, isA<AwardedBooksError>());
      expect((awardedBooksProvider.state as AwardedBooksError).error,
          equals('Something went wrong'));
    });
  });
}
