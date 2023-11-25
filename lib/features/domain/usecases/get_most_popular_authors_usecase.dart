import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_authors_repository.dart';

class GetMostPopularAuthorsUseCase {
  final MostPopularAuthorsRepository repository;

  GetMostPopularAuthorsUseCase(this.repository);

  Future<Either<Failure, List<MostPopularAuthorsEntity>>> execute() async {
    return await repository.getMostPopularAuthors();
  }
}
