import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late MostPopularAuthorsListBloc authorsListBloc;
  late MockGetMostPopularAuthorsUseCase useCase;

  setUp(() {
    useCase = MockGetMostPopularAuthorsUseCase();
    authorsListBloc = MostPopularAuthorsListBloc(allAuthorsUsecase: useCase);
  });

  final testJson = fixtureReader('most_popular_authors.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();

  test('initial state should be MostPopularAuthorsListLoading', () async {
    //assert
    expect(authorsListBloc.state, MostPopularAuthorsListEmpty());
  });

  group('getAllAuthorsEvent', () {
    blocTest<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
        'should emit [MostPopularAuthorsListLoading , MostPopularAuthorsListLoaded]',
        build: () {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));
          return authorsListBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularAuthorsEvent()),
        expect: () => [
              MostPopularAuthorsListLoading(),
              MostPopularAuthorsListLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));
          return authorsListBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularAuthorsEvent()),
        expect: () => [
              MostPopularAuthorsListLoading(),
              const MostPopularAuthorsListError(
                  FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
    blocTest<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return authorsListBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularAuthorsEvent()),
        expect: () => [
              MostPopularAuthorsListLoading(),
              const MostPopularAuthorsListError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
        'should emit [MostPopularAuthorsListLoading, MostPopularAuthorsListError] when data is unsuccessful',
        build: () {
          when(useCase.execute()).thenThrow('Something went wrong');
          return authorsListBloc;
        },
        act: (bloc) => bloc.add(GetMostPopularAuthorsEvent()),
        expect: () => [
              MostPopularAuthorsListLoading(),
              const MostPopularAuthorsListError('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
  });
}
