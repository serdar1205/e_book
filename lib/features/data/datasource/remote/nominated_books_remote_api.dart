
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NominatedBooksRemoteDataSource {
  Future<List<NominatedBooksEntity>> getNominatedBooks();
}

class NominatedBooksRemoteDataSourceImpl extends NominatedBooksRemoteDataSource {
  late final http.Client client;

  NominatedBooksRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NominatedBooksEntity>> getNominatedBooks() async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final response =
    await rootBundle.loadString('assets/json/nominated_books.json');
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      final responseBody = json.decode(response) as List;
      return responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
