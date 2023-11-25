import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/entity/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchBooksEntity>>> searchBooksByName(String bookName);
}