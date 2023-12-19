import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/providers/nominated_books/nominated_books_list_provider.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/loading_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockNominatedBooksListProvider listProvider;
  const nominatedBooksEntity = NominatedBooksModel(
      bookId: 52861201,
      bookName: "From Blood and Ash",
      author: "Jennifer L. Armentrou",
      votes: 70896,
      image:
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg",
      url:
          "https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true");

  setUp(() {
    listProvider = MockNominatedBooksListProvider();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NominatedBooksListProvider>(
      create: (context) => listProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('has these widgets on  screen', () {
    testWidgets('LoadingWidget should render', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoadingWidget(key: Key('loading')),
      ));

      // Verify that LoadingWidget is rendered.
      expect(find.byKey(const Key('loading')), findsOneWidget);
    });

    testWidgets('render Listview widget', (tester) async {
      await tester.pumpWidget(_makeTestableWidget(ListView()));

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('NominatedBooksCard should render',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(
        home: NominatedBooksCardWidget(
            key: Key('nominatedBooksCard'),
            nominatedBooksEntity: nominatedBooksEntity),
      ));

      expect(find.byKey(const Key('nominatedBooksCard')), findsOneWidget);
    });
  });

  group('when state changes these widgets should render', () {
    testWidgets(
        'LoadingWidget should render when state is NominatedBooksListLoadingState',
        (WidgetTester tester) async {
      when(listProvider.state).thenReturn(const NominatedBooksListLoadingState());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const NominatedBooksPage())));

      expect(find.byKey(const Key('loading')), findsOneWidget);
    });
    testWidgets('Text should render when state is NominatedBooksListEmptyState',
        (WidgetTester tester) async {
      when(listProvider.state).thenReturn(const NominatedBooksListEmptyState());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const NominatedBooksPage())));
      expect(find.text('Empty Nominated books'), findsOneWidget);
    });

    testWidgets(
        'NominatedBooksCardWidget should render when state is NominatedBooksListLoadedState',
        (WidgetTester tester) async {
      when(listProvider.state).thenReturn(
          const NominatedBooksListLoadedState([nominatedBooksEntity]));
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const NominatedBooksPage())));

      expect(find.byKey(const Key('nominatedBooksCard')), findsOneWidget);
    });

    testWidgets('Text should render when state is NominatedBooksListErrorState',
        (WidgetTester tester) async {
      when(listProvider.state)
          .thenReturn(const NominatedBooksListErrorState('Error occurred.'));
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const NominatedBooksPage())));
      expect(find.byKey(const Key('Error')), findsOneWidget);
    });
  });
}
