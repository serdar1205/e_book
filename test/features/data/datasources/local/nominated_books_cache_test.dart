import 'package:e_book/features/data/datasource/local/dao/nominated_books_dao.dart';
import 'package:e_book/features/data/datasource/local/nominated_books_cache.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';

void main() {
  late NominatedBooksDao nominatedBooksDao;
  late NominatedBooksCache nominatedBooksCache;

  setUp(() async {
    nominatedBooksCache =
        await $FloorNominatedBooksCache.inMemoryDatabaseBuilder().build();
    nominatedBooksDao = nominatedBooksCache.nominatedBooksDao;
  });

  tearDown(() async => await nominatedBooksCache.close());

  NominatedBooksEntity nominatedBook = const NominatedBooksEntity(
    id: 1,
    bookId: 52861201,
    bookName: "From Blood and Ash",
    author: "Jennifer L. Armentrou",
    votes: 70896,
    image:
        "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
    url:
        "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true",
  );

  group('Nominated Books Cache', () {
    test('insert data', () async {
      await nominatedBooksDao.insertNominatedBooks([nominatedBook]);
      final result = await nominatedBooksDao.getNominatedBooks();
      expect(result, contains(nominatedBook));
    });

    test('update data', () async {
      await nominatedBooksDao.insertNominatedBooks([nominatedBook]);

      NominatedBooksEntity updatedBook = const NominatedBooksEntity(
        id: 1,
        bookId: 52861201,
        bookName: "Blood and Ash",
        author: "Jennifer L. Armentrou",
        votes: 70896,
        image:
            "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
        url:
            "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true",
      );
      await nominatedBooksDao.updateNominatedBooks([updatedBook]);

      final result = await nominatedBooksDao.getNominatedBooks();
      expect(result, contains(updatedBook));
    });

    test('delete data', () async {
      await nominatedBooksDao.insertNominatedBooks([nominatedBook]);
      await nominatedBooksDao.deleteNominatedBooks([nominatedBook]);
      final result = await nominatedBooksDao.getNominatedBooks();
      expect(result, isEmpty);
    });

    test('get count data', () async {
      await nominatedBooksDao.insertNominatedBooks([nominatedBook]);
      final count = await nominatedBooksDao.getNominatedBooksCount();
      expect(count, 1);
    });
  });
}
