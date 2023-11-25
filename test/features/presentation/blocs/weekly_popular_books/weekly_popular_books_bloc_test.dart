import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late WeeklyPopularBooksBloc weeklyPopularBooksBloc;
  late MockGetWeeklyPopularBooksUseCase useCase;

  setUp(() {
    useCase = MockGetWeeklyPopularBooksUseCase();
    weeklyPopularBooksBloc = WeeklyPopularBooksBloc(useCase: useCase);
  });

  final testJson = fixtureReader('weekly_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => WeeklyPopularBooksModel.fromMap(e)).toList();

  test('initial state should be WeeklyPopularBooksLoading', () async {
    //assert
    expect(weeklyPopularBooksBloc.state, const WeeklyPopularBooksLoading());
  });

  group('getWeeklyPopularBooks event', () {
    blocTest<WeeklyPopularBooksBloc, WeeklyPopularBooksState>(
        'should emit [WeeklyPopularBooksLoading , WeeklyPopularBooksLoaded]',
        build: () {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));
          return weeklyPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetWeeklyPopularBooksEvent()),
        expect: () => [
              const WeeklyPopularBooksLoading(),
              WeeklyPopularBooksLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<WeeklyPopularBooksBloc, WeeklyPopularBooksState>(
        'should emit [WeeklyPopularBooksLoading, WeeklyPopularBooksError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));
          return weeklyPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetWeeklyPopularBooksEvent()),
        expect: () => [
              const WeeklyPopularBooksLoading(),
              const WeeklyPopularBooksError(
                  FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
    blocTest<WeeklyPopularBooksBloc, WeeklyPopularBooksState>(
        'should emit [WeeklyPopularBooksLoading, WeeklyPopularBooksError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return weeklyPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetWeeklyPopularBooksEvent()),
        expect: () => [
              const WeeklyPopularBooksLoading(),
              const WeeklyPopularBooksError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<WeeklyPopularBooksBloc, WeeklyPopularBooksState>(
        'should emit [WeeklyPopularBooksLoading, WeeklyPopularBooksError] when data is unsuccessful',
        build: () {
          when(useCase.execute()).thenThrow('Something went wrong');
          return weeklyPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetWeeklyPopularBooksEvent()),
        expect: () => [
              const WeeklyPopularBooksLoading(),
              const WeeklyPopularBooksError('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
  });
}
