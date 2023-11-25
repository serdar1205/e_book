// import 'package:e_book/features/domain/entity/entity.dart';
// import 'package:e_book/features/presentation/screens/drawer_pages/drawer_pages.dart';
// import 'package:flutter/material.dart';
// import '../../features/presentation/screens/screens.dart';
//
// class AppRoutesConstant {
//   static const String homeRoute = '/';
//   static const String authorInfoRoute = 'authorInfoRoute';
//   static const String awardedBooksRoute = 'awardedBooksRoute';
//   static const String bookDetailsRoute = 'bookDetailsRoute';
//   static const String mostPopularBooksRoute = 'mostPopularBooksRoute';
//   static const String nominatedBooksRoute = 'nominatedBooksRoute';
//   static const String weeklyPopularBooksRoute = 'weeklyPopularBooksRoute';
//   static const String aboutUsRoute = 'aboutUsRoute';
//   static const String chatRoute = 'chatRoute';
//   static const String languageRoute = 'languageRoute';
//   static const String logInRoute = 'logInRoute';
//   static const String myCardsRoute = 'myCardsRoute';
// }
//
// class Routers {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutesConstant.homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomePage());
//       case AppRoutesConstant.authorInfoRoute:
//         return MaterialPageRoute(
//             builder: (_) => AuthorsInfoPage(
//                   authorId:  const MostPopularAuthorsEntity().authorId!,
//                 ));
//       case AppRoutesConstant.awardedBooksRoute:
//         return MaterialPageRoute(builder: (_) => const AwardedBooksPage());
//       case AppRoutesConstant.bookDetailsRoute:
//         return MaterialPageRoute(
//             builder: (_) => BookDetailsPage(
//                   bookId: const AwardedBooksEntity().bookId!,
//                 ));
//       case AppRoutesConstant.mostPopularBooksRoute:
//         return MaterialPageRoute(builder: (_) => const MostPopularBooksPage());
//       case AppRoutesConstant.nominatedBooksRoute:
//         return MaterialPageRoute(builder: (_) => const NominatedBooksPage());
//       case AppRoutesConstant.weeklyPopularBooksRoute:
//         return MaterialPageRoute(
//             builder: (_) => const WeeklyPopularBooksPage());
//       case AppRoutesConstant.aboutUsRoute:
//         return MaterialPageRoute(builder: (_) => const AboutUsPage());
//       case AppRoutesConstant.chatRoute:
//         return MaterialPageRoute(builder: (_) => const ChatPage());
//       case AppRoutesConstant.languageRoute:
//         return MaterialPageRoute(builder: (_) => const LanguagePage());
//       case AppRoutesConstant.logInRoute:
//         return MaterialPageRoute(builder: (_) => const LoginPage());
//       case AppRoutesConstant.myCardsRoute:
//         return MaterialPageRoute(builder: (_) => const MyCardsPage());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                   body: Center(
//                       child: Text('No route defined for ${settings.name}')),
//                 ));
//     }
//   }
// }
