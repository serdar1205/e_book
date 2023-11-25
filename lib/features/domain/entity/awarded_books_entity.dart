import 'package:equatable/equatable.dart';
// Annotate a Dart class to create a box
class AwardedBooksEntity extends Equatable {
  const AwardedBooksEntity({
    this.bookId,
    this.name,
    this.winningCategory,
    this.image,
    this.url,
  });

  final int? bookId;
  final String? name;
  final String? image;
  final String? url;
  final String? winningCategory;


  @override
  List<Object?> get props => [
    bookId,
    name,
    url,
    image,
    winningCategory,
  ];
}
