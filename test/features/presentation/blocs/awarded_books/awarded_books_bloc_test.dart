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
import 'package:bloc_test/bloc_test.dart';

void main() {
  late AwardedBooksBloc awardedBooksBloc;
  late MockGetAwardedBooksUseCase useCase;

  setUp(() {
    useCase = MockGetAwardedBooksUseCase();
    awardedBooksBloc = AwardedBooksBloc(useCase);
  });

  final testJson = fixtureReader('awarded_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();

  test('initial state should be BookDetailsLoading', () async {
    //assert
    expect(awardedBooksBloc.state, AwardedBooksLoading());
  });

  group('getBookDetailsById event', () {
    blocTest<AwardedBooksBloc, AwardedBooksState>(
        'should emit [AwardedBooksLoading , AwardedBooksLoaded]',
        build: () {
          when(useCase.execute())
              .thenAnswer((realInvocation) async => Right(testModel));
          return awardedBooksBloc;
        },
        act: (bloc) => bloc.add(GetAwardedBooksEvent()),
        expect: () => [
              AwardedBooksLoading(),
              AwardedBooksLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<AwardedBooksBloc, AwardedBooksState>(
        'should emit [AwardedBooksLoading, AwardedBooksError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ServerFailure()));
          return awardedBooksBloc;
        },
        act: (bloc) => bloc.add(GetAwardedBooksEvent()),
        expect: () => [
              AwardedBooksLoading(),
              const AwardedBooksError(FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
    blocTest<AwardedBooksBloc, AwardedBooksState>(
        'should emit [AwardedBooksLoading, AwardedBooksError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute())
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return awardedBooksBloc;
        },
        act: (bloc) => bloc.add(GetAwardedBooksEvent()),
        expect: () => [
              AwardedBooksLoading(),
              const AwardedBooksError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });

    blocTest<AwardedBooksBloc, AwardedBooksState>(
        'should emit [AwardedBooksLoading, AwardedBooksError] when data is unsuccessful',
        build: () {
          when(useCase.execute()).thenThrow('Something went wrong');
          return awardedBooksBloc;
        },
        act: (bloc) => bloc.add(GetAwardedBooksEvent()),
        expect: () => [
              AwardedBooksLoading(),
              const AwardedBooksError('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute());
        });
  });
}
