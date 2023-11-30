import 'package:e_book/core/themes/app_theme.dart';
import 'package:e_book/features/data/datasource/local/authors_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/networks/network_info.dart';
import 'features/data/datasource/local/author_info_cache.dart';
import 'features/data/datasource/local/awarded_books_cache.dart';
import 'features/data/datasource/local/book_detail_cache.dart';
import 'features/data/datasource/local/most_popular_books_cache.dart';
import 'features/data/datasource/local/nominated_books_cache.dart';
import 'features/data/datasource/local/weekly_popular_books_cache.dart';
import 'features/data/datasource/remote/remote_datasources.dart';
import 'features/data/repository/repositories_impl.dart';
import 'features/domain/repositories/repositories.dart';
import 'features/domain/usecases/usecase.dart';
import 'features/presentation/blocs/author_info/author_info_bloc.dart';
import 'features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'features/presentation/blocs/book_details/book_details_bloc.dart';
import 'features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'features/presentation/blocs/most_popular_books/most_popular_books_bloc.dart';
import 'features/presentation/blocs/nominated_books/nominated_books_list_bloc.dart';
import 'features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  ///network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  ///theme
  locator.registerLazySingleton<ThemeServices>(() => ThemeServices());

  locator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());

  /// Rest Client
  locator.registerLazySingleton(() => http.Client());

  /// Data sources
  locator.registerLazySingleton<MostPopularAuthorsRemoteDataSource>(
    () => MostPopularAuthorsRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<AwardedBooksRemoteDataSource>(
      () => AwardedBooksRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<NominatedBooksRemoteDataSource>(
      () => NominatedBooksRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<WeeklyPopularBooksRemoteDataSource>(
      () => WeeklyPopularBooksRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<MostPopularBooksRemoteDataSource>(
      () => MostPopularBooksRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<AuthorInfoRemoteDataSource>(
      () => AuthorInfoRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<BookDetailsRemoteDataSource>(
      () => BookDetailsRemoteDataSourceImpl(client: locator()));

  /// local cache
  final database =
      await $FloorAuthorsCache.databaseBuilder('authors.db').build();
  locator.registerSingleton<AuthorsCache>(database);

  //awarded
  final awardedBooksCache =
      await $FloorAwardedBooksCache.databaseBuilder('awarded_books.db').build();
  locator.registerSingleton<AwardedBooksCache>(awardedBooksCache);
  //p b
  final mostPopularBooksCache = await $FloorMostPopularBooksCache
      .databaseBuilder('most_popular_books.db')
      .build();
  locator.registerSingleton<MostPopularBooksCache>(mostPopularBooksCache);
  //n b
  final nominatedBooksCache = await $FloorNominatedBooksCache
      .databaseBuilder('nominated_books.db')
      .build();
  locator.registerSingleton<NominatedBooksCache>(nominatedBooksCache);
  //w b
  final weeklyPopularBooksCache = await $FloorWeeklyPopularBooksCache
      .databaseBuilder('weekly_popular_books.db')
      .build();
  locator.registerSingleton<WeeklyPopularBooksCache>(weeklyPopularBooksCache);
  // a info
  final authorInfoCache =
      await $FloorAuthorInfoCache.databaseBuilder('author_info.db').build();
  locator.registerSingleton<AuthorInfoCache>(authorInfoCache);

  // book detail
  final BookDetailCache bookDetailCache =
      await $FloorBookDetailCache.databaseBuilder('book_detail').build();
  locator.registerSingleton<BookDetailCache>(bookDetailCache);

  /// repositories
  locator.registerLazySingleton<MostPopularAuthorsRepository>(
    () => MostPopularAuthorsRepositoryImpl(
      networkInfo: locator(),
      mostPopularAuthorsRemoteDataSource: locator(),
      authorsCache: locator(),
      //    localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<NominatedBooksRepository>(
      () => NominatedBooksRepositoryImpl(
            networkInfo: locator(),
            nominatedBooksRemoteDataSource: locator(),
            nominatedBooksCache: locator(),
          ));
  locator.registerLazySingleton<AwardedBooksRepository>(
      () => AwardedBooksRepositoryImpl(
            networkInfo: locator(),
            remoteDataSource: locator(),
            awardedBooksCache: locator(),
          ));
  locator.registerLazySingleton<WeeklyPopularBooksRepository>(
      () => WeeklyPopularBooksRepositoryImpl(
            networkInfo: locator(),
            weeklyPopularBooksRemoteDataSource: locator(),
            weeklyPopularBooksCache: locator(),
          ));

  locator.registerLazySingleton<MostPopularBooksRepository>(
      () => MostPopularBooksRepositoryImpl(
            networkInfo: locator(),
            mostPopularBooksRemoteDataSource: locator(),
            mostPopularBooksCache: locator(),
          ));
  locator.registerLazySingleton<AuthorInfoRepository>(
      () => AuthorInfoRepositoryImpl(
            networkInfo: locator(),
            authorRemoteDataSource: locator(),
            authorInfoCache: locator(),
          ));
  locator.registerLazySingleton<BookDetailRepository>(
      () => BookDetailRepositoryImpl(
            networkInfo: locator(),
            bookDetailsRemoteDataSource: locator(),
            bookDetailCache: locator(),
          ));

  /// usecase
  locator.registerLazySingleton(() => GetMostPopularAuthorsUseCase(locator()));
  locator.registerLazySingleton(() => GetNominatedBooksUseCase(locator()));
  locator.registerLazySingleton(() => GetAwardedBooksUseCase(locator()));
  locator.registerLazySingleton(() => GetWeeklyPopularBooksUseCase(locator()));

  locator.registerLazySingleton(() => GetMostPopularBooksUseCase(locator()));
  locator.registerLazySingleton(() => GetAuthorInfoUseCase(locator()));
  locator.registerLazySingleton(() => GetBookDetailsUseCase(locator()));

  /// Bloc
  locator.registerFactory(
      () => MostPopularAuthorsListBloc(allAuthorsUsecase: locator()));
  locator.registerFactory(() => NominatedBooksListBloc(useCase: locator()));
  locator.registerFactory(() => AwardedBooksBloc(locator()));
  locator.registerFactory(() => WeeklyPopularBooksBloc(useCase: locator()));

  locator.registerFactory(() => MostPopularBooksBloc(locator()));
  locator.registerFactory(() => AuthorInfoBloc(locator()));
  locator.registerFactory(() => BookDetailsBloc(locator()));
}
