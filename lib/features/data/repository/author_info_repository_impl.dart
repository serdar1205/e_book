import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/local/author_info_cache.dart';
import 'package:e_book/features/data/datasource/remote/author_info_remote_api.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/repositories/author_info_repository.dart';

class AuthorInfoRepositoryImpl extends AuthorInfoRepository {
  final NetworkInfo networkInfo;
  AuthorInfoRemoteDataSource authorRemoteDataSource;
  AuthorInfoCache authorInfoCache;

  AuthorInfoRepositoryImpl({
    required this.networkInfo,
    required this.authorRemoteDataSource,
    required this.authorInfoCache,
  });

  // @override
  // Future<Either<Failure, AuthorInfoEntity>> getAuthorInfo(int authorId)async {
  //   final isConnected = await networkInfo.isConnected;
  //   if (isConnected) {
  //     // print('authorRemoteDataSource +++++++++++++++++++');
  //     try{
  //       final result = await authorRemoteDataSource.getAuthorInfo(authorId);
  //       //  print('authorRemoteDataSource +++++++++++++++++++');
  //       return Right(result);
  //     }on ServerException{
  //       return Left(ServerFailure());
  //     }
  //   }  else {
  //     return Left(ConnectionFailure());
  //   }
  //
  // }

  @override
  Future<Either<Failure, AuthorInfoEntity>> getAuthorInfo(int authorId) async {
    final bool isConnected = await networkInfo.isConnected;
    final authorData =
        await authorInfoCache.authorInfoDao.getAuthorInfoById(authorId);


    if (authorData != null && authorData.isNotEmpty) {
      print('The database is not empty $authorData.');
      return await _fetchCachedData(isConnected, authorData, authorId);
    } else {
      print('The database is empty.');
      return await _fetchRemoteData(isConnected, authorId);
    }
  }

  Future<Either<Failure, AuthorInfoEntity>> _fetchRemoteData(
      bool isConnected, int authorId) async {
    if (isConnected) {
      try {
        final AuthorInfoEntity remoteData =
            await authorRemoteDataSource.getAuthorInfo(authorId);

        await authorInfoCache.authorInfoDao.insertAuthorInfo(remoteData);
        print('inserted new data');

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, AuthorInfoEntity>> _fetchCachedData(
      bool isConnected, AuthorInfoEntity authorData, int authorId) async {
    final AuthorInfoEntity oldCache = authorData;
    //   await authorInfoCache.authorInfoDao.getAuthorInfoById(authorId);

    if (isConnected) {
      try {
        final AuthorInfoEntity remoteData =
            await authorRemoteDataSource.getAuthorInfo(authorId);
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

  Future<void> _updateLocalDatabase(
      AuthorInfoEntity newData) async {
    await authorInfoCache.authorInfoDao.updateAuthorInfoById(newData);
  }
}
