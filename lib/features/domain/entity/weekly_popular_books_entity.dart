// Annotate a Dart class to create a box
import 'package:equatable/equatable.dart';

class WeeklyPopularBooksEntity extends Equatable {
  const WeeklyPopularBooksEntity({
    this.bookId,
    this.name,
    this.url,
    this.image,
  });

  final int? bookId;
  final String? name;
  final String? image;
  final String? url;

  @override
  List<Object?> get props => [
        bookId,
        name,
        url,
        image,
      ];
}
