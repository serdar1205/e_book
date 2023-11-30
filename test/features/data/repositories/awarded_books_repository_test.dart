import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/awarded_books_model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAwardedBooksRemoteDataSource remoteDataSource;
  late MockAwardedBooksCache awardedBooksCache;
  late MockNetworkInfo networkInfo;
  late AwardedBooksRepositoryImpl repositoryImpl;
  late MockAwardedBooksDao mockAwardedBooksDao;

  final testJson = fixtureReader('awarded_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockAwardedBooksRemoteDataSource();
    awardedBooksCache = MockAwardedBooksCache();
    mockAwardedBooksDao = MockAwardedBooksDao();

    repositoryImpl = AwardedBooksRepositoryImpl(
      networkInfo: networkInfo,
      remoteDataSource: remoteDataSource,
      awardedBooksCache: awardedBooksCache,
    );
  });

  group('getAwardedBooks', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(mockAwardedBooksDao.getAwardedBooks()).thenAnswer((_) async => []);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getAwardedBooks())
            .thenAnswer((_) async => testModel);
        when(mockAwardedBooksDao.insertAwardedBooks(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getAwardedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAwardedBooks());
        verify(mockAwardedBooksDao.insertAwardedBooks(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(mockAwardedBooksDao.getAwardedBooks()).thenAnswer((_) async => []);

        // act
        final result = await repositoryImpl.getAwardedBooks();

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(remoteDataSource.getAwardedBooks()).thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getAwardedBooks();
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAwardedBooks());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(mockAwardedBooksDao.getAwardedBooks())
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getAwardedBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await mockAwardedBooksDao.getAwardedBooks();
        final result = await repositoryImpl.getAwardedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAwardedBooks());
        verify(mockAwardedBooksDao.getAwardedBooks());
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        List<AwardedBooksEntity> updatedData = [
          const AwardedBooksEntity(
            id: 1,
            bookId: 56597885,
            name: 'Beautiful World',
            image:
                'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
            url:
                'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
            winningCategory: 'Fiction',
          ),
        ];

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(mockAwardedBooksDao.getAwardedBooks())
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getAwardedBooks())
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await mockAwardedBooksDao.getAwardedBooks();
        await mockAwardedBooksDao.updateAwardedBooks(updatedData);
        final result = await repositoryImpl.getAwardedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAwardedBooks());
        verify(mockAwardedBooksDao.getAwardedBooks());
        verify(mockAwardedBooksDao.updateAwardedBooks(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(awardedBooksCache.awardedBooksDao).thenReturn(mockAwardedBooksDao);
        when(mockAwardedBooksDao.getAwardedBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await mockAwardedBooksDao.getAwardedBooks();
        final result = await repositoryImpl.getAwardedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(mockAwardedBooksDao.getAwardedBooks());
        expect(result, equals(Right(cache)));
      });
    });
  });
}