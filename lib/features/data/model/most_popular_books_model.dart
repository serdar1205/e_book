import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';

class MostPopularBooksModel extends MostPopularBooksEntity {
  const MostPopularBooksModel({
    int? bookId,
    String? name,
    String? image,
    double? rating,
    String? url,
  }) : super(
          bookId: bookId,
          name: name,
          image: image,
          rating: rating,
          url: url,
        );

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'name': name,
      'cover': image,
      'rating': rating,
      'url': url,
    };
  }

  factory MostPopularBooksModel.fromMap(Map<String, dynamic> map) {
    return MostPopularBooksModel(
      bookId: int.parse(map['book_id']),
      name: map['name'] ,
      image: map['cover'],
      rating: map['rating'],
      url: map['url'] ,
    );
  }

  @override
  List<Object?> get props => [
        bookId,
        name,
        image,
        rating,
        url,
      ];
}
