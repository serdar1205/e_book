import 'package:e_book/features/domain/entity/nominated_books_entity.dart';

class NominatedBooksModel extends NominatedBooksEntity {
  const NominatedBooksModel({
    int? id,
    int? bookId,
    String? bookName,
    String? author,
    int? votes,
    String? image,
    String? url,
  }) : super(
          id: id,
          bookId: bookId,
          bookName: bookName,
          author: author,
          votes: votes,
          image: image,
          url: url,
        );

  @override
  List<Object?> get props => [bookId, bookName, author, votes, image, url];

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'name': bookName,
      'author': author,
      'votes': votes,
      'cover': image,
      'url': url,
    };
  }

  factory NominatedBooksModel.fromMap(Map<String, dynamic> map) {
    return NominatedBooksModel(
      bookId: map['book_id'],
      bookName: map['name'],
      author: map['author'],
      votes: map['votes'],
      image: map['cover'],
      url: map['url'],
    );
  }
}
