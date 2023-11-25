import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/most_popular_books/most_popular_books_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late MostPopularBooksBloc mostPopularBooksBloc;
  late MockGetMostPopularBooksUseCase useCase;

  setUp(() {
    useCase = MockGetMostPopularBooksUseCase();
    mostPopularBooksBloc = MostPopularBooksBloc(useCase);
  });

  final testJson = fixtureReader('most_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularBooksModel.fromMap(e)).toList();

  test('initial state should be MostPopularBooksLoading', () async {
    //assert
    expect(mostPopularBooksBloc.state, const MostPopularBooksLoading());
  });

  group('getMostPopularBooks event', () {
    blocTest<MostPopularBooksBloc, MostPopularBooksState>(
        'should emit [MostPopularBooksLoading , MostPopularBooksLoaded]',
        build: () {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));
          return mostPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularBooks()),
        expect: () => [
              const MostPopularBooksLoading(),
              MostPopularBooksLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<MostPopularBooksBloc, MostPopularBooksState>(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));
          return mostPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularBooks()),
        expect: () => [
              const MostPopularBooksLoading(),
              const MostPopularBooksError(
                  FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
    blocTest<MostPopularBooksBloc, MostPopularBooksState>(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return mostPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularBooks()),
        expect: () => [
              const MostPopularBooksLoading(),
              const MostPopularBooksError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<MostPopularBooksBloc, MostPopularBooksState>(
        'should emit [MostPopularBooksLoading, MostPopularBooksError] when data is unsuccessful',
        build: () {
          when(useCase.execute()).thenThrow('Something went wrong');
          return mostPopularBooksBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularBooks()),
        expect: () => [
              const MostPopularBooksLoading(),
              const MostPopularBooksError('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
  });
}
