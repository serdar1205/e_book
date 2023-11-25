import 'dart:convert';

import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/datasource/remote/remote_datasources.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AwardedBooksRemoteDataSourceImpl dataSource;

  final testJson = [
    {
      "book_id": "56597885",
      "name": "Beautiful World, Where Are You",
      "category": "Fiction",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg",
      "url": "https://www.goodreads.com/choiceawards/best-fiction-books-2021"
    },
    {
      "book_id": "58744977",
      "name": "The Last Thing He Told Me",
      "category": "Mystery & Thriller",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1628623381l/58744977._SY475_.jpg",
      "url":
          "https://www.goodreads.com/choiceawards/best-mystery-thriller-books-2021"
    },
  ];

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AwardedBooksRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAwardedBooks', () {
    test('should perform a GET request', () async {
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAwardedBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer(
          (realInvocation) async => http.Response(json.encode(testJson), 200));

      //act
      await dataSource.getAwardedBooks();

      //assert
      verify(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAwardedBooksUrl),
        headers: anyNamed('headers'),
      ));
    });

    test('should return a list of AwardedBooksEntity on success 200', () async {
      // arrange

      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAwardedBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      final result = await dataSource.getAwardedBooks();

      // assert
      expect(result, isA<List<AwardedBooksEntity>>());
    });

    test('should throw ServerException on failure', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(ApiEndpoints.getAwardedBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 500));

      // act
      final result = dataSource.getAwardedBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
