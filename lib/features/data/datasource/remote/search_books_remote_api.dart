// import 'package:e_book/features/data/model/search_model.dart';
// import 'package:e_book/features/domain/entity/search_entity.dart';
// import 'package:http/http.dart' as http;
// import 'package:e_book/core/constants/api.dart';
// import 'package:e_book/core/errors/exceptions.dart';
// import 'dart:convert';
//
// abstract class SearchBooksRemoteDataSource {
//   Future<List<SearchBooksEntity>> searchBooksByName(String bookName);
// }
//
// class SearchBooksRemoteDataSourceImpl extends SearchBooksRemoteDataSource {
//   late final http.Client client;
//
//   SearchBooksRemoteDataSourceImpl({required this.client});
//
//   @override
//   Future<List<SearchBooksEntity>> searchBooksByName(String bookName) async {
//     //print('authorRemoteDataSource +++++++++++++++++++');
//
//     final headers = {
//       ApiEndpoints.headerApiKey: ApiEndpoints.headerApiKeyValue,
//       ApiEndpoints.headerApiHost: ApiEndpoints.headerApiHostValue,
//     };
//
//     final response = await client.get(
//         Uri.parse(ApiEndpoints.searchBooksByNameUrl+bookName),
//         headers: headers);
//
//     if (response.statusCode == 200) {
//       print(response.body.toString());
//       final responseBody = json.decode(response.body) as List;
//       return responseBody.map((e) => SearchBooksModel.fromMap(e)).toList();
//     } else {
//       throw ServerException();
//     }
//   }
// }
