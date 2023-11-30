import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockBookDetailsRemoteDataSource remoteDataSource;
  late MockBookDetailCache bookDetailCache;
  late MockBookDetailDao bookDetailDao;
  late MockNetworkInfo networkInfo;
  late BookDetailRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('book_detail.json');
  final testModel = BookDetailModel.fromMap(json.decode(testJson));
  final bookId = testModel.bookId;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockBookDetailsRemoteDataSource();
    bookDetailCache = MockBookDetailCache();
    bookDetailDao = MockBookDetailDao();

    repositoryImpl = BookDetailRepositoryImpl(
      networkInfo: networkInfo,
      bookDetailsRemoteDataSource: remoteDataSource,
      bookDetailCache: bookDetailCache,
    );
  });

  group('getAuthorInfo', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(bookDetailDao.getBookDetailById(any))
            .thenAnswer((_) async => null);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getBookDetails(bookId))
            .thenAnswer((_) async => testModel);
        when(bookDetailDao.insertBookDetail(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getBookDetails(bookId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getBookDetails(bookId));
        verify(bookDetailDao.insertBookDetail(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(bookDetailDao.getBookDetailById(any))
            .thenAnswer((_) async => null);

        // act
        final result = await repositoryImpl.getBookDetails(bookId!);

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(remoteDataSource.getBookDetails(bookId))
            .thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getBookDetails(bookId!);
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getBookDetails(bookId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(bookDetailDao.getBookDetailById(any))
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getBookDetails(bookId))
            .thenAnswer((_) async => testModel);

        // act
        final cache = await bookDetailDao.getBookDetailById(bookId);
        final result = await repositoryImpl.getBookDetails(bookId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getBookDetails(any));
        verify(bookDetailDao.getBookDetailById(bookId));
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        BookDetailEntity updatedData = const BookDetailEntity(
          bookId: 56597885,
          name: 'Beautiful World, Where Are You',
          image:
              'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1618329605i/56597885.jpg',
          url: 'https://www.goodreads.com/book/show/56597885',
          author: ['Sally Rooney'],
          rating: 3.54,
          pages: 356,
          publishedDate: 'September 7, 2021',
          synopsis: 'Alice, a novelist, meets Felix',
        );

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(bookDetailDao.getBookDetailById(any))
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getBookDetails(bookId))
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await bookDetailDao.getBookDetailById(bookId);
        await bookDetailDao.updateBookDetail(updatedData);
        final result = await repositoryImpl.getBookDetails(bookId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getBookDetails(bookId));
        verify(bookDetailDao.getBookDetailById(bookId));
        verify(bookDetailDao.updateBookDetail(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(bookDetailCache.bookDetailDao).thenReturn(bookDetailDao);
        when(bookDetailDao.getBookDetailById(any))
            .thenAnswer((_) async => testModel);

        // act
        final cache = await bookDetailDao.getBookDetailById(bookId);
        final result = await repositoryImpl.getBookDetails(bookId!);

        // assert
        verify(networkInfo.isConnected);
        verify(bookDetailDao.getBookDetailById(bookId));
        expect(result, equals(Right(cache)));
      });
    });
  });
}
