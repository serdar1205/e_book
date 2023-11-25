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
  late MockMostPopularAuthorsRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late MostPopularAuthorsRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('most_popular_authors.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockMostPopularAuthorsRemoteDataSource();
    repositoryImpl = MostPopularAuthorsRepositoryImpl(
        networkInfo: networkInfo,
        mostPopularAuthorsRemoteDataSource: remoteDataSource);
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
            'should return a list of MostPopularAuthorsEntity when connected to the network',
            () async {
          //arrange
          when(remoteDataSource.getPopularAuthors())
              .thenAnswer((realInvocation) async => testModel);

          //act
          final result = await repositoryImpl.getMostPopularAuthors();
          //assert
          verify(remoteDataSource.getPopularAuthors());
          expect(result, Right(testModel));
        });

        test(
            'should return a ServerFailure when an exception occurs remote datasource is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.getPopularAuthors())
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getMostPopularAuthors();
          //assert
          verify(remoteDataSource.getPopularAuthors());
          expect(result, equals(Left(ServerFailure())));
        });

        runTestsOffline(() {
          test('should return ConnectionFailure when network disconnected',
              () async {
            when(remoteDataSource.getPopularAuthors())
                .thenThrow(ConnectionException());
            final result = await repositoryImpl.getMostPopularAuthors();
            expect(result, equals(Left(ConnectionFailure())));
          });
        });
      });
    });
  });
}
