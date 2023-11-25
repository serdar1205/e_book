import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockNominatedBooksRepository repository;
  late GetNominatedBooksUseCase useCase;

  final testJson = fixtureReader('nominated_books.json');
  final responseBody = json.decode(testJson) as List;
  final testModel =
  responseBody.map((e) => NominatedBooksModel.fromMap(e)).toList();

  setUp(() {
    repository = MockNominatedBooksRepository();
    useCase = GetNominatedBooksUseCase(repository);
  });

  test('should get NominatedBooks from repository ', () async {
    //arrange
    when(repository.getNominatedBooks())
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute();
    verify(repository.getNominatedBooks());

    expect(result, Right(testModel));
  });
}
