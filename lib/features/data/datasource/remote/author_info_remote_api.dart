import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/utils/reader.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class AuthorInfoRemoteDataSource {
  Future<AuthorInfoEntity> getAuthorInfo(int authorId);
}

class AuthorInfoRemoteDataSourceImpl extends AuthorInfoRemoteDataSource {
  late final http.Client client;
  late String testJson;
  late final testAuthorInfoModel;
  late final authorId;

  AuthorInfoRemoteDataSourceImpl({required this.client});

  int getId() {
    testJson = reader('author_info.json');
    testAuthorInfoModel = AuthorInfoModel.fromMap(json.decode(testJson));
    authorId = testAuthorInfoModel.authorId;
    return authorId;
  }

  @override
  Future<AuthorInfoEntity> getAuthorInfo(getId) async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final response =
        await rootBundle.loadString('assets/json/author_info.json');
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // print(response.body.toString());
      // final responseBody = json.decode(response.body) as List;
      return AuthorInfoModel.fromMap(json.decode(response));
    } else {
      throw ServerException();
    }
  }
}
