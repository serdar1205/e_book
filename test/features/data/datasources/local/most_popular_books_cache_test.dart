import 'package:e_book/features/data/datasource/local/dao/most_popular_books_dao.dart';
import 'package:e_book/features/data/datasource/local/most_popular_books_cache.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';

void main() {
  group("Most popular books cache", () {
    late MostPopularBooksCache booksCache;
    late MostPopularBooksDao booksDao;

    setUp(() async {
      booksCache =
          await $FloorMostPopularBooksCache.inMemoryDatabaseBuilder().build();
      booksDao = booksCache.mostPopularBooksDao;
    });
    tearDown(() async {
      await booksCache.close();
    });

    MostPopularBooksEntity popularBook = MostPopularBooksEntity(
      id: 1,
      bookId: int.parse("58283080"),
      name: "Hook, Line, and Sinker (Bellinger Sisters, #2)",
      image:
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
      rating: 3.95,
      url: "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker",
    );

    test('Insert and Read MostPopularBooks', () async {
      //insert data into db
      await booksDao.insertMostPopularBooks([popularBook]);
      //get data from db
      final result = await booksDao.getMostPopularBooks();
      //check
      expect(result, contains(popularBook));
    });

    test('Update data', () async {
      //data

      //insert
      await booksDao.insertMostPopularBooks([popularBook]);
      //update
      MostPopularBooksEntity updatedBook = MostPopularBooksEntity(
        id: 1,
        bookId: int.parse("58283080"),
        name: "Line, and Sinker (Bellinger Sisters, #2)",
        image:
            "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
        rating: 3.95,
        url:
            "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker",
      );
      await booksDao.updateMostPopularBooks([updatedBook]);

      //get
      final result = await booksDao.getMostPopularBooks();
      //check
      expect(result, contains(updatedBook));
    });

    test('delete data', () async {
      await booksDao.insertMostPopularBooks([popularBook]);
      await booksDao.deleteMostPopularBooks([popularBook]);
      final result = await booksDao.getMostPopularBooks();
      expect(result, isEmpty);
    });

    test('get count ', () async {
      await booksDao.insertMostPopularBooks([popularBook]);
      final count = await booksDao.getMostPopularBooksCount();
      expect(count, 1);
    });
  });
}
