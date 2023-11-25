import 'dart:convert';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/datasource/remote/remote_datasources.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/data/model/book_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late BookDetailsRemoteDataSourceImpl dataSourceImpl;

  final testJson = fixtureReader('book_detail.json');
  final testModel = BookDetailModel.fromMap(json.decode(testJson));

  final bookId = testModel.bookId;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl =
        BookDetailsRemoteDataSourceImpl(client: mockHttpClient);
  });


  group('getBookDetails', () {

    test('should perform a GET request', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getBookDetailsUrl+bookId.toString()),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(testJson, 200));

      // act
      await dataSourceImpl.getBookDetails(bookId!);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(ApiEndpoints.getBookDetailsUrl + bookId.toString()),
          headers:anyNamed('headers'),
        ),
      );
    });

    test('should return BookDetailModel model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse(ApiEndpoints.getBookDetailsUrl + bookId.toString()),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => http.Response(testJson, 200));

          // act
          final result =
          await dataSourceImpl.getBookDetails(bookId!);

          // assert
          final matcher = testModel;
          expect(result, matcher);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse(ApiEndpoints.getBookDetailsUrl + bookId.toString()),
            headers:anyNamed('headers'),
          )).thenAnswer((_) async => http.Response("Something went wrong", 404));

          // act
          final result = dataSourceImpl.getBookDetails(bookId!);

          // assert

          expect(result, throwsA(isA<ServerException>()));
        });
  });
}
