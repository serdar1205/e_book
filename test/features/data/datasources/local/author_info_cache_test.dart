import 'package:e_book/features/data/datasource/local/author_info_cache.dart';
import 'package:e_book/features/data/datasource/local/dao/author_info_dao.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthorInfoCache authorInfoCache;
  late AuthorInfoDao authorInfoDao;

  setUp(() async {
    authorInfoCache =
        await $FloorAuthorInfoCache.inMemoryDatabaseBuilder().build();
    authorInfoDao = authorInfoCache.authorInfoDao;
  });

  tearDown(() async => await authorInfoCache.close());

  AuthorInfoEntity authorInfo = const AuthorInfoEntity(
    id: 1,
    authorId: 3389,
    name: 'Stephen King',
    image: 'https://images.gr-assets.com/authors/1362814142p5/3389.jpg',
    info:
        'Stephen Edwin King was born the second son of Donald and Nellie Ruth Pillsbury King.',
    rating: 4.06,
    genres: ["Horror", "Mystery", "Literature & Fiction"],
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
    ],
  );

  group('Author Info Cache', () {
    test('get data', () async {
      await authorInfoDao.insertAuthorInfo(authorInfo);
      AuthorInfoEntity? result =
          await authorInfoDao.getAuthorInfoById(authorInfo.authorId!);
      expect(result, equals(authorInfo));
    });

    test('update data', () async {
      await authorInfoDao.insertAuthorInfo(authorInfo);

      AuthorInfoEntity updatedData = const AuthorInfoEntity(
        id: 1,
        authorId: 3389,
        name: 'Stephen',
        image: 'https://images.gr-assets.com/authors/1362814142p5/3389.jpg',
        info:
        'Stephen Edwin King was born the second son of Donald and Nellie Ruth Pillsbury King.',
        rating: 4.06,
        genres: ["Horror", "Mystery", "Literature & Fiction"],
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
        ],
      );
      await authorInfoDao.updateAuthorInfoById(updatedData);

      AuthorInfoEntity? result =
      await authorInfoDao.getAuthorInfoById(authorInfo.authorId!);
      expect(result, equals(updatedData));
    });
  });
}
