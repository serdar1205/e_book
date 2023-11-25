import 'dart:convert';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/datasource/remote/remote_datasources.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AuthorInfoRemoteDataSourceImpl authorInfoRemoteDataSourceImpl;

  final testJson = fixtureReader('author_info.json');
  final testAuthorInfoModel = AuthorInfoModel.fromMap(json.decode(testJson));

  final authorId = testAuthorInfoModel.authorId;

  setUp(() {
    mockHttpClient = MockHttpClient();
    authorInfoRemoteDataSourceImpl =
        AuthorInfoRemoteDataSourceImpl(client: mockHttpClient);
  });


  group('getAuthorInfo', () {

    test('should perform a GET request', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAuthorInfoUrl + authorId.toString()),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(testJson, 200));

      // act
      await authorInfoRemoteDataSourceImpl.getAuthorInfo(authorId!);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(ApiEndpoints.getAuthorInfoUrl + authorId.toString()),
          headers:anyNamed('headers'),
        ),
      );
    });

    test('should return authorInfo model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAuthorInfoUrl + authorId.toString()),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(testJson, 200));

      // act
      final result =
          await authorInfoRemoteDataSourceImpl.getAuthorInfo(authorId!);

      // assert
      final matcher = testAuthorInfoModel;
      expect(result, matcher);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAuthorInfoUrl + authorId.toString()),
        headers:anyNamed('headers'),
      )).thenAnswer((_) async => http.Response("Something went wrong", 404));

      // act
      final result = authorInfoRemoteDataSourceImpl.getAuthorInfo(authorId!);

      // assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
