import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/awarded_books_card_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/most_popular_books_card_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/nominated_books_card_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/weekly_popular_books_card_widget.dart';
import 'package:e_book/injection_container.dart';
import 'package:e_book/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration test', () {
    testWidgets('Open the app, scroll, app bar', (tester) async {
      await initLocator();
      await GetStorage.init();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      // Find the SingleChildScrollView by looking for a specific widget
      Finder scroll = find.byKey(const Key('mySingleChildScrollView'));
      //scroll down to end
      await tester.drag(scroll, const Offset(0.0, -1000.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(scroll, const Offset(0.0, 1000.0), 1000.0);
      await tester.pumpAndSettle();

      // dark mode
      Finder darkModeButton = find.byIcon(Icons.wb_sunny_outlined);
      await tester.tap(darkModeButton);
      await tester.pumpAndSettle();
      await tester.tap(darkModeButton);
      await tester.pumpAndSettle();

      ///drawer
      Finder myDrawer = find.byIcon(Icons.menu);
      await tester.tap(myDrawer);
      await tester.pumpAndSettle();

      /// login page
      expect(find.text('Log in'), findsOneWidget);
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///
      expect(find.text('My Cards'), findsOneWidget);
      await tester.tap(find.text('My Cards'));
      await tester.pumpAndSettle();
      expect(find.text("My Cards Page"), findsOneWidget);
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///
      expect(find.text('Chat'), findsOneWidget);
      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///
      expect(find.text('Dili'), findsOneWidget);
      await tester.tap(find.text('Dili'));
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///
      expect(find.text('Biz barada'), findsOneWidget);
      await tester.tap(find.text('Biz barada'));
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///back
      expect(find.byKey(const Key('back')), findsOneWidget);
      await tester.tap(find.byKey(const Key('back')));
      await tester.pumpAndSettle();

      ///search
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'Notebook');
      await tester.pumpAndSettle();
      expect(find.text('Notebook'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      ///nominated page
      Finder nominatedPage = find.byType(MainCategoryCard).first;
      await tester.tap(nominatedPage);
      await tester.pumpAndSettle();
      Finder nominatedScroll = find.byType(ListView);
      //scroll down to end
      await tester.drag(nominatedScroll, const Offset(0.0, -500.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(nominatedScroll, const Offset(0.0, 500.0), 1000.0);
      await tester.pumpAndSettle();

      Finder nominatedCard = find.byType(NominatedBooksCardWidget).first;
      await tester.tap(nominatedCard);
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///awarded
      Finder awardedBooksPage = find.byType(MainCategoryCard).at(1);
      await tester.tap(awardedBooksPage);
      await tester.pumpAndSettle();

      Finder awardedBooksScroll = find.byType(ListView);
      //scroll down to end
      await tester.drag(awardedBooksScroll, const Offset(0.0, -500.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(awardedBooksScroll, const Offset(0.0, 500.0), 1000.0);
      await tester.pumpAndSettle();

      Finder awardedBooksCard = find.byType(AwardedBooksCardWidget).first;
      await tester.tap(awardedBooksCard);
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///weekly popular books
      Finder weeklyPopularBooksPage = find.byType(MainCategoryCard).at(2);
      await tester.tap(weeklyPopularBooksPage);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 1));
      Finder weeklyPopularBooksScroll = find.byType(ListView);
      //scroll down to end
      await tester.drag(weeklyPopularBooksScroll, const Offset(0.0, -500.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(
          weeklyPopularBooksScroll, const Offset(0.0, 500.0), 1000.0);
      await tester.pumpAndSettle();

      Finder weeklyPopularBooksCard =
          find.byType(WeeklyPopularBooksCardWidget).first;
      await tester.tap(weeklyPopularBooksCard);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///most popular
      Finder popularBooksPage = find.byType(MainCategoryCard).last;
      await tester.tap(popularBooksPage);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 1));
      Finder popularBooksScroll = find.byType(ListView);
      //scroll down to end
      await tester.drag(popularBooksScroll, const Offset(0.0, -500.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(popularBooksScroll, const Offset(0.0, 500.0), 1000.0);
      await tester.pumpAndSettle();

      Finder popularBooksCard = find.byType(MostPopularBooksCardWidget).first;
      await tester.tap(popularBooksCard);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      ///author info
      Finder authorInfoPage = find.byType(AuthorsListCard).first;
      await tester.tap(authorInfoPage);
      await tester.pumpAndSettle();
      Finder authorInfoScroll = find.byKey(const Key('scroll'));
      //scroll down to end
      await tester.drag(authorInfoScroll, const Offset(0.0, -500.0));
      await tester.pumpAndSettle();
      //scroll up
      await tester.fling(authorInfoScroll, const Offset(0.0, 500.0), 1000.0);
      await tester.pumpAndSettle();

      ///back
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    });
  });
}

/**   // Navigate back
    Navigator.popUntil(tester.element(find.text('My Cards Page')), (route) => route.isFirst);*/
