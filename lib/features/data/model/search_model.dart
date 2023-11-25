import 'package:e_book/features/domain/entity/search_entity.dart';

class SearchBooksModel extends SearchBooksEntity {
  const SearchBooksModel({
    int? bookId,
    String? name,
    String? image,
    String? url,
    List<String>? authors,
    double? rating,
    int? createdEditions,
    int? year,
  }) : super(
          bookId: bookId,
          name: name,
          image: image,
          url: url,
          authors: authors,
          rating: rating,
          createdEditions: createdEditions,
          year: year,
        );

  @override
  List<Object?> get props => [
        bookId,
        name,
        image,
        url,
        authors,
        rating,
        createdEditions,
        year,
      ];

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'name': name,
      'image': image,
      'url': url,
      'authors': authors,
      'rating': rating,
      'createdEditions': createdEditions,
      'year': year,
    };
  }

  factory SearchBooksModel.fromMap(Map<String, dynamic> map) {
    return SearchBooksModel(
      bookId: map['bookId'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
      authors: map['authors'] as List<String>,
      rating: map['rating'] as double,
      createdEditions: map['createdEditions'] as int,
      year: map['year'] as int,
    );
  }
}
