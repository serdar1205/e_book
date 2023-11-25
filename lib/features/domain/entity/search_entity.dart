import 'package:equatable/equatable.dart';

class SearchBooksEntity extends Equatable {
  const SearchBooksEntity({
    this.bookId,
    this.name,
    this.url,
    this.image,
    this.authors,
    this.rating,
    this.createdEditions,
    this.year,
  });

  final int? bookId;
  final String? name;
  final String? image;
  final String? url;
  final List<String>? authors;
  final double? rating;
  final int? createdEditions;
  final int? year;

  @override
  List<Object?> get props => [
        bookId,
        name,
        url,
        image,
        authors,
        rating,
        createdEditions,
        year,
      ];
}
