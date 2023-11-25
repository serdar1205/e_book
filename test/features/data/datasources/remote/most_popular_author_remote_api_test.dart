import 'dart:convert';

import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:http/http.dart' as http;
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/features/data/datasource/remote/most_popular_author_remote_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient httpClient;
 late MostPopularAuthorsRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    httpClient = MockHttpClient();
    dataSourceImpl = MostPopularAuthorsRemoteDataSourceImpl(client: httpClient);
  } );

  final testJson = [
    {
      "author_id": 3389,
      "name": "Stephen King",
      "image": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      "url": "https://www.goodreads.com/author/show/3389.Stephen_King",
      "popular_book_title": "The Shining",
      "popular_book_url": "https://www.goodreads.com/book/show/11588.The_Shining",
      "number_published_books": 2567
    },
    {
      "author_id": 5430144,
      "name": "Colleen Hoover",
      "image": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1464032240i/5430144._UY150_CR0,0,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      "url": "https://www.goodreads.com/author/show/5430144.Colleen_Hoover",
      "popular_book_title": "It Ends with Us",
      "popular_book_url": "https://www.goodreads.com/book/show/27362503-it-ends-with-us",
      "number_published_books": 80
    },
  ];

  group('getMostPopularAuthors', () {
    test('should perform a GET request', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularAuthorsUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      await dataSourceImpl.getPopularAuthors();

      // assert
      verify(
        httpClient.get(
          Uri.parse(ApiEndpoints.getMostPopularAuthorsUrl),
          headers:anyNamed('headers'),
        ),
      );
    });

    test('should return a list of MostPopularAuthorsEntity on success 200', () async {
      // arrange

      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularAuthorsUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      final result = await dataSourceImpl.getPopularAuthors();

      // assert
      expect(result, isA<List<MostPopularAuthorsEntity>>());
    });

    test('should throw ServerException on failure', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getMostPopularAuthorsUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 500));

      // act
      final result = dataSourceImpl.getPopularAuthors();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

}