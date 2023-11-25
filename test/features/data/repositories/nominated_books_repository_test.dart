import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockNominatedBooksRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late NominatedBooksRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('nominated_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockNominatedBooksRemoteDataSource();
    repositoryImpl = NominatedBooksRepositoryImpl(
        networkInfo: networkInfo, nominatedBooksDataSource: remoteDataSource);
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
            'should return a list of NominatedBooksEntity when connected to the network',
            () async {
          //arrange
          when(remoteDataSource.getNominatedBooks())
              .thenAnswer((realInvocation) async => testModel);

          //act
          final result = await repositoryImpl.getNominatedBooks();
          //assert
          verify(remoteDataSource.getNominatedBooks());
          expect(result, Right(testModel));
        });

        test(
            'should return a ServerFailure when an exception occurs remote datasource is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.getNominatedBooks())
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getNominatedBooks();
          //assert
          verify(remoteDataSource.getNominatedBooks());
          expect(result, equals(Left(ServerFailure())));
        });

        runTestsOffline(() {
          test('should return ConnectionFailure when network disconnected',
              () async {
            when(remoteDataSource.getNominatedBooks())
                .thenThrow(ConnectionException());
            final result = await repositoryImpl.getNominatedBooks();
            expect(result, equals(Left(ConnectionFailure())));
          });
        });
      });
    });
  });
}
