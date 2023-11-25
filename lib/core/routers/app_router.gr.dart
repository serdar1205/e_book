// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutUsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutUsPage(),
      );
    },
    AuthorsInfoRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorsInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthorsInfoPage(
          key: args.key,
          authorId: args.authorId,
        ),
      );
    },
    AwardedBooksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AwardedBooksPage(),
      );
    },
    BookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookDetailsPage(
          key: args.key,
          bookId: args.bookId,
        ),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LanguageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguagePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MostPopularBooksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MostPopularBooksPage(),
      );
    },
    MyCardsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyCardsPage(),
      );
    },
    NominatedBooksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NominatedBooksPage(),
      );
    },
    WeeklyPopularBooksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WeeklyPopularBooksPage(),
      );
    },
  };
}

/// generated route for
/// [AboutUsPage]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute({List<PageRouteInfo>? children})
      : super(
          AboutUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutUsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthorsInfoPage]
class AuthorsInfoRoute extends PageRouteInfo<AuthorsInfoRouteArgs> {
  AuthorsInfoRoute({
    Key? key,
    required int authorId,
    List<PageRouteInfo>? children,
  }) : super(
          AuthorsInfoRoute.name,
          args: AuthorsInfoRouteArgs(
            key: key,
            authorId: authorId,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthorsInfoRoute';

  static const PageInfo<AuthorsInfoRouteArgs> page =
      PageInfo<AuthorsInfoRouteArgs>(name);
}

class AuthorsInfoRouteArgs {
  const AuthorsInfoRouteArgs({
    this.key,
    required this.authorId,
  });

  final Key? key;

  final int authorId;

  @override
  String toString() {
    return 'AuthorsInfoRouteArgs{key: $key, authorId: $authorId}';
  }
}

/// generated route for
/// [AwardedBooksPage]
class AwardedBooksRoute extends PageRouteInfo<void> {
  const AwardedBooksRoute({List<PageRouteInfo>? children})
      : super(
          AwardedBooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwardedBooksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookDetailsPage]
class BookDetailsRoute extends PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    Key? key,
    required int bookId,
    List<PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            key: key,
            bookId: bookId,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const PageInfo<BookDetailsRouteArgs> page =
      PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    required this.bookId,
  });

  final Key? key;

  final int bookId;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, bookId: $bookId}';
  }
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MostPopularBooksPage]
class MostPopularBooksRoute extends PageRouteInfo<void> {
  const MostPopularBooksRoute({List<PageRouteInfo>? children})
      : super(
          MostPopularBooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'MostPopularBooksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyCardsPage]
class MyCardsRoute extends PageRouteInfo<void> {
  const MyCardsRoute({List<PageRouteInfo>? children})
      : super(
          MyCardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyCardsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NominatedBooksPage]
class NominatedBooksRoute extends PageRouteInfo<void> {
  const NominatedBooksRoute({List<PageRouteInfo>? children})
      : super(
          NominatedBooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'NominatedBooksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WeeklyPopularBooksPage]
class WeeklyPopularBooksRoute extends PageRouteInfo<void> {
  const WeeklyPopularBooksRoute({List<PageRouteInfo>? children})
      : super(
          WeeklyPopularBooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'WeeklyPopularBooksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
