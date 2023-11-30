import 'package:e_book/features/data/datasource/local/author_info_cache.dart';
import 'package:e_book/features/data/datasource/local/book_detail_cache.dart';
import 'package:e_book/features/data/datasource/local/dao/author_info_dao.dart';
import 'package:e_book/features/data/datasource/local/dao/book_detail_dao.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BookDetailCache bookDetailCache;
  late BookDetailDao bookDetailDao;

  setUp(() async {
    bookDetailCache =
    await $FloorBookDetailCache.inMemoryDatabaseBuilder().build();
    bookDetailDao = bookDetailCache.bookDetailDao;
  });

  tearDown(() async => await bookDetailCache.close());

  BookDetailEntity bookDetails = const BookDetailEntity(
    id: 1,
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

  group('Book Detail Cache', () {
    test('get data', () async {
      await bookDetailDao.insertBookDetail(bookDetails);
      BookDetailEntity? result =
      await bookDetailDao.getBookDetailById(bookDetails.bookId!);
      expect(result, equals(bookDetails));
    });

    test('update data', () async {
      await bookDetailDao.insertBookDetail(bookDetails);

      BookDetailEntity updatedData = const BookDetailEntity(
        id: 1,
        bookId: 56597885,
        name: 'Beautiful World',
        image:
        'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1618329605i/56597885.jpg',
        url: 'https://www.goodreads.com/book/show/56597885',
        author: ['Sally Rooney'],
        rating: 3.54,
        pages: 356,
        publishedDate: 'September 7, 2021',
        synopsis: 'Alice, a novelist, meets Felix',
      );
      await bookDetailDao.updateBookDetail(updatedData);

      BookDetailEntity? result =
      await bookDetailDao.getBookDetailById(bookDetails.bookId!);
      expect(result, equals(updatedData));
    });
  });
}
