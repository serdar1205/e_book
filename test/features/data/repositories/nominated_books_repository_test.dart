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
  late MockNominatedBooksRemoteDataSource remoteDataSource;
  late MockNominatedBooksCache booksCache;
  late MockNominatedBooksDao booksDao;
  late MockNetworkInfo networkInfo;
  late NominatedBooksRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('nominated_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockNominatedBooksRemoteDataSource();
    booksCache = MockNominatedBooksCache();
    booksDao = MockNominatedBooksDao();

    repositoryImpl = NominatedBooksRepositoryImpl(
      networkInfo: networkInfo,
      nominatedBooksRemoteDataSource: remoteDataSource,
      nominatedBooksCache: booksCache,
    );
  });

  group('getNominatedBooks', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(booksDao.getNominatedBooks()).thenAnswer((_) async => []);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getNominatedBooks())
            .thenAnswer((_) async => testModel);
        when(booksDao.insertNominatedBooks(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getNominatedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getNominatedBooks());
        verify(booksDao.insertNominatedBooks(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(booksDao.getNominatedBooks()).thenAnswer((_) async => []);

        // act
        final result = await repositoryImpl.getNominatedBooks();

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(remoteDataSource.getNominatedBooks()).thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getNominatedBooks();
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getNominatedBooks());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(booksDao.getNominatedBooks()).thenAnswer((_) async => testModel);
        when(remoteDataSource.getNominatedBooks())
            .thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getNominatedBooks();
        final result = await repositoryImpl.getNominatedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getNominatedBooks());
        verify(booksDao.getNominatedBooks());
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        List<NominatedBooksEntity> updatedData = [
          const NominatedBooksEntity(
            id: 1,
            bookId: 52861201,
            bookName: "From Blood and Ash",
            author: "Jennifer L. Armentrou",
            votes: 70896,
            image:
                "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
            url:
                "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true",
          ),
        ];

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(booksDao.getNominatedBooks()).thenAnswer((_) async => testModel);
        when(remoteDataSource.getNominatedBooks())
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await booksDao.getNominatedBooks();
        await booksDao.updateNominatedBooks(updatedData);
        final result = await repositoryImpl.getNominatedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getNominatedBooks());
        verify(booksDao.getNominatedBooks());
        verify(booksDao.updateNominatedBooks(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(booksCache.nominatedBooksDao).thenReturn(booksDao);
        when(booksDao.getNominatedBooks()).thenAnswer((_) async => testModel);

        // act
        final cache = await booksDao.getNominatedBooks();
        final result = await repositoryImpl.getNominatedBooks();

        // assert
        verify(networkInfo.isConnected);
        verify(booksDao.getNominatedBooks());
        expect(result, equals(Right(cache)));
      });
    });
  });
}
