import 'package:equatable/equatable.dart';

class BookDetailEntity extends Equatable {
  const BookDetailEntity({
    this.bookId,
    this.name,
    this.image,
    this.url,
    this.author,
    this.rating,
    this.pages,
    this.publishedDate,
    this.synopsis,
  });

  final int? bookId;
  final String? name;
  final String? image;
  final String? url;
  final List<String>? author;
  final double? rating;
  final int? pages;
  final String? publishedDate;
  final String? synopsis;

  @override
  List<Object?> get props => [
        bookId,
        name,
        url,
        image,
        author,
        rating,
        pages,
        publishedDate,
        synopsis,
      ];
}
