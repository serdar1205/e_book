import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';

import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/most_popular_books_remote_api.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_books_repository.dart';

class MostPopularBooksRepositoryImpl extends MostPopularBooksRepository {
  final NetworkInfo networkInfo;

  MostPopularBooksRemoteDataSource mostPopularBooksRemoteDataSource;

  MostPopularBooksRepositoryImpl({
    required this.networkInfo,
    required this.mostPopularBooksRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<MostPopularBooksEntity>>>
      getMostPopularBooks() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try {
        final result = await mostPopularBooksRemoteDataSource.getPopularBooks();
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
