import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/most_popular_authors_cache.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_authors_repository.dart';
import '../datasource/remote/most_popular_author_remote_api.dart';


class MostPopularAuthorsRepositoryImpl extends MostPopularAuthorsRepository {
  final NetworkInfo networkInfo;
//  final MostPopularAuthorsCache localDataSource;
  MostPopularAuthorsRemoteDataSource mostPopularAuthorsRemoteDataSource;

  MostPopularAuthorsRepositoryImpl({
  //  required this.localDataSource,
    required this.networkInfo,
    required this.mostPopularAuthorsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<MostPopularAuthorsEntity>>>
      getMostPopularAuthors() async {
    final isConnected = await networkInfo.isConnected;

   // try {
      // Attempt to get data from the local data source
   //   final cachedData = await localDataSource.getCachedData();

      // If there's cached data, return it
      // if (cachedData.isNotEmpty) {
      //   try {
      //     return Right(cachedData);
      //   } on CacheException {
      //     return Left(CacheFailure());
      //   }
      // } else
       if (isConnected) {
        try {
          // If no cached data, fetch from the remote source
          final result =
              await mostPopularAuthorsRemoteDataSource.getPopularAuthors();
          // Cache the remote data locally
       //   await localDataSource.cacheData(result);

          return Right(result);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ConnectionFailure());
      }
   // }
    // catch (e) {
    //   rethrow;
    // }
  }
}
