// Annotate a Dart class to create a box
import 'package:equatable/equatable.dart';

class MostPopularBooksEntity extends Equatable {
  const MostPopularBooksEntity({
    this.bookId,
    this.name,
    this.image,
    this.url,
    this.rating,
  });

  final int? bookId;
  final String? name;
  final String? image;
  final double? rating;

  final String? url;

  @override
  List<Object?> get props => [
        bookId,
        name,
        image,
        url,
        rating,
      ];
}
