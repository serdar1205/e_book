import 'package:equatable/equatable.dart';

// Annotate a Dart class to create a box
class AuthorInfoEntity extends Equatable {
  const AuthorInfoEntity({
    this.authorId,
    this.name,
    this.image,
    this.info,
    this.rating,
    this.genres,
    this.authorBooks,
  });

  final int? authorId;
  final String? name;
  final String? image;
  final double? rating;
  final String? info;
  final List<String>? genres;
  final List<AuthorBooks>? authorBooks;

  @override
  List<Object?> get props => [
        authorId,
        name,
        info,
        image,
        rating,
        genres,
        authorBooks,
      ];
}


class AuthorBooks extends Equatable {

  final String? url;
  final String? bookId;
  final String? name;
  final double? rating;
  final int? date;

  const AuthorBooks({this.url, this.name, this.rating, this.date,this.bookId});

  @override
  List<Object?> get props => [url, name, rating, date,bookId];

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'rating': rating,
      'date': date,
      'bookId': bookId,
    };
  }

  factory AuthorBooks.fromMap(Map<String, dynamic> map) {
    return AuthorBooks(
      url: map['url'],
      name: map['name'],
      rating: map['rating'],
      date: map['date'],
      bookId: map['bookId'],
    );
  }
}
