import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';

class WeeklyPopularBooksModel extends WeeklyPopularBooksEntity {
  const WeeklyPopularBooksModel({
    int? bookId,
    String? name,
    String? image,
    String? url,
  }) : super(
          bookId: bookId,
          name: name,
          image: image,
          url: url,
        );

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'name': name,
      'cover': image,
      'url': url,
    };
  }

  factory WeeklyPopularBooksModel.fromMap(Map<String, dynamic> map) {
    return WeeklyPopularBooksModel(
      bookId: map['book_id'],
      name: map['name'],
      image: map['cover'],
      url: map['url'] ,
    );
  }

  @override
  List<Object?> get props => [bookId, name, image, url];
}
