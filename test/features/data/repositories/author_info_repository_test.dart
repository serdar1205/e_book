import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/data/repository/repositories_impl.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAuthorInfoRemoteDataSource remoteDataSource;
  late MockAuthorInfoCache authorInfoCache;
  late MockAuthorInfoDao authorInfoDao;
  late MockNetworkInfo networkInfo;
  late AuthorInfoRepositoryImpl repositoryImpl;

  final testJson = fixtureReader('author_info.json');
  final testModel = AuthorInfoModel.fromMap(json.decode(testJson));
  final authorId = testModel.authorId;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockAuthorInfoRemoteDataSource();
    authorInfoCache = MockAuthorInfoCache();
    authorInfoDao = MockAuthorInfoDao();

    repositoryImpl = AuthorInfoRepositoryImpl(
      networkInfo: networkInfo,
      authorRemoteDataSource: remoteDataSource,
      authorInfoCache: authorInfoCache,
    );
  });

  group('getAuthorInfo', () {
    group('fetchRemoteData', () {
      test(
          'should check database is empty and internet is connected return remote data and insert remote data to cache',
          () async {
        //arrange
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(authorInfoDao.getAuthorInfoById(any))
            .thenAnswer((_) async => null);
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // Stub the remote data and insertAwardedBooks method
        when(remoteDataSource.getAuthorInfo(authorId))
            .thenAnswer((_) async => testModel);
        when(authorInfoDao.insertAuthorInfo(testModel))
            .thenAnswer((_) async => null);
        // act
        final result = await repositoryImpl.getAuthorInfo(authorId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAuthorInfo(authorId));
        verify(authorInfoDao.insertAuthorInfo(testModel));
        expect(result, equals(Right(testModel)));
      });

      test(
          'should return network failure when device is offline and database is empty',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(authorInfoDao.getAuthorInfoById(any))
            .thenAnswer((_) async => null);

        // act
        final result = await repositoryImpl.getAuthorInfo(authorId!);

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      });

      test(
          'should return a ServerFailure when an exception occurs remote datasource is unsuccessful and device is online',
          () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(remoteDataSource.getAuthorInfo(authorId))
            .thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getAuthorInfo(authorId!);
        //assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAuthorInfo(authorId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('fetchCachedData', () {
      test(
          'should return cached data when the cache is not empty and internet connected and remote data == cache',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(authorInfoDao.getAuthorInfoById(any))
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getAuthorInfo(authorId))
            .thenAnswer((_) async => testModel);

        // act
        final cache = await authorInfoDao.getAuthorInfoById(authorId);
        final result = await repositoryImpl.getAuthorInfo(authorId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAuthorInfo(authorId));
        verify(authorInfoDao.getAuthorInfoById(authorId));
        expect(result, equals(Right(cache)));
      });

      test(
          'should return remote data when the cache is not empty and internet connected and remote data != cache update data',
          () async {
        AuthorInfoEntity updatedData = const AuthorInfoEntity(
            id: 1,
            authorId: 3389,
            name: 'Stephen',
            image: 'https://images.gr-assets.com/authors/1362814142p5/3389.jpg',
            info:
                'Stephen Edwin King was born the second son of Donald and Nellie Ruth Pillsbury King. After his father left them when Stephen was two, he and his older brother, David, were raised by his mother. Parts of his childhood were spent in Fort Wayne, Indiana, where his father\'s family was at the time, and in Stratford, Connecticut. When Stephen was eleven, his mother brought her children back to Durham, Maine, for good. Her parents, Guy and Nellie Pillsbury, had become incapacitated with old age, and Ruth King was persuaded by her sisters to take over the physical care of them. Other family members provided a small house in Durham and financial support. After Stephen\'s grandparents passed away, Mrs. King found work in the kitchens of Pineland, a nearby residential facility for the mentally challenged.Stephen attended the grammar school in Durham and Lisbon Falls High School, graduating in 1966. From his sophomore year at the University of Maine at Orono, he wrote a weekly column for the school newspaper, THE MAINE CAMPUS. He was also active in student politics, serving as a member of the Student Senate. He came to support the anti-war movement on the Orono campus, arriving at his stance from a conservative view that the war in Vietnam was unconstitutional. He graduated in 1970, with a B.A. in English and qualified to teach on the high school level. A draft board examination immediately post-graduation found him 4-F on grounds of high blood pressure, limited vision, flat feet, and punctured eardrums.He met Tabitha Spruce in the stacks of the Fogler Library at the University, where they both worked as students; they married in January of 1971. As Stephen was unable to find placement as a teacher immediately, the Kings lived on his earnings as a laborer at an industrial laundry, and her student loan and savings, with an occasional boost from a short story sale to men\'s magazines.Stephen made his first professional short story sale ("The Glass Floor") to Startling Mystery Stories in 1967. Throughout the early years of his marriage, he continued to sell stories to men\'s magazines. Many were gathered into the Night Shift collection or appeared in other anthologies.In the fall of 1971, Stephen began teaching English at Hampden Academy, the public high school in Hampden, Maine. Writing in the evenings and on the weekends, he continued to produce short stories and to work on novels.',
            rating: 4.06,
            genres: [
              "Horror",
              "Mystery",
              "Literature & Fiction"
            ],
            authorBooks: [
              AuthorBooks(
                  url: 'https://www.goodreads.com/book/show/11588.The_Shining',
                  name: 'The Shining (The Shining, #1)',
                  rating: 4.26,
                  date: 1977,
                  bookId: '11588'),
              AuthorBooks(
                  url: 'https://www.goodreads.com/book/show/830502.It',
                  name: 'It',
                  rating: 4.25,
                  date: 1986,
                  bookId: '830502'),
            ]);

        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(authorInfoDao.getAuthorInfoById(any))
            .thenAnswer((_) async => testModel);
        when(remoteDataSource.getAuthorInfo(authorId))
            .thenAnswer((_) async => updatedData);

        // act

        final cache = await authorInfoDao.getAuthorInfoById(authorId);
        await authorInfoDao.updateAuthorInfoById(updatedData);
        final result = await repositoryImpl.getAuthorInfo(authorId!);

        // assert
        verify(networkInfo.isConnected);
        verify(remoteDataSource.getAuthorInfo(authorId));
        verify(authorInfoDao.getAuthorInfoById(authorId));
        verify(authorInfoDao.updateAuthorInfoById(updatedData));

        expect(result, equals(Right(updatedData)));
        expect(result, isNot(cache));
      });

      test(
          'should return cached data when the cache is not empty and device is offline',
          () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(authorInfoCache.authorInfoDao).thenReturn(authorInfoDao);
        when(authorInfoDao.getAuthorInfoById(any))
            .thenAnswer((_) async => testModel);

        // act
        final cache = await authorInfoDao.getAuthorInfoById(authorId);
        final result = await repositoryImpl.getAuthorInfo(authorId!);

        // assert
        verify(networkInfo.isConnected);
        verify(authorInfoDao.getAuthorInfoById(authorId));
        expect(result, equals(Right(cache)));
      });
    });
  });
}
