import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late AuthorInfoProvider authorInfoProvider;
  late MockGetAuthorInfoUseCase useCase;

  setUp(() {
    useCase = MockGetAuthorInfoUseCase();
    authorInfoProvider = AuthorInfoProvider(useCase);
  });

  final testJson = fixtureReader("author_info.json");
  final testModel = AuthorInfoModel.fromMap(json.decode(testJson));
  final authorId = testModel.authorId;

  test('initial state should be AuthorInfoLoading', () async {
    //assert
    expect(authorInfoProvider.state, AuthorInfoLoading());
  });

  group('getAuthorInfoById event', () {
    test('should emit [AuthorInfoLoading , AuthorInfoLoaded]', () async {
      // Arrange
      when(useCase.execute(any)).thenAnswer((_) async => Right(testModel));

      // Act
      authorInfoProvider
          .getAuthorInfoById(authorId!); // Assuming 123 is the authorId

      // Assert
      expect(authorInfoProvider.state, equals(AuthorInfoLoading()));
      expect(authorInfoProvider.state, isA<AuthorInfoLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorInfoProvider.state, isA<AuthorInfoLoaded>());
      expect((authorInfoProvider.state as AuthorInfoLoaded).authorInfoEntity,
          equals(testModel));
    });

    test(
        'should emit [AuthorInfoLoading, AuthorInfoError] when occurred ServerFailure error',
        () async {
      // Arrange
      when(useCase.execute(any)).thenAnswer((_) async => Left(ServerFailure()));

      // Act
      authorInfoProvider
          .getAuthorInfoById(authorId!); // Assuming 123 is the authorId

      // Assert
      expect(authorInfoProvider.state, equals(AuthorInfoLoading()));
      expect(authorInfoProvider.state, isA<AuthorInfoLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorInfoProvider.state, isA<AuthorInfoError>());
      expect((authorInfoProvider.state as AuthorInfoError).error,
          equals(FailureMessageConstants.serverFailureMessage));
    });

    test(
        'should emit [AuthorInfoLoading, AuthorInfoError] when occurred ConnectionFailure error',
        () async {
      // Arrange
      when(useCase.execute(any))
          .thenAnswer((_) async => Left(ConnectionFailure()));

      // Act
      authorInfoProvider
          .getAuthorInfoById(authorId!); // Assuming 123 is the authorId

      // Assert
      expect(authorInfoProvider.state, equals(AuthorInfoLoading()));
      expect(authorInfoProvider.state, isA<AuthorInfoLoading>());
      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorInfoProvider.state, isA<AuthorInfoError>());
      expect((authorInfoProvider.state as AuthorInfoError).error,
          equals(FailureMessageConstants.connectionFailureMessage));
    });

    test(
        'should emit [AuthorInfoError] when data is unsuccessful',
        () async {
      // Arrange
      when(useCase.execute(any)).thenThrow('Something went wrong');

      // Act
      authorInfoProvider
          .getAuthorInfoById(authorId!); // Assuming 123 is the authorId

      await Future.delayed(Duration.zero);

      // Assert again after the async operation
      expect(authorInfoProvider.state, isA<AuthorInfoError>());
      expect((authorInfoProvider.state as AuthorInfoError).error,
          equals('Something went wrong'));
    });

  });
}
