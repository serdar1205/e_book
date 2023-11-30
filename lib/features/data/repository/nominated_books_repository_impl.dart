import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/nominated_books_cache.dart';
import 'package:e_book/features/data/datasource/remote/nominated_books_remote_api.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/domain/repositories/nominated_books_repository.dart';
import 'package:flutter/foundation.dart';

class NominatedBooksRepositoryImpl extends NominatedBooksRepository {
  final NetworkInfo networkInfo;

  NominatedBooksRemoteDataSource nominatedBooksRemoteDataSource;
  NominatedBooksCache nominatedBooksCache;

  NominatedBooksRepositoryImpl({
    required this.networkInfo,
    required this.nominatedBooksRemoteDataSource,
    required this.nominatedBooksCache,
  });

  @override
  Future<Either<Failure, List<NominatedBooksEntity>>>
      getNominatedBooks() async {
    final bool isConnected = await networkInfo.isConnected;
    final bookList =
        await nominatedBooksCache.nominatedBooksDao.getNominatedBooks();

    if (bookList.isEmpty) {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected);
    } else {
      print('The database is not empty ${bookList.length}.');
      return await _fetchCachedData(isConnected, bookList);
    }
  }

  Future<Either<Failure, List<NominatedBooksEntity>>> _fetchRemoteData(
      bool isConnected) async {
    if (isConnected) {
      try {
        final List<NominatedBooksEntity> remoteData =
            await nominatedBooksRemoteDataSource.getNominatedBooks();

        await nominatedBooksCache.nominatedBooksDao
            .insertNominatedBooks(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<NominatedBooksEntity>>> _fetchCachedData(
      bool isConnected, List<NominatedBooksEntity> booksList) async {
    final List<NominatedBooksEntity> oldCache = booksList;

    if (isConnected) {
      try {
        final List<NominatedBooksEntity> remoteData =
            await nominatedBooksRemoteDataSource.getNominatedBooks();
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

  Future<void> _updateLocalDatabase(List<NominatedBooksEntity> newData) async {
    await nominatedBooksCache.nominatedBooksDao.updateNominatedBooks(newData);
  }
}
