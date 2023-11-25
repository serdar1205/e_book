
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'dart:convert';

abstract class NominatedBooksRemoteDataSource {
  Future<List<NominatedBooksEntity>> getNominatedBooks();
}

class NominatedBooksRemoteDataSourceImpl extends NominatedBooksRemoteDataSource {
  late final http.Client client;

  NominatedBooksRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NominatedBooksEntity>> getNominatedBooks() async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final headers = {
      ApiEndpoints.headerApiKey: ApiEndpoints.headerApiKeyValue,
      ApiEndpoints.headerApiHost: ApiEndpoints.headerApiHostValue,
    };

    final response = await client.get(
        Uri.parse(ApiEndpoints.getNominatedBooksUrl),
        headers: headers);

    if (response.statusCode == 200) {
      print(response.body.toString());
      final responseBody = json.decode(response.body) as List;
      return responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
