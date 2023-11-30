import 'dart:convert';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

class AuthorBooksConverter extends TypeConverter<List<AuthorBooks>?, String?> {
  @override
  List<AuthorBooks>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }

    final List<dynamic> jsonList = json.decode(databaseValue);
    return jsonList.map((json) => AuthorBooks.fromMap(json)).toList();
  }

  @override
  String? encode(List<AuthorBooks>? value) {
    if (value == null) {
      return null;
    }

    final List<Map<String, dynamic>> jsonList =
    value.map((authorBooks) => authorBooks.toMap()).toList();
    return json.encode(jsonList);
  }
}
