import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class AwardedBooksRemoteDataSource {
  Future<List<AwardedBooksEntity>> getAwardedBooks();
}

class AwardedBooksRemoteDataSourceImpl extends AwardedBooksRemoteDataSource {
  late final http.Client client;

  AwardedBooksRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AwardedBooksEntity>> getAwardedBooks() async {
    final response =
        await rootBundle.loadString('assets/json/awarded_books.json');
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // print(response.body.toString());
      final responseBody = json.decode(response) as List;
      return responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
