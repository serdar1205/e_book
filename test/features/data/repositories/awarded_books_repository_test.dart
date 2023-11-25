import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/awarded_books_model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAwardedBooksRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late AwardedBooksRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('awarded_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockAwardedBooksRemoteDataSource();
    repositoryImpl = AwardedBooksRepositoryImpl(
        networkInfo: networkInfo, remoteDataSource: remoteDataSource);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('RemoteDataSource', () {
    group('getAwardedBooks', () {
      runTestsOnline(() {
        test(
            'should return a list of AwardedBooksEntity when connected to the network',
            () async {
          //arrange
          when(remoteDataSource.getAwardedBooks())
              .thenAnswer((realInvocation) async => testModel);

          //act
          final result = await repositoryImpl.getAwardedBooks();
          //assert
          verify(remoteDataSource.getAwardedBooks());
          expect(result, Right(testModel));
        });

        test(
            'should return a ServerFailure when an exception occurs remote datasource is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.getAwardedBooks()).thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getAwardedBooks();
          //assert
          verify(remoteDataSource.getAwardedBooks());
          expect(result, equals(Left(ServerFailure())));
        });

        runTestsOffline(() {
          test('should return ConnectionFailure when network disconnected',
              () async {
            when(remoteDataSource.getAwardedBooks())
                .thenThrow(ConnectionException());
            final result = await repositoryImpl.getAwardedBooks();
            expect(result, equals(Left(ConnectionFailure())));
          });
        });
      });
    });
  });
}
