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
  late MockMostPopularAuthorsRemoteDataSource remoteDataSource;
  late MockAuthorsCache authorsCache;
  late MockAuthorsDao mockAuthorsDao;
  late MockNetworkInfo networkInfo;
  late MostPopularAuthorsRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('most_popular_authors.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockMostPopularAuthorsRemoteDataSource();
    authorsCache = MockAuthorsCache();
    mockAuthorsDao = MockAuthorsDao();

    repositoryImpl = MostPopularAuthorsRepositoryImpl(
      networkInfo: networkInfo,
      mostPopularAuthorsRemoteDataSource: remoteDataSource,
      authorsCache: authorsCache,
    );
  });


  group('getMostPopularAuthors', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
              () async {
            //arrange
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(mockAuthorsDao.getAuthors()).thenAnswer((_) async => []);
            when(networkInfo.isConnected).thenAnswer((_) async => true);

            // Stub the remote data and insertAwardedBooks method
            when(remoteDataSource.getPopularAuthors())
                .thenAnswer((_) async => testModel);
            when(mockAuthorsDao.insertAuthors(testModel))
                .thenAnswer((_) async => null);
            // act
            final result = await repositoryImpl.getMostPopularAuthors();

            // assert
            verify(networkInfo.isConnected);
            verify(remoteDataSource.getPopularAuthors());
            verify(mockAuthorsDao.insertAuthors(testModel));
            expect(result, equals(Right(testModel)));
          });

      test(
          'should return network failure when device is offline and database is empty',
              () async {
            // arrange
            when(networkInfo.isConnected).thenAnswer((_) async => false);
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(mockAuthorsDao.getAuthors()).thenAnswer((_) async => []);

            // act
            final result = await repositoryImpl.getMostPopularAuthors();

            // assert
            verify(networkInfo.isConnected);
            expect(result, Left(ConnectionFailure()));
          });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
              () async {
            //arrange
            when(networkInfo.isConnected).thenAnswer((_) async => true);
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(remoteDataSource.getPopularAuthors()).thenThrow(ServerException());

            //act
            final result = await repositoryImpl.getMostPopularAuthors();
            //assert
            verify(networkInfo.isConnected);
            verify(remoteDataSource.getPopularAuthors());
            expect(result, equals(Left(ServerFailure())));
          });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
              () async {
            // arrange
            when(networkInfo.isConnected).thenAnswer((_) async => true);
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(mockAuthorsDao.getAuthors())
                .thenAnswer((_) async => testModel);
            when(remoteDataSource.getPopularAuthors())
                .thenAnswer((_) async => testModel);

            // act
            final cache = await mockAuthorsDao.getAuthors();
            final result = await repositoryImpl.getMostPopularAuthors();

            // assert
            verify(networkInfo.isConnected);
            verify(remoteDataSource.getPopularAuthors());
            verify(mockAuthorsDao.getAuthors());
            expect(result, equals(Right(cache)));
          });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
              () async {
            List<MostPopularAuthorsEntity> updatedData = [
              const MostPopularAuthorsEntity(
                id: 1,
                  authorId: 3389,
                  name: "Stephen",
                  image:
                  "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
                  url: "https://www.goodreads.com/author/show/3389.Stephen_King",
                  popularBookTitle: "The Shining",
                  popularBookUrl: "https://www.goodreads.com/book/show/11588.The_Shining",
                  numberPublishedBooks: 2567
              ),
            ];

            // arrange
            when(networkInfo.isConnected).thenAnswer((_) async => true);
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(mockAuthorsDao.getAuthors())
                .thenAnswer((_) async => testModel);
            when(remoteDataSource.getPopularAuthors())
                .thenAnswer((_) async => updatedData);

            // act

            final cache = await mockAuthorsDao.getAuthors();
            await mockAuthorsDao.updateAuthors(updatedData);
            final result = await repositoryImpl.getMostPopularAuthors();

            // assert
            verify(networkInfo.isConnected);
            verify(remoteDataSource.getPopularAuthors());
            verify(mockAuthorsDao.getAuthors());
            verify(mockAuthorsDao.updateAuthors(updatedData));

            expect(result, equals(Right(updatedData)));
            expect(result, isNot(cache));
          });

      test(
          'should return cached data when the cache is not empty and device is offline',
              () async {
            // arrange
            when(networkInfo.isConnected).thenAnswer((_) async => false);
            when(authorsCache.authorsDao).thenReturn(mockAuthorsDao);
            when(mockAuthorsDao.getAuthors())
                .thenAnswer((_) async => testModel);

            // act
            final cache = await mockAuthorsDao.getAuthors();
            final result = await repositoryImpl.getMostPopularAuthors();

            // assert
            verify(networkInfo.isConnected);
            verify(mockAuthorsDao.getAuthors());
            expect(result, equals(Right(cache)));
          });
    });
  });







}
