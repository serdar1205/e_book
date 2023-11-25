import 'package:e_book/core/networks/network_info.dart';
import 'package:e_book/features/data/datasource/remote/remote_datasources.dart';
import 'package:e_book/features/domain/repositories/repositories.dart';
import 'package:e_book/features/domain/usecases/usecase.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'package:e_book/features/presentation/blocs/most_popular_books/most_popular_books_bloc.dart';
import 'package:e_book/features/presentation/blocs/nominated_books/nominated_books_list_bloc.dart';
import 'package:e_book/features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  /// http
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<NetworkInfo>(),
  ///data sources

  MockSpec<AuthorInfoRemoteDataSource>(),
  MockSpec<AwardedBooksRemoteDataSource>(),
  MockSpec<BookDetailsRemoteDataSource>(),
  MockSpec<MostPopularAuthorsRemoteDataSource>(),
  MockSpec<MostPopularBooksRemoteDataSource>(),
  MockSpec<NominatedBooksRemoteDataSource>(),
  MockSpec<WeeklyPopularBooksRemoteDataSource>(),
  ///domain repositories
  MockSpec<AuthorInfoRepository>(),
  MockSpec<AwardedBooksRepository>(),
  MockSpec<BookDetailRepository>(),
  MockSpec<MostPopularAuthorsRepository>(),
  MockSpec<MostPopularBooksRepository>(),
  MockSpec<NominatedBooksRepository>(),
  MockSpec<WeeklyPopularBooksRepository>(),
  ///usecase
  MockSpec<GetAuthorInfoUseCase>(),
  MockSpec<GetAwardedBooksUseCase>(),
  MockSpec<GetBookDetailsUseCase>(),
  MockSpec<GetMostPopularAuthorsUseCase>(),
  MockSpec<GetMostPopularBooksUseCase>(),
  MockSpec<GetNominatedBooksUseCase>(),
  MockSpec<GetWeeklyPopularBooksUseCase>(),

  ///bloc
  MockSpec<AuthorInfoBloc>(),
  MockSpec<AwardedBooksBloc>(),
  MockSpec<BookDetailsBloc>(),
  MockSpec<MostPopularAuthorsListBloc>(),
  MockSpec<MostPopularBooksBloc>(),
  MockSpec<NominatedBooksListBloc>(),
  MockSpec<WeeklyPopularBooksBloc>(),


])
void main(){}