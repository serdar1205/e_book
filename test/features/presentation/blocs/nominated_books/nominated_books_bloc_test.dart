import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/nominated_books/nominated_books_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late NominatedBooksListBloc nominatedBooksListBloc;
  late MockGetNominatedBooksUseCase useCase;

  setUp(() {
    useCase = MockGetNominatedBooksUseCase();
    nominatedBooksListBloc = NominatedBooksListBloc(useCase: useCase);
  });

  final testJson = fixtureReader('nominated_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();

  test('initial state should be NominatedBooksListLoadingState', () async {
    //assert
    expect(
        nominatedBooksListBloc.state, const NominatedBooksListLoadingState());
  });

  group('getNominatedBooksListEvent', () {
    blocTest<NominatedBooksListBloc, NominatedBooksListState>(
        'should emit [NominatedBooksListLoadingState , NominatedBooksListLoadedState]',
        build: () {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));
          return nominatedBooksListBloc;
        },
        act: (bloc) => bloc.add(GetNominatedBooksListEvent()),
        expect: () => [
              const NominatedBooksListLoadingState(),
              NominatedBooksListLoadedState(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<NominatedBooksListBloc, NominatedBooksListState>(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when occurred ServerFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));
          return nominatedBooksListBloc;
        },
        act: (bloc) => bloc.add(GetNominatedBooksListEvent()),
        expect: () => [
              const NominatedBooksListLoadingState(),
              const NominatedBooksListErrorState(
                  FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
    blocTest<NominatedBooksListBloc, NominatedBooksListState>(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return nominatedBooksListBloc;
        },
        act: (bloc) => bloc.add(GetNominatedBooksListEvent()),
        expect: () => [
              const NominatedBooksListLoadingState(),
              const NominatedBooksListErrorState(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<NominatedBooksListBloc, NominatedBooksListState>(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when data is unsuccessful',
        build: () {
          when(useCase.execute()).thenThrow('Something went wrong');
          return nominatedBooksListBloc;
        },
        act: (bloc) => bloc.add(GetNominatedBooksListEvent()),
        expect: () => [
              const NominatedBooksListLoadingState(),
              const NominatedBooksListErrorState('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
  });
}
