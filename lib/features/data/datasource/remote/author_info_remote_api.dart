import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'dart:convert';

abstract class AuthorInfoRemoteDataSource {
  Future<AuthorInfoEntity> getAuthorInfo(int authorId);
}

class AuthorInfoRemoteDataSourceImpl extends AuthorInfoRemoteDataSource {
  late final http.Client client;

  AuthorInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthorInfoEntity> getAuthorInfo(int authorId) async {
    //print('authorRemoteDataSource +++++++++++++++++++');

    final headers = {
      ApiEndpoints.headerApiKey: ApiEndpoints.headerApiKeyValue,
      ApiEndpoints.headerApiHost: ApiEndpoints.headerApiHostValue,
    };

    final response = await client.get(
        Uri.parse(ApiEndpoints.getAuthorInfoUrl+authorId.toString()),
        headers: headers);

    if (response.statusCode == 200) {
     // print(response.body.toString());
     // final responseBody = json.decode(response.body) as List;
      return AuthorInfoModel.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
