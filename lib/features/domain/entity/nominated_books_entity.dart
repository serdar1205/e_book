import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';


@Entity(tableName: 'nominated_books', primaryKeys: ['id'])
class NominatedBooksEntity extends Equatable {
  const NominatedBooksEntity({
    this.id,
    this.bookId,
    this.bookName,
    this.url,
    this.author,
    this.votes,
    this.image,
  });

  final int? id;
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
