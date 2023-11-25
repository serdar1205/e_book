import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'dart:convert';

abstract class MostPopularAuthorsRemoteDataSource {
  Future<List<MostPopularAuthorsEntity>> getPopularAuthors();
}

class MostPopularAuthorsRemoteDataSourceImpl extends MostPopularAuthorsRemoteDataSource {
  late final http.Client client;

  MostPopularAuthorsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MostPopularAuthorsEntity>> getPopularAuthors() async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final headers = {
      ApiEndpoints.headerApiKey: ApiEndpoints.headerApiKeyValue,
      ApiEndpoints.headerApiHost: ApiEndpoints.headerApiHostValue,
    };

    final response = await client.get(
        Uri.parse(ApiEndpoints.getMostPopularAuthorsUrl),
        headers: headers);

    if (response.statusCode == 200) {
     // print(response.body.toString());
      final responseBody = json.decode(response.body) as List;
      return responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
