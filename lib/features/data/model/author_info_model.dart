import 'package:e_book/features/domain/entity/author_info_entity.dart';

class AuthorInfoModel extends AuthorInfoEntity {
  const AuthorInfoModel({
    int? authorId,
    String? name,
    String? image,
    double? rating,
    String? info,
    List<String>? genres,
    // String? born,
    //  String? died,
    List<AuthorBooks>? authorBooks,
  }) : super(
          authorId: authorId,
          name: name,
          image: image,
          rating: rating,
          info: info,
          genres: genres,
          //     born: born,
          //       died: died,
          authorBooks: authorBooks,
        );

  factory AuthorInfoModel.fromMap(Map<String, dynamic> map) {
    return AuthorInfoModel(
      authorId: map["author_id"] ?? 0,
      name: map["name"] ?? '',
      image: map["image"] ?? '',
      rating: map["rating"] ?? 0.0,
      info: map["info"] ?? '',
      genres: List<String>.from(map["genres"].map((x) => x)),
      // born: map["born"] ?? '',
      //  died: map["died"] ?? '',
      authorBooks: List<AuthorBooks>.from(map['author_books'].map<AuthorBooks>(
          (e) => AuthorBooks.fromMap(
              e as Map<String, dynamic>))), // map["author_books"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "author_id": authorId,
      "name": name,
      "image": image,
      "rating": rating,
      "info": info,
      "genres": List<dynamic>.from(genres!.map((x) => x)),
      //"born": born,
      // "died": died,
      "author_books": List<dynamic>.from(authorBooks!.map((x) => x.toMap())),
    };
  }

  @override
  List<Object?> get props => [
        authorId,
        name,
        image,
        rating,
        info,
        //  born,
        //    died,
        authorBooks,
      ];
}
