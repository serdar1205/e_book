import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';

import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/most_popular_books_cache.dart';
import 'package:e_book/features/data/datasource/remote/most_popular_books_remote_api.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/most_popular_books_repository.dart';
import 'package:flutter/foundation.dart';

class MostPopularBooksRepositoryImpl extends MostPopularBooksRepository {
  final NetworkInfo networkInfo;
  final MostPopularBooksCache mostPopularBooksCache;
  MostPopularBooksRemoteDataSource mostPopularBooksRemoteDataSource;

  MostPopularBooksRepositoryImpl({
    required this.networkInfo,
    required this.mostPopularBooksRemoteDataSource,
    required this.mostPopularBooksCache,
  });

  @override
  Future<Either<Failure, List<MostPopularBooksEntity>>>
      getMostPopularBooks() async {
    final bool isConnected = await networkInfo.isConnected;
    final bookList =
        await mostPopularBooksCache.mostPopularBooksDao.getMostPopularBooks();

    if (bookList.isEmpty) {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected);
    } else {
      print('The database is not empty ${bookList.length}.');
      return await _fetchCachedData(isConnected, bookList);
    }
  }

  Future<Either<Failure, List<MostPopularBooksEntity>>> _fetchRemoteData(
      bool isConnected) async {
    if (isConnected) {
      try {
        final List<MostPopularBooksEntity> remoteData =
            await mostPopularBooksRemoteDataSource.getPopularBooks();

        await mostPopularBooksCache.mostPopularBooksDao
            .insertMostPopularBooks(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<MostPopularBooksEntity>>> _fetchCachedData(
      bool isConnected, List<MostPopularBooksEntity> booksList) async {
    final List<MostPopularBooksEntity> oldCache = booksList;

    if (isConnected) {
      try {
        final List<MostPopularBooksEntity> remoteData =
            await mostPopularBooksRemoteDataSource.getPopularBooks();
        if (listEquals(booksList, remoteData)) {
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
      List<MostPopularBooksEntity> newData) async {
    await mostPopularBooksCache.mostPopularBooksDao
        .updateMostPopularBooks(newData);
  }
}
