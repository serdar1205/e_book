
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'dart:convert';

abstract class BookDetailsRemoteDataSource {
  Future<BookDetailEntity> getBookDetails(int bookId);
}

class BookDetailsRemoteDataSourceImpl extends BookDetailsRemoteDataSource {
  late final http.Client client;

  BookDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<BookDetailEntity> getBookDetails(int bookId) async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final headers = {
      ApiEndpoints.headerApiKey: ApiEndpoints.headerApiKeyValue,
      ApiEndpoints.headerApiHost: ApiEndpoints.headerApiHostValue,
    };

    final response = await client.get(
        Uri.parse(ApiEndpoints.getBookDetailsUrl+bookId.toString()),
        headers: headers);

    if (response.statusCode == 200) {
      print(response.body.toString());
     // final responseBody = json.decode(response.body) as List;
      return  BookDetailModel.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
