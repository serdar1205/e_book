import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/book_detail_remote_api.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/domain/repositories/book_detail_repository.dart';

class BookDetailRepositoryImpl extends BookDetailRepository {
  final NetworkInfo networkInfo;
  BookDetailsRemoteDataSource bookDetailsRemoteDataSource;

  BookDetailRepositoryImpl({
    required this.networkInfo,
    required this.bookDetailsRemoteDataSource,
  });

  @override
  Future<Either<Failure, BookDetailEntity>> getBookDetails(int bookId) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try{
        final result = await bookDetailsRemoteDataSource.getBookDetails(bookId);
        //  print('authorRemoteDataSource +++++++++++++++++++');
        return Right(result);
      }on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

