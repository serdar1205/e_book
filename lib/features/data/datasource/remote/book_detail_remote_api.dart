import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/utils/reader.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BookDetailsRemoteDataSource {
  Future<BookDetailEntity> getBookDetails(int bookId);
}

class BookDetailsRemoteDataSourceImpl extends BookDetailsRemoteDataSource {
  late final http.Client client;

  late String testJson;
  late final testAuthorInfoModel;
  late final bookId;

  BookDetailsRemoteDataSourceImpl({required this.client});

  int getId() {
    testJson = reader('book_detail.json');
    testAuthorInfoModel = AuthorInfoModel.fromMap(json.decode(testJson));
    bookId = testAuthorInfoModel.bookId;
    return bookId;
  }

  @override
  Future<BookDetailEntity> getBookDetails(getId) async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final response =
        await rootBundle.loadString('assets/json/book_detail.json');
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // final responseBody = json.decode(response.body) as List;
      return BookDetailModel.fromMap(json.decode(response));
    } else {
      throw ServerException();
    }
  }
}
