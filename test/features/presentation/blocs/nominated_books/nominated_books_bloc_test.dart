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

void main() {
  late NominatedBooksListProvider nominatedBooksListProvider;
  late MockGetNominatedBooksUseCase useCase;

  setUp(() {
    useCase = MockGetNominatedBooksUseCase();
    nominatedBooksListProvider = NominatedBooksListProvider(useCase: useCase);
  });

  final testJson = fixtureReader('nominated_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();

  test('initial state should be NominatedBooksListLoadingState', () async {
    //assert
    expect(nominatedBooksListProvider.state,
        const NominatedBooksListLoadingState());
  });

  group('getNominatedBooksListEvent', () {
    test(
        'should emit [NominatedBooksListLoadingState , NominatedBooksListLoadedState]',
        () async {
      when(useCase.execute())
          .thenAnswer((realInvocation) async => Right(testModel));

      nominatedBooksListProvider.getNominatedBooksListEvent();
      expect(nominatedBooksListProvider.state,
          equals(const NominatedBooksListLoadingState()));
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListLoadingState>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListLoadedState>());
      expect(
          (nominatedBooksListProvider.state as NominatedBooksListLoadedState)
              .nominatedBooks,
          equals(testModel));
    });

    test(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when occurred ServerFailure error',
        () async {
      when(useCase.execute()).thenAnswer((_) async => Left(ServerFailure()));

      nominatedBooksListProvider.getNominatedBooksListEvent();

      expect(nominatedBooksListProvider.state,
          equals(const NominatedBooksListLoadingState()));
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListLoadingState>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListErrorState>());
      expect(
          (nominatedBooksListProvider.state as NominatedBooksListErrorState)
              .error,
          equals(FailureMessageConstants.serverFailureMessage));
    });

    test(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when occurred ConnectionFailure error',
        () async {
      when(useCase.execute())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      nominatedBooksListProvider.getNominatedBooksListEvent();

      expect(nominatedBooksListProvider.state,
          equals(const NominatedBooksListLoadingState()));
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListLoadingState>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListErrorState>());
      expect(
          (nominatedBooksListProvider.state as NominatedBooksListErrorState)
              .error,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [NominatedBooksListLoadingState, NominatedBooksListErrorState] when data is unsuccessful',
        () async {
      when(useCase.execute()).thenThrow('Something went wrong');

      nominatedBooksListProvider.getNominatedBooksListEvent();

      // Assert again after the async operation
      expect(nominatedBooksListProvider.state,
          isA<NominatedBooksListErrorState>());
      expect(
          (nominatedBooksListProvider.state as NominatedBooksListErrorState)
              .error,
          equals('Something went wrong'));
    });
  });
}
