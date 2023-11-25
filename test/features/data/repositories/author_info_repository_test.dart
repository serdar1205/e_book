import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAuthorInfoRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late AuthorInfoRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('author_info.json');
  final testModel = AuthorInfoModel.fromMap(json.decode(testJson));
  final authorId = testModel.authorId;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockAuthorInfoRemoteDataSource();
    repositoryImpl = AuthorInfoRepositoryImpl(
        networkInfo: networkInfo, authorRemoteDataSource: remoteDataSource);
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
    group('getAuthorInfo', () {
      runTestsOnline(() {
        test(
            'should return AuthorInfo model when getAuthorInfo call to remote datasource is success',
            () async {
          //arrange
          when(remoteDataSource.getAuthorInfo(any))
              .thenAnswer((realInvocation) async => testModel);

          //act
          final result = await repositoryImpl.getAuthorInfo(authorId!);
          //assert
          verify(remoteDataSource.getAuthorInfo(authorId));
          expect(result, Right(testModel));
        });

        test(
            'should return ServerFailure when getAuthorInfo  call to remote datasource is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.getAuthorInfo(any))
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getAuthorInfo(authorId!);
          //assert
          verify(remoteDataSource.getAuthorInfo(authorId));
          expect(result, equals(Left(ServerFailure())));
        });

        runTestsOffline(() {
          test('should return ConnectionFailure when network disconnected',
              () async {
            when(remoteDataSource.getAuthorInfo(any))
                .thenThrow(ConnectionException());
            final result = await repositoryImpl.getAuthorInfo(authorId!);
            expect(result, equals(Left(ConnectionFailure())));
          });
        });
      });
    });
  });
}
