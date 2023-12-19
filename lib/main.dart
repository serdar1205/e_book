import 'package:e_book/core/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';
import 'features/presentation/providers/author_info/author_info_provider.dart';
import 'features/presentation/providers/awarded_books/awarded_books_provider.dart';
import 'features/presentation/providers/book_details/book_details_provider.dart';
import 'features/presentation/providers/most_popular_authors_list/most_popular_authors_provider.dart';
import 'features/presentation/providers/most_popular_books/most_popular_books_provider.dart';
import 'features/presentation/providers/nominated_books/nominated_books_list_provider.dart';
import 'features/presentation/providers/weekly_popular_books/weekly_popular_books_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (_) => locator<ThemeProvider>()),
        ChangeNotifierProvider<AuthorInfoProvider>(
            create: (_) => locator<AuthorInfoProvider>()),
        ChangeNotifierProvider<BookDetailsProvider>(
            create: (_) => locator<BookDetailsProvider>()),
        ChangeNotifierProvider<MostPopularAuthorsProvider>(
            create: (_) =>
                locator<MostPopularAuthorsProvider>()..getAllAuthorsEvent()),
        ChangeNotifierProvider<NominatedBooksListProvider>(
            create: (_) => locator<NominatedBooksListProvider>()
              ..getNominatedBooksListEvent()),
        ChangeNotifierProvider<AwardedBooksProvider>(
            create: (_) => locator<AwardedBooksProvider>()..getAwardedBooks()),
        ChangeNotifierProvider<WeeklyPopularBooksProvider>(
            create: (_) =>
                locator<WeeklyPopularBooksProvider>()..getWeeklyPopularBooks()),
        ChangeNotifierProvider<MostPopularBooksProvider>(
            create: (_) =>
                locator<MostPopularBooksProvider>()..getMostPopularBooks()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          title: 'Library',
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).theme,
          //theme: AppTheme.light(),
          //darkTheme: AppTheme.dark(),
          // themeMode: ThemeServices().theme,
          routerConfig: appRouter.config(),
          // onGenerateRoute: Routers.generateRoute,
          // initialRoute: AppRoutesConstant.homeRoute,
        );
      }),
    );
  }
}
