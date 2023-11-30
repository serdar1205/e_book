import 'package:e_book/features/data/datasource/local/dao/weekly_popular_books_dao.dart';
import 'package:e_book/features/data/datasource/local/weekly_popular_books_cache.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';

void main() {
  late WeeklyPopularBooksDao weeklyPopularBooksDao;
  late WeeklyPopularBooksCache weeklyPopularBooksCache;

  setUp(() async {
    weeklyPopularBooksCache =
        await $FloorWeeklyPopularBooksCache.inMemoryDatabaseBuilder().build();
    weeklyPopularBooksDao = weeklyPopularBooksCache.weeklyPopularBooksDao;
  });

  tearDown(() async => await weeklyPopularBooksCache.close());

  WeeklyPopularBooksEntity weeklyPopularBooks = const WeeklyPopularBooksEntity(
    id: 1,
    bookId: 62080187,
    name: "Never Lie",
    image:
        "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
    url: "https://www.goodreads.com/book/show/62080187-never-lie",
  );

  group('Weekly Popular Books Cache', () {
    test('insert data', () async {
      await weeklyPopularBooksDao
          .insertWeeklyPopularBooks([weeklyPopularBooks]);
      final result = await weeklyPopularBooksDao.getWeeklyPopularBooks();
      expect(result, contains(weeklyPopularBooks));
    });

    test('update data', () async {
      await weeklyPopularBooksDao
          .insertWeeklyPopularBooks([weeklyPopularBooks]);

      WeeklyPopularBooksEntity updatedBook = const WeeklyPopularBooksEntity(
        id: 1,
        bookId: 62080187,
        name: "Don't Lie",
        image:
            "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
        url: "https://www.goodreads.com/book/show/62080187-never-lie",
      );
      await weeklyPopularBooksDao.updateWeeklyPopularBooks([updatedBook]);

      final result = await weeklyPopularBooksDao.getWeeklyPopularBooks();
      expect(result, contains(updatedBook));
    });

    test('delete data', () async {
      await weeklyPopularBooksDao
          .insertWeeklyPopularBooks([weeklyPopularBooks]);
      await weeklyPopularBooksDao
          .deleteWeeklyPopularBooks([weeklyPopularBooks]);
      final result = await weeklyPopularBooksDao.getWeeklyPopularBooks();
      expect(result, isEmpty);
    });

    test('get count data', () async {
      await weeklyPopularBooksDao
          .insertWeeklyPopularBooks([weeklyPopularBooks]);
      final count = await weeklyPopularBooksDao.getWeeklyPopularBooksCount();
      expect(count, 1);
    });
  });
}
