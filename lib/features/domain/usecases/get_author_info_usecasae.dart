import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/repositories/author_info_repository.dart';

class GetAuthorInfoUseCase {
  final AuthorInfoRepository repository;

  GetAuthorInfoUseCase(this.repository);

  Future<Either<Failure, AuthorInfoEntity>> execute(int authorId) async {
    return await repository.getAuthorInfo(authorId);
  }
}