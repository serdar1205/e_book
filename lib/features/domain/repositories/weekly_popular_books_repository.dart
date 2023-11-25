import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';

abstract class WeeklyPopularBooksRepository {
  Future<Either<Failure, List<WeeklyPopularBooksEntity>>> getWeeklyPopularBooks();
}