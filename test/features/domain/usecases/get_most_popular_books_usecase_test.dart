import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockMostPopularBooksRepository repository;
  late GetMostPopularBooksUseCase useCase;

  final testJson = fixtureReader('most_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
  responseBody.map((e) => MostPopularBooksModel.fromMap(e)).toList();

  setUp(() {
    repository = MockMostPopularBooksRepository();
    useCase = GetMostPopularBooksUseCase(repository);
  });

  test('should get MostPopularBooks from repository ', () async {
    //arrange
    when(repository.getMostPopularBooks())
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute();
    verify(repository.getMostPopularBooks());

    expect(result, Right(testModel));
  });
}
