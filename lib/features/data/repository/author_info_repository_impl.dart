import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/author_info_remote_api.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/repositories/author_info_repository.dart';


class AuthorInfoRepositoryImpl extends AuthorInfoRepository {
  final NetworkInfo networkInfo;
  AuthorInfoRemoteDataSource authorRemoteDataSource;

  AuthorInfoRepositoryImpl({
    required this.networkInfo,
    required this.authorRemoteDataSource,
  });

  @override
  Future<Either<Failure, AuthorInfoEntity>> getAuthorInfo(int authorId)async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try{
        final result = await authorRemoteDataSource.getAuthorInfo(authorId);
        //  print('authorRemoteDataSource +++++++++++++++++++');
        return Right(result);
      }on ServerException{
        return Left(ServerFailure());
      }
    }  else {
      return Left(ConnectionFailure());
    }

  }

}