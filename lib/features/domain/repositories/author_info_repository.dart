
import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';

abstract class AuthorInfoRepository {
  Future<Either<Failure, AuthorInfoEntity>> getAuthorInfo(int authorId);
}