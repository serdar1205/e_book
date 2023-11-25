import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:e_book/features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/loading_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeeklyPopularBooksBloc weeklyPopularBooksBloc;
  const weeklyPopularBooksEntity =  WeeklyPopularBooksModel(
      bookId: 62080187,
      name: "Never Lie",
      image:
      "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1661428846l/62080187._SY475_.jpg",
      url: "https://www.goodreads.com/book/show/62080187-never-lie",
  );

  setUp(() {
    weeklyPopularBooksBloc = MockWeeklyPopularBooksBloc();
  });

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeeklyPopularBooksBloc>(
      create: (context) => weeklyPopularBooksBloc,
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

    testWidgets('WeeklyPopularBooksCardWidget should render',
            (WidgetTester tester) async {
          // Build our app and trigger weeklyPopularBooksEntity frame.
          await tester.pumpWidget(const MaterialApp(
            home: WeeklyPopularBooksCardWidget(
                key: Key('weeklyPopularBooksCardWidget'),
                weeklyPopularBooksEntity: weeklyPopularBooksEntity),
          ));

          expect(find.byKey(const Key('weeklyPopularBooksCardWidget')), findsOneWidget);
        });
  });

  group('when state changes these widgets should render', () {
    testWidgets('LoadingWidget should render when state is WeeklyPopularBooksLoading',
            (WidgetTester tester) async {
          when(weeklyPopularBooksBloc.state).thenReturn(WeeklyPopularBooksLoading());
          await tester.pumpWidget(
              _makeTestableWidget(_makeTestableWidget(const WeeklyPopularBooksPage())));

          expect(find.byKey(const Key('loading')), findsOneWidget);
        });
    testWidgets('Text should render when state is WeeklyPopularBooksEmpty',
            (WidgetTester tester) async {
          when(weeklyPopularBooksBloc.state).thenReturn(const WeeklyPopularBooksEmpty());
          await tester.pumpWidget(
              _makeTestableWidget(_makeTestableWidget(const WeeklyPopularBooksPage())));
          expect(find.text('Empty weekly popular books'), findsOneWidget);
        });

    testWidgets(
        'WeeklyPopularBooksCardWidget should render when state is WeeklyPopularBooksLoaded',
            (WidgetTester tester) async {
          when(weeklyPopularBooksBloc.state)
              .thenReturn(const WeeklyPopularBooksLoaded([weeklyPopularBooksEntity]));
          await tester.pumpWidget(
              _makeTestableWidget(_makeTestableWidget(const WeeklyPopularBooksPage())));

          expect(find.byKey(const Key('weeklyPopularBooksCardWidget')), findsOneWidget);
        });

    testWidgets('Text should render when state is WeeklyPopularBooksError',
            (WidgetTester tester) async {
          when(weeklyPopularBooksBloc.state)
              .thenReturn(const WeeklyPopularBooksError('Error occurred.'));
          await tester.pumpWidget(
              _makeTestableWidget(_makeTestableWidget(const WeeklyPopularBooksPage())));
          expect(find.byKey(const Key('Error')), findsOneWidget);
        });
  });
}
