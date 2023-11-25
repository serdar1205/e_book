import 'dart:convert';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/datasource/remote/remote_datasources.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient httpClient;
  late MostPopularBooksRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    httpClient = MockHttpClient();
    dataSourceImpl = MostPopularBooksRemoteDataSourceImpl(client: httpClient);
  });

  final testJson = [
    {
      "book_id": "58283080",
      "position": "1",
      "name": "Hook, Line, and Sinker (Bellinger Sisters, #2)",
      "cover":
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
      "rating": 3.95,
      "url": "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker"
    },
    {
      "book_id": "58438583",
      "position": "2",
      "name": "One Italian Summer",
      "cover":
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1626799802i/58438583.jpg",
      "rating": 3.6,
      "url": "https://www.goodreads.com/book/show/58438583-one-italian-summer"
    },
  ];

  group('getPopularBooks', () {
    test('should perform a GET request', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      await dataSourceImpl.getPopularBooks();

      // assert
      verify(
        httpClient.get(
          Uri.parse(ApiEndpoints.getMostPopularBooksUrl),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('should return a list of MostPopularBooksEntity on success 200',
        () async {
      // arrange

      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      final result = await dataSourceImpl.getPopularBooks();

      // assert
      expect(result, isA<List<MostPopularBooksEntity>>());
    });

    test('should throw ServerException on failure', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 500));

      // act
      final result = dataSourceImpl.getPopularBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
