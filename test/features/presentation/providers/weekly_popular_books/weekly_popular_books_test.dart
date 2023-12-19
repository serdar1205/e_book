import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/providers/weekly_popular_books/weekly_popular_books_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late WeeklyPopularBooksProvider weeklyPopularBooksProvider;
  late MockGetWeeklyPopularBooksUseCase useCase;

  setUp(() {
    useCase = MockGetWeeklyPopularBooksUseCase();
    weeklyPopularBooksProvider = WeeklyPopularBooksProvider(useCase: useCase);
  });

  final testJson = fixtureReader('weekly_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => WeeklyPopularBooksModel.fromMap(e)).toList();

  test('initial state should be WeeklyPopularBooksLoading', () async {
    //assert
    expect(weeklyPopularBooksProvider.state, const WeeklyPopularBooksLoading());
  });

  group('getWeeklyPopularBooks event', () {
    test(
        'should emit [WeeklyPopularBooksLoading , WeeklyPopularBooksLoaded]',
         ()async {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));


          weeklyPopularBooksProvider.getWeeklyPopularBooks();

           expect(weeklyPopularBooksProvider.state, equals(WeeklyPopularBooksLoading()));
           expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksLoading>());
           // Wait for the async operation to complete
           await Future.delayed(Duration.zero);

           // Assert again after the async operation
           expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksLoaded>());
           expect(
           (weeklyPopularBooksProvider.state as WeeklyPopularBooksLoaded).weeklyPopularBooksEntity,
           equals(testModel));

        });

    test(
        'should emit [WeeklyPopularBooksLoading, WeeklyPopularBooksError] when occurred ServerFailure error',
            ()async {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));


              weeklyPopularBooksProvider.getWeeklyPopularBooks();

              expect(weeklyPopularBooksProvider.state, equals(WeeklyPopularBooksLoading()));
              expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksLoading>());
              // Wait for the async operation to complete
              await Future.delayed(Duration.zero);

              // Assert again after the async operation
              expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksError>());
              expect(
              (weeklyPopularBooksProvider.state as WeeklyPopularBooksError).error,
              equals(FailureMessageConstants.serverFailureMessage));

        });
    test(
        'should emit [WeeklyPopularBooksLoading, WeeklyPopularBooksError] when occurred ConnectionFailure error',
            ()async {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));

              weeklyPopularBooksProvider.getWeeklyPopularBooks();

              expect(weeklyPopularBooksProvider.state, equals(WeeklyPopularBooksLoading()));
              expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksLoading>());
              // Wait for the async operation to complete
              await Future.delayed(Duration.zero);

              // Assert again after the async operation
              expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksError>());
              expect(
              (weeklyPopularBooksProvider.state as WeeklyPopularBooksError).error,
              equals(FailureMessageConstants.connectionFailureMessage));
        });

    test(
        'should emit [ WeeklyPopularBooksError] when data is unsuccessful',
            ()async {
          when(useCase.execute()).thenThrow('Something went wrong');

          weeklyPopularBooksProvider.getWeeklyPopularBooks();


          // Assert again after the async operation
          expect(weeklyPopularBooksProvider.state, isA<WeeklyPopularBooksError>());
          expect(
              (weeklyPopularBooksProvider.state as WeeklyPopularBooksError).error,
              equals('Something went wrong'));

        });
  });
}
