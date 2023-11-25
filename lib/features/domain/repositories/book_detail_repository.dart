import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';

abstract class BookDetailRepository {
  Future<Either<Failure, BookDetailEntity>> getBookDetails(int bookId);
}