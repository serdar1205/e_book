import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'awarded_books', primaryKeys: ['id'])
class AwardedBooksEntity extends Equatable {
  const AwardedBooksEntity({
    this.id,
    this.bookId,
    this.name,
    this.winningCategory,
    this.image,
    this.url,
  });

  final int? id;
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
