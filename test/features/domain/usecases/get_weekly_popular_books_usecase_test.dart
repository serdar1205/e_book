import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeeklyPopularBooksRepository repository;
  late GetWeeklyPopularBooksUseCase useCase;

  final testJson = fixtureReader('weekly_popular_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => WeeklyPopularBooksModel.fromMap(e)).toList();

  setUp(() {
    repository = MockWeeklyPopularBooksRepository();
    useCase = GetWeeklyPopularBooksUseCase(repository);
  });

  test('should get WeeklyPopularBooks from repository ', () async {
    //arrange
    when(repository.getWeeklyPopularBooks())
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute();
    verify(repository.getWeeklyPopularBooks());

    expect(result, Right(testModel));
  });
}
