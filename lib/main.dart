import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/blocs/most_popular_books/most_popular_books_bloc.dart';
import 'package:e_book/features/presentation/blocs/nominated_books/nominated_books_list_bloc.dart';
import 'package:e_book/features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';
import 'features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MostPopularAuthorsListBloc>(
              create: (context) => locator<MostPopularAuthorsListBloc>()
                ..add(GetMostPopularAuthorsEvent())),
          BlocProvider<NominatedBooksListBloc>(
              create: (context) => locator<NominatedBooksListBloc>()
                ..add(GetNominatedBooksListEvent())),
          BlocProvider<AwardedBooksBloc>(
              create: (context) =>
                  locator<AwardedBooksBloc>()..add(GetAwardedBooksEvent())),
          BlocProvider<WeeklyPopularBooksBloc>(
              create: (context) => locator<WeeklyPopularBooksBloc>()
                ..add(GetWeeklyPopularBooksEvent())),
          BlocProvider<MostPopularBooksBloc>(
              create: (context) =>
                  MostPopularBooksBloc(locator())..add(GetMostPopularBooks())),
          BlocProvider<AuthorInfoBloc>(
              create: (context) => AuthorInfoBloc(locator())),
          BlocProvider<BookDetailsBloc>(
              create: (context) => BookDetailsBloc(locator())),
        ],
        child: ChangeNotifierProvider(create: (context)=>locator<ThemeProvider>(),
        builder: (context, _){
          final provider = Provider.of<ThemeProvider>(context);
          return  MaterialApp.router(
            title: 'Library',
            debugShowCheckedModeBanner: false,
            theme: provider.theme,
            //theme: AppTheme.light(),
            //darkTheme: AppTheme.dark(),
            // themeMode: ThemeServices().theme,
            routerConfig: appRouter.config(),
            // onGenerateRoute: Routers.generateRoute,
            // initialRoute: AppRoutesConstant.homeRoute,
          );
        },
        ));
  }
}
