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
  late NominatedBooksRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    httpClient = MockHttpClient();
    dataSourceImpl = NominatedBooksRemoteDataSourceImpl(client: httpClient);
  });

  final testJson = [
    {
      "book_id": 52861201,
      "name": "From Blood and Ash",
      "author": "Jennifer L. Armentrou",
      "votes": 70896,
      "cover": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true"
    },
    {
      "book_id": 52867387,
      "name": "Beach Read",
      "author": "Emily Henr",
      "votes": 60124,
      "cover": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1589881197l/52867387._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/52867387-beach-read?from_choice=true"
    },
  ];

  group('getNominatedBooks', () {
    test('should perform a GET request', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getNominatedBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      await dataSourceImpl.getNominatedBooks();

      // assert
      verify(
        httpClient.get(
          Uri.parse(ApiEndpoints.getNominatedBooksUrl),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('should return a list of NominatedBooksEntity on success 200',
            () async {
          // arrange

          when(httpClient.get(
            Uri.parse(ApiEndpoints.getNominatedBooksUrl),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

          // act
          final result = await dataSourceImpl.getNominatedBooks();

          // assert
          expect(result, isA<List<NominatedBooksEntity>>());
        });

    test('should throw ServerException on failure', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getNominatedBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 500));

      // act
      final result = dataSourceImpl.getNominatedBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
