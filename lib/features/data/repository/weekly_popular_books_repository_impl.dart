import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/weekly_popular_books_cache.dart';
import 'package:e_book/features/data/datasource/remote/weekly_popular_books_remote_api.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';
import 'package:e_book/features/domain/repositories/weekly_popular_books_repository.dart';
import 'package:flutter/foundation.dart';

class WeeklyPopularBooksRepositoryImpl extends WeeklyPopularBooksRepository {
  final NetworkInfo networkInfo;

  WeeklyPopularBooksRemoteDataSource weeklyPopularBooksRemoteDataSource;
  WeeklyPopularBooksCache weeklyPopularBooksCache;

  WeeklyPopularBooksRepositoryImpl({
    required this.networkInfo,
    required this.weeklyPopularBooksRemoteDataSource,
    required this.weeklyPopularBooksCache,
  });

  @override
  Future<Either<Failure, List<WeeklyPopularBooksEntity>>>
      getWeeklyPopularBooks() async {
    final bool isConnected = await networkInfo.isConnected;
    final bookList = await weeklyPopularBooksCache.weeklyPopularBooksDao
        .getWeeklyPopularBooks();

    if (bookList.isEmpty) {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected);
    } else {
      print('The database is not empty ${bookList.length}.');
      return await _fetchCachedData(isConnected, bookList);
    }
  }

  Future<Either<Failure, List<WeeklyPopularBooksEntity>>> _fetchRemoteData(
      bool isConnected) async {
    if (isConnected) {
      try {
        final List<WeeklyPopularBooksEntity> remoteData =
            await weeklyPopularBooksRemoteDataSource.getWeeklyPopularBooks();

        await weeklyPopularBooksCache.weeklyPopularBooksDao
            .insertWeeklyPopularBooks(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<WeeklyPopularBooksEntity>>> _fetchCachedData(
      bool isConnected, List<WeeklyPopularBooksEntity> booksList) async {
    final List<WeeklyPopularBooksEntity> oldCache = booksList;

    if (isConnected) {
      try {
        final List<WeeklyPopularBooksEntity> remoteData =
            await weeklyPopularBooksRemoteDataSource.getWeeklyPopularBooks();
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
      List<WeeklyPopularBooksEntity> newData) async {
    await weeklyPopularBooksCache.weeklyPopularBooksDao
        .updateWeeklyPopularBooks(newData);
  }
}
