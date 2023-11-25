import 'dart:convert';

import 'package:e_book/features/data/model/awarded_books_model.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tAwardedBooksModel = AwardedBooksModel(
    bookId: 56597885,
    name: 'Beautiful World, Where Are You',
    image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
    url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
    winningCategory: 'Fiction',
  );
  test('should be subclass of AwardedBooksEntity', () async {
    expect(tAwardedBooksModel, isA<AwardedBooksEntity>());
  });

  test('fromMap', () async {
    final Map<String, dynamic> jsonMap = {
      "book_id": "56597885",
      "name": "Beautiful World, Where Are You",
      "category": "Fiction",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg",
      "url": "https://www.goodreads.com/choiceawards/best-fiction-books-2021"
    };

    final result = AwardedBooksModel.fromMap(jsonMap);

    expect(result, tAwardedBooksModel);
  });

  test('toMap', () async {
    final result = tAwardedBooksModel.toMap();

    final expectedAwardedBooksMap = {
      "book_id": 56597885,
      "name": "Beautiful World, Where Are You",
      "category": "Fiction",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg",
      "url": "https://www.goodreads.com/choiceawards/best-fiction-books-2021"
    };

    expect(result, expectedAwardedBooksMap);
  });
}
