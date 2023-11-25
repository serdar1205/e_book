import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMostPopularAuthorsModel = MostPopularAuthorModel(
      authorId: 3389,
      name: "Stephen King",
      image:
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      url: "https://www.goodreads.com/author/show/3389.Stephen_King",
      popularBookTitle: "The Shining",
      popularBookUrl: "https://www.goodreads.com/book/show/11588.The_Shining",
      numberPublishedBooks: 2567);
  test('should be subclass of MostPopularAuthorsEntity', () async {
    expect(tMostPopularAuthorsModel, isA<MostPopularAuthorsEntity>());
  });

  test('fromMap', () async {
    final Map<String, dynamic> jsonMap = {
      "author_id": 3389,
      "name": "Stephen King",
      "image":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      "url": "https://www.goodreads.com/author/show/3389.Stephen_King",
      "popular_book_title": "The Shining",
      "popular_book_url":
          "https://www.goodreads.com/book/show/11588.The_Shining",
      "number_published_books": 2567
    };

    final result = MostPopularAuthorModel.fromMap(jsonMap);

    expect(result, tMostPopularAuthorsModel);
  });

  test('toMap', () async {
    final result = tMostPopularAuthorsModel.toMap();

    final expectedMap = {
      "author_id": 3389,
      "name": "Stephen King",
      "image":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      "url": "https://www.goodreads.com/author/show/3389.Stephen_King",
      "popular_book_title": "The Shining",
      "popular_book_url":
          "https://www.goodreads.com/book/show/11588.The_Shining",
      "number_published_books": 2567
    };

    expect(result, expectedMap);
  });
}
