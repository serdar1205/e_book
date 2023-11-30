// Annotate a Dart class to create a box
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';


@Entity(tableName: 'weekly_popular_books', primaryKeys: ['id'])
class WeeklyPopularBooksEntity extends Equatable {
  const WeeklyPopularBooksEntity({
    this.id,
    this.bookId,
    this.name,
    this.url,
    this.image,
  });

  final int? id;
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
