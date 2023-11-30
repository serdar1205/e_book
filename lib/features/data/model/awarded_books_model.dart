import 'package:e_book/features/domain/entity/awarded_books_entity.dart';

class AwardedBooksModel extends AwardedBooksEntity {
  const AwardedBooksModel({
    int? id,
    int? bookId,
    String? name,
    String? image,
    String? url,
    String? winningCategory,
  }) : super(
          id: id,
          bookId: bookId,
          name: name,
          image: image,
          url: url,
          winningCategory: winningCategory,
        );

  factory AwardedBooksModel.fromMap(Map<String, dynamic> map) {
    return AwardedBooksModel(
      bookId: int.parse(map['book_id']),
      name: map['name'] ?? '',
      image: map['cover'] ?? '',
      url: map['url'] ?? '',
      winningCategory: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'name': name,
      'cover': image,
      'url': url,
      'category': winningCategory,
    };
  }

  @override
  List<Object?> get props => [
        bookId,
        name,
        image,
        url,
        winningCategory,
      ];
}
