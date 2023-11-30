import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'book_detail', primaryKeys: ['id'])
class BookDetailEntity extends Equatable {
  const BookDetailEntity({
    this.id,
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

  final int? id;
  final int? bookId;
  final String? name;
  final String? image;
  final String? url;
  @ColumnInfo(name: 'author')
  final List<String>? author;
  final double? rating;
  final int? pages;
  final String? publishedDate;
  final String? synopsis;

  bool get isNotEmpty {
    return bookId != null &&
        name != null &&
        url != null &&
        image != null &&
        rating != null &&
        (author?.isNotEmpty ?? false) &&
        pages != null &&
        publishedDate != null &&
        synopsis != null;
  }

  @override
  List<Object?> get props => [
        id,
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
