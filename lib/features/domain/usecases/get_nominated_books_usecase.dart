import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/domain/repositories/nominated_books_repository.dart';

class GetNominatedBooksUseCase {
  final NominatedBooksRepository repository;

  GetNominatedBooksUseCase(this.repository);

  Future<Either<Failure, List<NominatedBooksEntity>>> execute() async {
    return await repository.getNominatedBooks();
  }
}