import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/domain/repositories/book_detail_repository.dart';

class GetBookDetailsUseCase {
  final BookDetailRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<Either<Failure, BookDetailEntity>> execute(int bookId) async {
    return await repository.getBookDetails(bookId);
  }
}