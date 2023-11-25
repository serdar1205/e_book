import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/weekly_popular_books_remote_api.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/weekly_popular_books_repository.dart';

class WeeklyPopularBooksRepositoryImpl extends WeeklyPopularBooksRepository {
  final NetworkInfo networkInfo;

  WeeklyPopularBooksRemoteDataSource weeklyPopularBooksRemoteDataSource;

  WeeklyPopularBooksRepositoryImpl({
    required this.networkInfo,
    required this.weeklyPopularBooksRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<WeeklyPopularBooksEntity>>> getWeeklyPopularBooks()async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try {
        final result = await weeklyPopularBooksRemoteDataSource.getWeeklyPopularBooks();
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
