import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';

abstract class MostPopularBooksRepository {
  Future<Either<Failure, List<MostPopularBooksEntity>>> getMostPopularBooks();
}