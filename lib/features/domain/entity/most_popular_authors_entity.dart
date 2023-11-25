import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
part 'most_popular_authors_entity.g.dart';

@HiveType(typeId: 1)
class MostPopularAuthorsEntity extends Equatable {
  const MostPopularAuthorsEntity({
    this.authorId,
    this.name,
    this.url,
    this.image,
    this.popularBookTitle,
    this.popularBookUrl,
    this.numberPublishedBooks,
  });

  @HiveField(0)
  final int? authorId;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String? url;
  @HiveField(4)
  final String? popularBookTitle;
  @HiveField(5)
  final String? popularBookUrl;
  @HiveField(6)
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
