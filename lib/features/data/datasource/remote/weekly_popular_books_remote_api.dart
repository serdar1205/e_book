import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class WeeklyPopularBooksRemoteDataSource {
  Future<List<WeeklyPopularBooksEntity>> getWeeklyPopularBooks();
}

class WeeklyPopularBooksRemoteDataSourceImpl
    extends WeeklyPopularBooksRemoteDataSource {
  late final http.Client client;

  WeeklyPopularBooksRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WeeklyPopularBooksEntity>> getWeeklyPopularBooks() async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final response =
        await rootBundle.loadString('assets/json/weekly_popular_books.json');
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      final responseBody = json.decode(response) as List;
      return responseBody
          .map((e) => WeeklyPopularBooksModel.fromMap(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
