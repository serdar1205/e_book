import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';

abstract class AwardedBooksRepository {
  Future<Either<Failure, List<AwardedBooksEntity>>> getAwardedBooks();
}