import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/domain/repositories/awarded_books_repository.dart';

class GetAwardedBooksUseCase {
  final AwardedBooksRepository repository;

  GetAwardedBooksUseCase(this.repository);

  Future<Either<Failure, List<AwardedBooksEntity>>> execute() async {
    return await repository.getAwardedBooks();
  }
}