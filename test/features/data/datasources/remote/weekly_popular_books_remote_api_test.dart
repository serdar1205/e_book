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
  late WeeklyPopularBooksRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    httpClient = MockHttpClient();
    dataSourceImpl = WeeklyPopularBooksRemoteDataSourceImpl(client: httpClient);
  });

  final testJson = [
    {
      "book_id": 62080187,
      "name": "Never Lie",
      "cover": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/62080187-never-lie"
    },
    {
      "book_id": 57795665,
      "name": "The Locked Door",
      "cover": "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618859577l/57795665._SY475_.jpg",
      "url": "https://www.goodreads.com/book/show/57795665-the-locked-door"
    },
  ];

  group('getWeeklyPopularBooks', () {
    test('should perform a GET request', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getWeeklyPopularBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

      // act
      await dataSourceImpl.getWeeklyPopularBooks();

      // assert
      verify(
        httpClient.get(
          Uri.parse(ApiEndpoints.getWeeklyPopularBooksUrl),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('should return a list of WeeklyPopularBooksEntity on success 200',
            () async {
          // arrange

          when(httpClient.get(
            Uri.parse(ApiEndpoints.getWeeklyPopularBooksUrl),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => http.Response(json.encode(testJson), 200));

          // act
          final result = await dataSourceImpl.getWeeklyPopularBooks();

          // assert
          expect(result, isA<List<WeeklyPopularBooksEntity>>());
        });

    test('should throw ServerException on failure', () async {
      // arrange
      when(httpClient.get(
        Uri.parse(ApiEndpoints.getWeeklyPopularBooksUrl),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 500));

      // act
      final result = dataSourceImpl.getWeeklyPopularBooks();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
