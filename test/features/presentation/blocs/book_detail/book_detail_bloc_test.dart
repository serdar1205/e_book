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
import 'package:bloc_test/bloc_test.dart';

void main() {
  late BookDetailsBloc bookDetailsBloc;
  late MockGetBookDetailsUseCase useCase;

  setUp(() {
    useCase = MockGetBookDetailsUseCase();
    bookDetailsBloc = BookDetailsBloc(useCase);
  });

  final testJson = fixtureReader("book_detail.json");
  final testModel = BookDetailModel.fromMap(json.decode(testJson));
  final bookId = testModel.bookId;

  test('initial state should be BookDetailsLoading', () async {
    //assert
    expect(bookDetailsBloc.state, BookDetailsLoading());
  });

  group('getBookDetailsById event', () {
    blocTest<BookDetailsBloc, BookDetailsState>(
        'should emit [BookDetailsLoading , BookDetailsLoaded]',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((realInvocation) async => Right(testModel));
          return bookDetailsBloc;
        },
        act: (bloc) => bloc.add(GetBookDetails(bookId!)),
        expect: () => [
              BookDetailsLoading(),
              BookDetailsLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute(bookId));
        });

    blocTest<BookDetailsBloc, BookDetailsState>(
        'should emit [BookDetailsLoading, BookDetailsError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bookDetailsBloc;
        },
        act: (bloc) => bloc.add(GetBookDetails(bookId!)),
        expect: () => [
              BookDetailsLoading(),
              BookDetailsError(FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute(bookId));
        });
    blocTest<BookDetailsBloc, BookDetailsState>(
        'should emit [BookDetailsLoading, BookDetailsError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return bookDetailsBloc;
        },
        act: (bloc) => bloc.add(GetBookDetails(bookId!)),
        expect: () => [
              BookDetailsLoading(),
              BookDetailsError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute(bookId));
        });

    blocTest<BookDetailsBloc, BookDetailsState>(
        'should emit [BookDetailsLoading, BookDetailsError] when data is unsuccessful',
        build: () {
          when(useCase.execute(any)).thenThrow('Something went wrong');
          return bookDetailsBloc;
        },
        act: (bloc) => bloc.add(GetBookDetails(bookId!)),
        expect: () => [
              BookDetailsLoading(),
              BookDetailsError('Something went wrong'),
            ],
        verify: (bloc) {
          verify(useCase.execute(bookId));
        });
  });
}
