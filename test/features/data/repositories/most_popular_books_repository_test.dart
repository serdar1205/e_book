import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockMostPopularBooksRemoteDataSource remoteDataSource;
  late MockMostPopularBooksCache booksCache;
  late MockMostPopularBooksDao booksDao;
  late MockNetworkInfo networkInfo;
  late MostPopularBooksRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('most_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockMostPopularBooksRemoteDataSource();
    booksCache = MockMostPopularBooksCache();
    booksDao = MockMostPopularBooksDao();

    repositoryImpl = MostPopularBooksRepositoryImpl(
      networkInfo: networkInfo,
      mostPopularBooksRemoteDataSource: remoteDataSource,
      mostPopularBooksCache: booksCache,
    );
  });

  group('getMostPopularBooks', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getMostPopularBooks()).thenAnswer((_) async => []);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getPopularBooks())
            .thenAnswer((_) async => testModel);
        when(booksDao.insertMostPopularBooks(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getMostPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getPopularBooks());
        verify(booksDao.insertMostPopularBooks(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getMostPopularBooks()).thenAnswer((_) async => []);

        // act
        final result = await repositoryImpl.getMostPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(remoteDataSource.getPopularBooks()).thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getMostPopularBooks();
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getPopularBooks());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getMostPopularBooks()).thenAnswer((_) async => testModel);
        when(remoteDataSource.getPopularBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getMostPopularBooks();
        final result = await repositoryImpl.getMostPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getPopularBooks());
        verify(booksDao.getMostPopularBooks());
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        List<MostPopularBooksEntity> updatedData = [
          MostPopularBooksEntity(
              id: 1,
              bookId: int.parse("58283080"),
              name: "Hook, Line, and Sinker",
              image:
                  "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
              rating: 3.95,
              url:
                  "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker"),
        ];

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getMostPopularBooks()).thenAnswer((_) async => testModel);
        when(remoteDataSource.getPopularBooks())
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await booksDao.getMostPopularBooks();
        await booksDao.updateMostPopularBooks(updatedData);
        final result = await repositoryImpl.getMostPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getPopularBooks());
        verify(booksDao.getMostPopularBooks());
        verify(booksDao.updateMostPopularBooks(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.mostPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getMostPopularBooks()).thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getMostPopularBooks();
        final result = await repositoryImpl.getMostPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(booksDao.getMostPopularBooks());
        expect(result, equals(Right(cache)));
      });
    });
  });
}
