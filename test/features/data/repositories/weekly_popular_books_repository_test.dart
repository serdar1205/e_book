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
  late MockWeeklyPopularBooksRemoteDataSource remoteDataSource;
  late MockWeeklyPopularBooksCache booksCache;
  late MockWeeklyPopularBooksDao booksDao;
  late MockNetworkInfo networkInfo;
  late WeeklyPopularBooksRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('weekly_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => WeeklyPopularBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockWeeklyPopularBooksRemoteDataSource();
    booksCache = MockWeeklyPopularBooksCache();
    booksDao = MockWeeklyPopularBooksDao();

    repositoryImpl = WeeklyPopularBooksRepositoryImpl(
      networkInfo: networkInfo,
      weeklyPopularBooksRemoteDataSource: remoteDataSource,
      weeklyPopularBooksCache: booksCache,
    );
  });

  group('getWeeklyPopularBooks', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getWeeklyPopularBooks()).thenAnswer((_) async => []);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getWeeklyPopularBooks())
            .thenAnswer((_) async => testModel);
        when(booksDao.insertWeeklyPopularBooks(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getWeeklyPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getWeeklyPopularBooks());
        verify(booksDao.insertWeeklyPopularBooks(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getWeeklyPopularBooks()).thenAnswer((_) async => []);

        // act
        final result = await repositoryImpl.getWeeklyPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(remoteDataSource.getWeeklyPopularBooks())
            .thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getWeeklyPopularBooks();
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getWeeklyPopularBooks());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getWeeklyPopularBooks())
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getWeeklyPopularBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getWeeklyPopularBooks();
        final result = await repositoryImpl.getWeeklyPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getWeeklyPopularBooks());
        verify(booksDao.getWeeklyPopularBooks());
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        List<WeeklyPopularBooksEntity> updatedData = [
          const WeeklyPopularBooksEntity(
            id: 1,
            bookId: 62080187,
            name: "Never Lie",
            image:
                "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
            url: "https://www.goodreads.com/book/show/62080187-never-lie",
          ),
        ];

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getWeeklyPopularBooks())
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getWeeklyPopularBooks())
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await booksDao.getWeeklyPopularBooks();
        await booksDao.updateWeeklyPopularBooks(updatedData);
        final result = await repositoryImpl.getWeeklyPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getWeeklyPopularBooks());
        verify(booksDao.getWeeklyPopularBooks());
        verify(booksDao.updateWeeklyPopularBooks(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.weeklyPopularBooksDao).thenReturn(booksDao);
        when(booksDao.getWeeklyPopularBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getWeeklyPopularBooks();
        final result = await repositoryImpl.getWeeklyPopularBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(booksDao.getWeeklyPopularBooks());
        expect(result, equals(Right(cache)));
      });
    });
  });
}
