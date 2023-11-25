import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockMostPopularAuthorsRepository repository;
  late GetMostPopularAuthorsUseCase useCase;

  final testJson = fixtureReader('most_popular_authors.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
  responseBody.map((e) => MostPopularAuthorModel.fromMap(e)).toList();

  setUp(() {
    repository = MockMostPopularAuthorsRepository();
    useCase = GetMostPopularAuthorsUseCase(repository);
  });

  test('should get MostPopularAuthors from repository ', () async {
    //arrange
    when(repository.getMostPopularAuthors())
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute();
    verify(repository.getMostPopularAuthors());

    expect(result, Right(testModel));
  });
}
