import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';


@Entity(tableName: 'most_popular_books', primaryKeys: ['id'])
class MostPopularBooksEntity extends Equatable {
  const MostPopularBooksEntity({
    this.id,
    this.bookId,
    this.name,
    this.image,
    this.url,
    this.rating,
  });

  final int? id;
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
