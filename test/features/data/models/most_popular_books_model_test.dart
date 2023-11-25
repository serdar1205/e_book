import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMostPopularBooksModel = MostPopularBooksModel(
      bookId: int.parse("58283080"),
      name: "Hook, Line, and Sinker (Bellinger Sisters, #2)",
      image:
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
      rating: 3.95,
      url: "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker");
  test('should be subclass of MostPopularBooksEntity', () async {
    expect(tMostPopularBooksModel, isA<MostPopularBooksEntity>());
  });

  test('fromMap', () async {
    final Map<String, dynamic> jsonMap = {
      "book_id": "58283080",
      "name": "Hook, Line, and Sinker (Bellinger Sisters, #2)",
      "cover":
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
      "rating": 3.95,
      "url": "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker"
    };

    final result = MostPopularBooksModel.fromMap(jsonMap);

    expect(result, tMostPopularBooksModel);
  });

  test('toMap', () async {
    final result = tMostPopularBooksModel.toMap();

    final expectedMap = {
      "book_id": int.parse("58283080"),
      "name": "Hook, Line, and Sinker (Bellinger Sisters, #2)",
      "cover":
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
      "rating": 3.95,
      "url": "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker"
    };

    expect(result, expectedMap);
  });
}
