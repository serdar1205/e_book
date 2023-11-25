import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';

abstract class MostPopularAuthorsRepository {
  Future<Either<Failure, List<MostPopularAuthorsEntity>>> getMostPopularAuthors();
}
