import 'package:e_book/features/presentation/screens/drawer_pages/drawer_pages.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/drawer.dart';
import 'package:e_book/injection_container.dart';
import 'package:e_book/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration test', () {
    testWidgets('Open the app', (tester) async {
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
      Finder myDrawer = find.byIcon(Icons.menu);
      await tester.tap(myDrawer);
      await tester.pump(Duration(seconds: 2));







    });
  });

}




/**   // Navigate back
    Navigator.popUntil(tester.element(find.text('My Cards Page')), (route) => route.isFirst);*/