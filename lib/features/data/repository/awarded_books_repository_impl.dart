import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/awarded_books_remote_api.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/domain/repositories/awarded_books_repository.dart';

class AwardedBooksRepositoryImpl extends AwardedBooksRepository {
  NetworkInfo networkInfo;
  AwardedBooksRemoteDataSource remoteDataSource;

  AwardedBooksRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<AwardedBooksEntity>>> getAwardedBooks() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try {
        final result = await remoteDataSource.getAwardedBooks();
        //  print('authorRemoteDataSource +++++++++++++++++++');
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
