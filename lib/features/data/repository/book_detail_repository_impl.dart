import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/book_detail_cache.dart';
import 'package:e_book/features/data/datasource/remote/book_detail_remote_api.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/domain/repositories/book_detail_repository.dart';

class BookDetailRepositoryImpl extends BookDetailRepository {
  final NetworkInfo networkInfo;
  BookDetailsRemoteDataSource bookDetailsRemoteDataSource;
  BookDetailCache bookDetailCache;

  BookDetailRepositoryImpl({
    required this.networkInfo,
    required this.bookDetailsRemoteDataSource,
    required this.bookDetailCache,
  });

  //
  // @override
  // Future<Either<Failure, BookDetailEntity>> getBookDetails(int bookId) async {
  //   final bool isConnected = await networkInfo.isConnected;
  //   if (isConnected) {
  //     // print('authorRemoteDataSource +++++++++++++++++++');
  //     try {
  //       final result = await bookDetailsRemoteDataSource.getBookDetails(bookId);
  //       //  print('authorRemoteDataSource +++++++++++++++++++');
  //       return Right(result);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BookDetailEntity>> getBookDetails(int bookId) async {
    final bool isConnected = await networkInfo.isConnected;
    final bookDetailData =
        await bookDetailCache.bookDetailDao.getBookDetailById(bookId);

    if (bookDetailData != null && bookDetailData.isNotEmpty) {
      print('The database is not empty $bookDetailData.');
      return await _fetchCachedData(isConnected, bookDetailData, bookId);
    } else {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected, bookId);
    }
  }

  Future<Either<Failure, BookDetailEntity>> _fetchRemoteData(
      bool isConnected, int bookId) async {
    if (isConnected) {
      try {
        final BookDetailEntity remoteData =
            await bookDetailsRemoteDataSource.getBookDetails(bookId);

        await bookDetailCache.bookDetailDao.insertBookDetail(remoteData);
        print('inserted new data');

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, BookDetailEntity>> _fetchCachedData(
      bool isConnected, BookDetailEntity bookDetailData, int bookId) async {
    final BookDetailEntity oldCache = bookDetailData;
    //   await authorInfoCache.authorInfoDao.getAuthorInfoById(authorId);

    if (isConnected) {
      try {
        final BookDetailEntity remoteData =
            await bookDetailsRemoteDataSource.getBookDetails(bookId);
        if (oldCache == remoteData) {
          print('old data ++++');

          try {
            return Right(oldCache);
          } on CacheException {
            return Left(CacheFailure());
          }
        } else {
          await _updateLocalDatabase(remoteData);
          print('updated data --------');
          return Right(remoteData);
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(oldCache);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<void> _updateLocalDatabase(BookDetailEntity newData) async {
    await bookDetailCache.bookDetailDao.updateBookDetail(newData);
  }
}
