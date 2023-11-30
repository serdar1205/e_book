import 'package:e_book/features/data/datasource/local/awarded_books_cache.dart';
import 'package:e_book/features/data/datasource/local/dao/awarded_books_dao.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('AwardedBooksCache', () {
    late AwardedBooksCache awardedBooksCache;
    late AwardedBooksDao awardedBooksDao;

    setUp(() async {
      awardedBooksCache = await $FloorAwardedBooksCache.inMemoryDatabaseBuilder().addMigrations([]).build();
      awardedBooksDao = awardedBooksCache.awardedBooksDao;
    });

    tearDown(() async {
      await awardedBooksCache.close();
    });

    test('Insert and Read AwardedBooks', () async {
      // Create a sample AwardedBooksEntity
      const awardedBook = AwardedBooksEntity(
        id: 1,
        bookId: 56597885,
        name: 'Beautiful World, Where Are You',
        image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
        url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
        winningCategory: 'Fiction',
      );

      // Insert the AwardedBooksEntity into the database
      await awardedBooksDao.insertAwardedBooks([awardedBook]);

      // Retrieve the AwardedBooksEntity from the database
      final result = await awardedBooksDao.getAwardedBooks();

      // Check if the retrieved result contains the inserted AwardedBooksEntity
      expect(result, contains(awardedBook));
    });

    test('Update AwardedBooks', () async {
      // Create a sample AwardedBooksEntity
      const awardedBook = AwardedBooksEntity(
        id: 1,
        bookId: 56597885,
        name: 'Beautiful World, Where Are You',
        image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
        url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
        winningCategory: 'Fiction',
      );

      // Insert the AwardedBooksEntity into the database
      await awardedBooksDao.insertAwardedBooks([awardedBook]);

      // Update the AwardedBooksEntity
      const updatedBook = AwardedBooksEntity(
        id: 1,
        bookId: 56597885,
        name: 'Beautiful World, Where Are You',
        image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
        url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
        winningCategory: 'History',
      );
      await awardedBooksDao.updateAwardedBooks([updatedBook]);

      // Retrieve the updated AwardedBooksEntity from the database
      final result = await awardedBooksDao.getAwardedBooks();

      // Check if the retrieved result contains the updated AwardedBooksEntity
      expect(result, contains(updatedBook));
    });

    test('Delete AwardedBooks', () async {
      // Create a sample AwardedBooksEntity
      const awardedBook = AwardedBooksEntity(
        id:1,
        bookId: 56597885,
        name: 'Beautiful World, Where Are You',
        image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
        url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
        winningCategory: 'History',
      );

      // Insert the AwardedBooksEntity into the database
      await awardedBooksDao.insertAwardedBooks([awardedBook]);

      // Delete the AwardedBooksEntity from the database
      await awardedBooksDao.deleteAwardedBooks([awardedBook]);

      // Retrieve the AwardedBooksEntity from the database
      final result = await awardedBooksDao.getAwardedBooks();

      // Check if the retrieved result does not contain the deleted AwardedBooksEntity
      expect(result, isEmpty);
    });

    test('Get AwardedBooks Count', () async {
      // Create a sample AwardedBooksEntity
      const awardedBook =  AwardedBooksEntity(
        id:1,
        bookId: 56597885,
        name: 'Beautiful World, Where Are You',
        image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
        url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
        winningCategory: 'Fiction',
      );

      // Insert the AwardedBooksEntity into the database
      await awardedBooksDao.insertAwardedBooks([awardedBook]);

      // Get the count of AwardedBooks in the database
      final count = await awardedBooksDao.getAwardedBooksCount();

      // Check if the count is 1 after insertion
      expect(count, 1);
    });
  });
}
