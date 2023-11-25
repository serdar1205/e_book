import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/weekly_popular_books_repository.dart';

class GetWeeklyPopularBooksUseCase {
  final WeeklyPopularBooksRepository repository;

  GetWeeklyPopularBooksUseCase(this.repository);

  Future<Either<Failure, List<WeeklyPopularBooksEntity>>> execute() async {
    return await repository.getWeeklyPopularBooks();
  }
}