import 'package:auto_route/auto_route.dart';
import 'package:e_book/features/presentation/screens/drawer_pages/drawer_pages.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes here
    AutoRoute(page: HomeRoute.page, initial:  true),
    AutoRoute(page: AuthorsInfoRoute.page),
    AutoRoute(page: AwardedBooksRoute.page),
    AutoRoute(page: BookDetailsRoute.page),
    AutoRoute(page: MostPopularBooksRoute.page),
    AutoRoute(page: NominatedBooksRoute.page),
    AutoRoute(page: WeeklyPopularBooksRoute.page),
    //
    AutoRoute(page: AboutUsRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: LanguageRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: MyCardsRoute.page),
  ];
}

final appRouter = AppRouter();
