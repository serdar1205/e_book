import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/usecases/get_author_info_usecasae.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAuthorInfoRepository repository;
  late GetAuthorInfoUseCase useCase;

  final testJson = fixtureReader('author_info.json');
  final testModel = AuthorInfoModel.fromMap(jsonDecode(testJson));
  final authorId = testModel.authorId;

  setUp(() {
    repository = MockAuthorInfoRepository();
    useCase = GetAuthorInfoUseCase(repository);
  });

  test('should get AuthorInfo from repository ', () async {
    //arrange
    when(repository.getAuthorInfo(authorId))
        .thenAnswer((realInvocation) async => Right(testModel));
    //actual
    final result = await useCase.execute(authorId!);
    verify(repository.getAuthorInfo(authorId));

    expect(result, Right(testModel));
  });
}
