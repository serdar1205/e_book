import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/search_entity.dart';
import 'package:e_book/features/domain/repositories/search_repository.dart';

class GetSearchUseCase {
  final SearchRepository repository;

  GetSearchUseCase(this.repository);

  Future<Either<Failure, List<SearchBooksEntity>>> execute(String bookName) async {
    return await repository.searchBooksByName(bookName);
  }
}