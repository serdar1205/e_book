import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';

class MostPopularAuthorModel extends MostPopularAuthorsEntity {
  const MostPopularAuthorModel({
    int? id,
    required int authorId,
    required String name,
    required String url,
    required String image,
    required String popularBookTitle,
    required String popularBookUrl,
    required int numberPublishedBooks,
  }) : super(
          id: id,
          authorId: authorId,
          name: name,
          url: url,
          image: image,
          popularBookTitle: popularBookTitle,
          popularBookUrl: popularBookUrl,
          numberPublishedBooks: numberPublishedBooks,
        );

  Map<String, dynamic> toMap() {
    return {
      "author_id": authorId,
      "name": name,
      "image": image,
      "url": url,
      "popular_book_title": popularBookTitle,
      "popular_book_url": popularBookUrl,
      "number_published_books": numberPublishedBooks,
    };
  }

  factory MostPopularAuthorModel.fromMap(Map<String, dynamic> map) {
    return MostPopularAuthorModel(
      authorId: map["author_id"],
      name: map["name"],
      image: map["image"],
      url: map["url"],
      popularBookTitle: map["popular_book_title"],
      popularBookUrl: map["popular_book_url"],
      numberPublishedBooks: map["number_published_books"],
    );
  }

  factory MostPopularAuthorModel.fromEntity(MostPopularAuthorsEntity entity) {
    return MostPopularAuthorModel(
      authorId: entity.authorId!,
      name: entity.name!,
      image: entity.image!,
      url: entity.url!,
      popularBookTitle: entity.popularBookTitle!,
      popularBookUrl: entity.popularBookUrl!,
      numberPublishedBooks: entity.numberPublishedBooks!,
    );
  }

  // MostPopularAuthorsEntity toEntity() {
  //   return MostPopularAuthorsEntity(
  //     authorId: authorId,
  //     name: name,
  //     image: image,
  //     url: url,
  //     popularBookTitle: popularBookTitle,
  //     popularBookUrl: popularBookUrl,
  //     numberPublishedBooks: numberPublishedBooks,
  //   );
  // }

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
