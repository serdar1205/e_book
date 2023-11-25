import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_books_repository.dart';

class GetMostPopularBooksUseCase {
  final MostPopularBooksRepository repository;

  GetMostPopularBooksUseCase(this.repository);

  Future<Either<Failure, List<MostPopularBooksEntity>>> execute() async {
    return await repository.getMostPopularBooks();
  }
}