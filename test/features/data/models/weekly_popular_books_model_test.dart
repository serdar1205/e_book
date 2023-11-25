import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tWeeklyPopularBooksModel = WeeklyPopularBooksModel(
      bookId: 62080187,
      name: "Never Lie",
      image:
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
      url: "https://www.goodreads.com/book/show/62080187-never-lie");
  test('should be subclass of WeeklyPopularBooksEntity', () async {
    expect(tWeeklyPopularBooksModel, isA<WeeklyPopularBooksEntity>());
  });

  test('fromMap', () async {
    final Map<String, dynamic> jsonMap = {
      "book_id": 62080187,
      "name": "Never Lie",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/62080187-never-lie"
    };

    final result = WeeklyPopularBooksModel.fromMap(jsonMap);

    expect(result, tWeeklyPopularBooksModel);
  });

  test('toMap', () async {
    final result = tWeeklyPopularBooksModel.toMap();

    final expectedMap = {
      "book_id": 62080187,
      "name": "Never Lie",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/62080187-never-lie"
    };

    expect(result, expectedMap);
  });
}
