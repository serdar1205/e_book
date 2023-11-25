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
  late MockBookDetailsRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late BookDetailRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('book_detail.json');
  final testModel = BookDetailModel.fromMap(json.decode(testJson));
  final bookId = testModel.bookId;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockBookDetailsRemoteDataSource();
    repositoryImpl = BookDetailRepositoryImpl(
        networkInfo: networkInfo,
        bookDetailsRemoteDataSource: remoteDataSource);
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
    group('getBookDetails', () {
      runTestsOnline(() {
        test(
            'should return BookDetail model when getBookDetails call to remote datasource is success',
            () async {
          //arrange
          when(remoteDataSource.getBookDetails(any))
              .thenAnswer((realInvocation) async => testModel);

          //act
          final result = await repositoryImpl.getBookDetails(bookId!);
          //assert
          verify(remoteDataSource.getBookDetails(bookId));
          expect(result, Right(testModel));
        });

        test(
            'should return ServerFailure when getBookDetails  call to remote datasource is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.getBookDetails(any))
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getBookDetails(bookId!);
          //assert
          verify(remoteDataSource.getBookDetails(bookId));
          expect(result, equals(Left(ServerFailure())));
        });

        runTestsOffline(() {
          test('should return ConnectionFailure when network disconnected',
              () async {
            when(remoteDataSource.getBookDetails(any))
                .thenThrow(ConnectionException());
            final result = await repositoryImpl.getBookDetails(bookId!);
            expect(result, equals(Left(ConnectionFailure())));
          });
        });
      });
    });
  });
}
