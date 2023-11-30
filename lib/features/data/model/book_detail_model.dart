import 'package:e_book/features/domain/entity/book_detail_entity.dart';

class BookDetailModel extends BookDetailEntity {
  const BookDetailModel({
    int? id,
    int? bookId,
    String? name,
    String? image,
    String? url,
    List<String>? author,
    double? rating,
    int? pages,
    String? publishedDate,
    String? synopsis,
  }) : super(
          id: id,
          bookId: bookId,
          name: name,
          image: image,
          url: url,
          author: author,
          rating: rating,
          pages: pages,
          publishedDate: publishedDate,
          synopsis: synopsis,
        );

  @override
  List<Object?> get props => [
        id,
        bookId,
        name,
        image,
        url,
        author,
        rating,
        pages,
        publishedDate,
        synopsis,
      ];

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'name': name,
      'cover': image,
      'url': url,
      'authors': List<String>.from(author!.map((x) => x)),
      'rating': rating,
      'pages': pages,
      'published_date': publishedDate,
      'synopsis': synopsis,
    };
  }

  factory BookDetailModel.fromMap(Map<String, dynamic> map) {
    return BookDetailModel(
      bookId: map['book_id'],
      name: map['name'],
      image: map['cover'],
      url: map['url'],
      author: List<String>.from(map["authors"].map((x) => x)),
      rating: map['rating'],
      pages: map['pages'],
      publishedDate: map['published_date'],
      synopsis: map['synopsis'],
    );
  }
}
