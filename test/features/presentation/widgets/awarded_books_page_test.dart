import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAwardedBooksProvider awardedBooksProvider;
  const awardedBooksEntity = AwardedBooksModel(
    bookId: 56597885,
    name: 'Beautiful World, Where Are You',
    image:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618329605l/56597885.jpg',
    url: 'https://www.goodreads.com/choiceawards/best-fiction-books-2021',
    winningCategory: 'Fiction',
  );

  setUp(() {
    awardedBooksProvider = MockAwardedBooksProvider();
  });

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<AwardedBooksProvider>(
      create: (context) => awardedBooksProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('has these widgets on  screen', () {
    // testWidgets('LoadingWidget should render', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //      _makeTestableWidget(LoadingWidget(key: Key('loading'))),
    //   );
    //
    //   // Verify that LoadingWidget is rendered.
    //   expect(find.byKey(const Key('loading')), findsOneWidget);
    // });

    testWidgets('render Listview widget', (tester) async {
      await tester.pumpWidget(_makeTestableWidget(ListView()));

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('AwardedBooksCardWidget should render',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(
        home: AwardedBooksCardWidget(
            key: Key('awardedBooksCard'),
            awardedBooksEntity: awardedBooksEntity),
      ));

      expect(find.byKey(const Key('awardedBooksCard')), findsOneWidget);
    });
  });

  group('when state changes these widgets should render', () {
    testWidgets('LoadingWidget should render when state is AwardedBooksLoading',
        (WidgetTester tester) async {
      when(awardedBooksProvider.state).thenReturn(AwardedBooksLoading());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const AwardedBooksPage())));

      expect(find.byKey(const Key('loading')), findsOneWidget);
    });
    testWidgets('Text should render when state is AwardedBooksEmpty',
        (WidgetTester tester) async {
      when(awardedBooksProvider.state).thenReturn(const AwardedBooksEmpty());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const AwardedBooksPage())));
      expect(find.text('Empty Awarded books'), findsOneWidget);
    });

    testWidgets(
        'AwardedBooksCardWidget should render when state is AwardedBooksLoaded',
        (WidgetTester tester) async {
      when(awardedBooksProvider.state)
          .thenReturn(const AwardedBooksLoaded([awardedBooksEntity]));
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const AwardedBooksPage())));

      expect(find.byKey(const Key('awardedBooksCard')), findsOneWidget);
    });

    testWidgets('Text should render when state is AwardedBooksError',
        (WidgetTester tester) async {
      when(awardedBooksProvider.state)
          .thenReturn(const AwardedBooksError('Error occurred.'));
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const AwardedBooksPage())));
      expect(find.byKey(const Key('Error')), findsOneWidget);
    });
  });
}
