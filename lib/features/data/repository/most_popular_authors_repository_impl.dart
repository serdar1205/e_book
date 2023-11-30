import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/authors_cache.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_authors_repository.dart';
import 'package:flutter/foundation.dart';
import '../datasource/remote/most_popular_author_remote_api.dart';

class MostPopularAuthorsRepositoryImpl extends MostPopularAuthorsRepository {
  final NetworkInfo networkInfo;

  final AuthorsCache authorsCache;
  MostPopularAuthorsRemoteDataSource mostPopularAuthorsRemoteDataSource;

  MostPopularAuthorsRepositoryImpl({
    required this.authorsCache,
    required this.networkInfo,
    required this.mostPopularAuthorsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<MostPopularAuthorsEntity>>>
      getMostPopularAuthors() async {
    final bool isConnected = await networkInfo.isConnected;
    final authorsList = await authorsCache.authorsDao.getAuthors();

    if (authorsList.isEmpty) {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected);
    } else {
      print('The database is not empty ${authorsList.length}.');
      return await _fetchCachedData(isConnected, authorsList);
    }
  }

  Future<Either<Failure, List<MostPopularAuthorsEntity>>> _fetchRemoteData(
      bool isConnected) async {
    if (isConnected) {
      try {
        final List<MostPopularAuthorsEntity> remoteData =
            await mostPopularAuthorsRemoteDataSource.getPopularAuthors();

        await authorsCache.authorsDao.insertAuthors(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<MostPopularAuthorsEntity>>> _fetchCachedData(
      bool isConnected, List<MostPopularAuthorsEntity> authorsList) async {
    final List<MostPopularAuthorsEntity> oldCache = authorsList;

    if (isConnected) {
      try {
        final List<MostPopularAuthorsEntity> remoteData =
            await mostPopularAuthorsRemoteDataSource.getPopularAuthors();
        if (listEquals(authorsList, remoteData)) {
          return Right(oldCache);
        } else {
          await _updateLocalDatabase(remoteData);
          return Right(remoteData);
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Right(oldCache);
    }
  }

  Future<void> _updateLocalDatabase(
      List<MostPopularAuthorsEntity> newData) async {
    await authorsCache.authorsDao.updateAuthors(newData);
  }
}
