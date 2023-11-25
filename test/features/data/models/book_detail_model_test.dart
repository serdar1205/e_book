import 'dart:convert';
import 'package:e_book/features/data/model/book_detail_model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  const tBookDetailModel = BookDetailModel(
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

  test('should be a subclass of BookDetailEntity', () async {
    expect(tBookDetailModel, isA<BookDetailEntity>());
  });

  test('fromMap', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixtureReader('book_detail.json'));
    //act
    final result = BookDetailModel.fromMap(jsonMap);
    //assert
    expect(result, tBookDetailModel);
  });

  test('toMap', () async {
    final result = tBookDetailModel.toMap();
    final expectedtBookDetailMap = {
      "book_id": 56597885,
      "name": "Beautiful World, Where Are You",
      "cover":
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1618329605i/56597885.jpg",
      "url": "https://www.goodreads.com/book/show/56597885",
      "authors": ["Sally Rooney"],
      "rating": 3.54,
      "pages": 356,
      "published_date": "September 7, 2021",
      "synopsis": "Alice, a novelist, meets Felix"
    };

    expect(result, expectedtBookDetailMap);
  });
}
