import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockBookDetailRepository repository;
  late GetBookDetailsUseCase useCase;

  final testJson = fixtureReader('book_detail.json');
  final testModel = BookDetailModel.fromMap(jsonDecode(testJson));
  final bookId = testModel.bookId;

  setUp(() {
    repository = MockBookDetailRepository();
    useCase = GetBookDetailsUseCase(repository);
  });

  test('should get BookDetail from repository ', () async {
    //arrange
    when(repository.getBookDetails(bookId))
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute(bookId!);
    verify(repository.getBookDetails(bookId));

    expect(result, Right(testModel));
  });
}
