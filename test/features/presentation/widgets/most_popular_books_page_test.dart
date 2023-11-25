import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/presentation/blocs/most_popular_books/most_popular_books_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/loading_widget.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockMostPopularBooksBloc popularBooksBloc;
  MostPopularBooksEntity mostPopularBooksEntity = MostPopularBooksModel(
    bookId: int.parse("58283080"),
    name: "Hook, Line, and Sinker (Bellinger Sisters, #2)",
    image:
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627068858i/58283080.jpg",
    rating: 3.95,
    url: "https://www.goodreads.com/book/show/58283080-hook-line-and-sinker",
  );

  setUp(() {
    popularBooksBloc = MockMostPopularBooksBloc();
  });

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MostPopularBooksBloc>(
      create: (context) => popularBooksBloc,
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

    testWidgets('MostPopularBooksCardWidget should render',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: MostPopularBooksCardWidget(
            key: const Key('mostPopularBooksCardWidget'),
            mostPopularBooksEntity: mostPopularBooksEntity),
      ));

      expect(
          find.byKey(const Key('mostPopularBooksCardWidget')), findsOneWidget);
    });
  });

  group('when state changes these widgets should render', () {
    testWidgets(
        'LoadingWidget should render when state is MostPopularBooksLoading',
        (WidgetTester tester) async {
      when(popularBooksBloc.state).thenReturn(const MostPopularBooksLoading());
      await tester.pumpWidget(_makeTestableWidget(
          _makeTestableWidget(const MostPopularBooksPage())));

      expect(find.byKey(const Key('loading')), findsOneWidget);
    });

    testWidgets('Text should render when state is MostPopularBooksEmpty',
        (WidgetTester tester) async {
      when(popularBooksBloc.state).thenReturn(const MostPopularBooksEmpty());
      await tester.pumpWidget(_makeTestableWidget(
          _makeTestableWidget(const MostPopularBooksPage())));
      expect(find.text('Empty popular books'), findsOneWidget);
    });

    testWidgets(
        'MostPopularBooksCardWidget should render when state is MostPopularBooksLoaded',
        (WidgetTester tester) async {
      when(popularBooksBloc.state)
          .thenReturn(MostPopularBooksLoaded([mostPopularBooksEntity]));
      await tester.pumpWidget(_makeTestableWidget(
          _makeTestableWidget(const MostPopularBooksPage())));

      expect(
          find.byKey(const Key('mostPopularBooksCardWidget')), findsOneWidget);
    });

    testWidgets('Text should render when state is MostPopularBooksError',
        (WidgetTester tester) async {
      when(popularBooksBloc.state)
          .thenReturn(const MostPopularBooksError('Error occurred.'));
      await tester.pumpWidget(_makeTestableWidget(
          _makeTestableWidget(const MostPopularBooksPage())));
      expect(find.byKey(const Key('Error')), findsOneWidget);
    });
  });
}
