import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';



@Entity(tableName: 'authors', primaryKeys: ['id'])
class MostPopularAuthorsEntity extends Equatable {
  const MostPopularAuthorsEntity({
    this.id,
    this.authorId,
    this.name,
    this.url,
    this.image,
    this.popularBookTitle,
    this.popularBookUrl,
    this.numberPublishedBooks,
  });

  final int? id;
  final int? authorId;
  final String? name;

  final String? image;

  final String? url;

  final String? popularBookTitle;

  final String? popularBookUrl;

  final int? numberPublishedBooks;

  @override
  List<Object?> get props => [
        authorId,
        name,
        url,
        image,
        popularBookTitle,
        popularBookUrl,
        numberPublishedBooks,
      ];
}
