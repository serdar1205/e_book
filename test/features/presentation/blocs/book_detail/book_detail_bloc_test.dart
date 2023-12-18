import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/book_detail_model.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late BookDetailsProvider bookDetailsProvider;
  late MockGetBookDetailsUseCase useCase;

  setUp(() {
    useCase = MockGetBookDetailsUseCase();
    bookDetailsProvider = BookDetailsProvider(useCase);
  });

  final testJson = fixtureReader("book_detail.json");
  final testModel = BookDetailModel.fromMap(json.decode(testJson));
  final bookId = testModel.bookId;

  test('initial state should be BookDetailsLoading', () async {
    //assert
    expect(bookDetailsProvider.state, BookDetailsLoading());
  });

  group('getBookDetailsById event', () {
    test('should emit [BookDetailsLoading , BookDetailsLoaded]', () async {
      when(useCase.execute(any)).thenAnswer((_) async => Right(testModel));

      bookDetailsProvider.getBookDetailsById(bookId!);

      expect(bookDetailsProvider.state, equals(BookDetailsLoading()));
      expect(bookDetailsProvider.state, isA<BookDetailsLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(bookDetailsProvider.state, isA<BookDetailsLoaded>());
      expect((bookDetailsProvider.state as BookDetailsLoaded).bookDetailEntity,
          equals(testModel));
    });

    test(
        'should emit [BookDetailsLoading, BookDetailsError] when occurred ServerFailure error',
        () async {
      when(useCase.execute(any)).thenAnswer((_) async => Left(ServerFailure()));

      bookDetailsProvider.getBookDetailsById(bookId!);

      expect(bookDetailsProvider.state, equals(BookDetailsLoading()));
      expect(bookDetailsProvider.state, isA<BookDetailsLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(bookDetailsProvider.state, isA<BookDetailsError>());
      expect((bookDetailsProvider.state as BookDetailsError).error,
          equals(FailureMessageConstants.serverFailureMessage));
    });

    test(
        'should emit [BookDetailsLoading, BookDetailsError] when occurred ConnectionFailure error',
        () async {
          when(useCase.execute(any))
              .thenAnswer((_) async => Left(ConnectionFailure()));

      bookDetailsProvider.getBookDetailsById(bookId!);

      expect(bookDetailsProvider.state, equals(BookDetailsLoading()));
      expect(bookDetailsProvider.state, isA<BookDetailsLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(bookDetailsProvider.state, isA<BookDetailsError>());
      expect((bookDetailsProvider.state as BookDetailsError).error,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [BookDetailsError] when data is unsuccessful',
        () async {
      when(useCase.execute(any)).thenThrow('Something went wrong');

      bookDetailsProvider.getBookDetailsById(bookId!);


      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(bookDetailsProvider.state, isA<BookDetailsError>());
      expect((bookDetailsProvider.state as BookDetailsError).error,
          equals('Something went wrong'));
    });
  });
}
