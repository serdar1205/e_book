import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/awarded_books_cache.dart';
import 'package:e_book/features/data/datasource/remote/awarded_books_remote_api.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/domain/repositories/awarded_books_repository.dart';
import 'package:flutter/foundation.dart';

class AwardedBooksRepositoryImpl extends AwardedBooksRepository {
  NetworkInfo networkInfo;
  AwardedBooksCache awardedBooksCache;
  AwardedBooksRemoteDataSource remoteDataSource;

  AwardedBooksRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.awardedBooksCache,
  });

  @override
  Future<Either<Failure, List<AwardedBooksEntity>>> getAwardedBooks() async {
    final bool isConnected = await networkInfo.isConnected;
    final booksList = await awardedBooksCache.awardedBooksDao.getAwardedBooks();

    if (booksList.isEmpty) {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected);
    } else {
      print('The database is not empty ${booksList.length}.');
      return await _fetchCachedData(isConnected, booksList);
    }
  }

  Future<Either<Failure, List<AwardedBooksEntity>>> _fetchRemoteData(
      bool isConnected) async {
    if (isConnected) {
      try {
        final List<AwardedBooksEntity> remoteData =
            await remoteDataSource.getAwardedBooks();

        await awardedBooksCache.awardedBooksDao.insertAwardedBooks(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<AwardedBooksEntity>>> _fetchCachedData(
      bool isConnected, List<AwardedBooksEntity> bookList) async {
    final List<AwardedBooksEntity> oldCache = bookList;

    if (isConnected) {
      try {
        final List<AwardedBooksEntity> remoteData =
            await remoteDataSource.getAwardedBooks();
        if (listEquals(bookList, remoteData)) {
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

  Future<void> _updateLocalDatabase(List<AwardedBooksEntity> newData) async {
    await awardedBooksCache.awardedBooksDao.updateAwardedBooks(newData);
  }
}
