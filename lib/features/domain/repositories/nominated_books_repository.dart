import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';

abstract class NominatedBooksRepository {
  Future<Either<Failure, List<NominatedBooksEntity>>> getNominatedBooks();
}
