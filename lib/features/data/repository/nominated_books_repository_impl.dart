import 'package:dartz/dartz.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/nominated_books_remote_api.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/domain/repositories/nominated_books_repository.dart';

class NominatedBooksRepositoryImpl extends NominatedBooksRepository {
  final NetworkInfo networkInfo;

  NominatedBooksRemoteDataSource nominatedBooksDataSource;

  NominatedBooksRepositoryImpl({
    required this.networkInfo,
    required this.nominatedBooksDataSource,
  });

  @override
  Future<Either<Failure, List<NominatedBooksEntity>>> getNominatedBooks()async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // print('authorRemoteDataSource +++++++++++++++++++');
      try {
        final result = await nominatedBooksDataSource.getNominatedBooks();
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
