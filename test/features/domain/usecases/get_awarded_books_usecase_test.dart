import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAwardedBooksRepository repository;
  late GetAwardedBooksUseCase useCase;

  final testJson = fixtureReader('awarded_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
      responseBody.map((e) => AwardedBooksModel.fromMap(e)).toList();

  setUp(() {
    repository = MockAwardedBooksRepository();
    useCase = GetAwardedBooksUseCase(repository);
  });

  test('should get AwardedBooks from repository ', () async {
    //arrange
    when(repository.getAwardedBooks())
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute();
    verify(repository.getAwardedBooks());

    expect(result, Right(testModel));
  });
}
