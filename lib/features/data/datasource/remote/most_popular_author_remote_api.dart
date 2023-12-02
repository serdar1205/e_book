import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class MostPopularAuthorsRemoteDataSource {
  Future<List<MostPopularAuthorsEntity>> getPopularAuthors();
}

class MostPopularAuthorsRemoteDataSourceImpl extends MostPopularAuthorsRemoteDataSource {
  late final http.Client client;

  MostPopularAuthorsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MostPopularAuthorsEntity>> getPopularAuthors() async {
    //print('authorRemoteDataSource +++++++++++++++++++');


    final response =
    await rootBundle.loadString('assets/json/most_popular_authors.json');
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
     // print(response.body.toString());
      final responseBody = json.decode(response) as List;
      return responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
