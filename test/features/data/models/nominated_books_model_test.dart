import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tNominatedBooksModel = NominatedBooksModel(
      bookId: 52861201,
      bookName: "From Blood and Ash",
      author: "Jennifer L. Armentrou",
      votes: 70896,
      image:
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
      url:
          "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true");
  test('should be subclass of NominatedBooksEntity', () async {
    expect(tNominatedBooksModel, isA<NominatedBooksEntity>());
  });

  test('fromMap', () async {
    final Map<String, dynamic> jsonMap = {
      "book_id": 52861201,
      "name": "From Blood and Ash",
      "author": "Jennifer L. Armentrou",
      "votes": 70896,
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
      "url":
          "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true"
    };

    final result = NominatedBooksModel.fromMap(jsonMap);

    expect(result, tNominatedBooksModel);
  });

  test('toMap', () async {
    final result = tNominatedBooksModel.toMap();

    final expectedMap = {
      "book_id": 52861201,
      "name": "From Blood and Ash",
      "author": "Jennifer L. Armentrou",
      "votes": 70896,
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
      "url":
          "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true"
    };

    expect(result, expectedMap);
  });
}
