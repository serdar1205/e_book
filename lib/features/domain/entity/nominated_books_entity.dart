// Annotate a Dart class to create a box
import 'package:equatable/equatable.dart';

class NominatedBooksEntity extends Equatable {
  const NominatedBooksEntity({
    this.bookId,
    this.bookName,
    this.url,
    this.author,
    this.votes,
    this.image,
  });

  final int? bookId;
  final String? bookName;
  final String? author;
  final int? votes;
  final String? image;
  final String? url;



  @override
  List<Object?> get props => [
    bookId,
    bookName,
    url,
    author,
    votes,
    image,
  ];
}
