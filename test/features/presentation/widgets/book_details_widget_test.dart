import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/book_detail_card_widget.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockBookDetailsBloc bookDetailBloc;
  const bookDetailEntity = BookDetailModel(
    bookId: 56597885,
    name: 'Beautiful World, Where Are You',
    image:
        'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1618329605i/56597885.jpg',
    url: 'https://www.goodreads.com/book/show/56597885',
    author: ['Sally Rooney'],
    rating: 3.54,
    pages: 356,
    publishedDate: 'September 7, 2021',
    synopsis: 'Alice, a novelist, meets Felix',
  );
  setUp(() {
    bookDetailBloc = MockBookDetailsBloc();
  });

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BookDetailsBloc>(
      create: (context) => bookDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('has these widgets on  screen', () {
    testWidgets('render Listview widget scroll', (tester) async {
      await tester.pumpWidget(_makeTestableWidget(ListView(
        key: const Key('scroll'),
      )));

      expect(find.byKey(const Key('scroll')), findsOneWidget);
    });

    testWidgets('BookDetailCardWidget should render',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        _makeTestableWidget(const BookDetailCardWidget(
          bookDetailEntity: bookDetailEntity,
        )),
      );
      expect(find.byType(BookDetailCardWidget), findsOneWidget);
    });

    testWidgets('BookDescription should render', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        _makeTestableWidget(BookDescription(
          text: bookDetailEntity.synopsis!,
        )),
      );
      expect(find.byType(BookDescription), findsOneWidget);
    });
  });

  group('when state changes these widgets should render', () {
    testWidgets('LoadingWidget should render when state is BookDetailsLoading',
        (WidgetTester tester) async {
      when(bookDetailBloc.state).thenReturn(BookDetailsLoading());
      await tester
          .pumpWidget(_makeTestableWidget(_makeTestableWidget(BookDetailsPage(
        bookId: bookDetailEntity.bookId!,
      ))));

      expect(find.byKey(const Key('loading')), findsOneWidget);
    });

    testWidgets(
        'BookDetailCardWidget, BookDescription,  should render when state is BookDetailsLoaded',
        (WidgetTester tester) async {
      when(bookDetailBloc.state)
          .thenReturn(BookDetailsLoaded(bookDetailEntity));
      await tester
          .pumpWidget(_makeTestableWidget(_makeTestableWidget(BookDetailsPage(
        bookId: bookDetailEntity.bookId!,
      ))));

      expect(find.byType(BookDetailCardWidget), findsOneWidget);
      expect(find.byType(BookDescription), findsOneWidget);
    });

    testWidgets('Text should render when state is BookDetailsError',
        (WidgetTester tester) async {
      when(bookDetailBloc.state)
          .thenReturn(BookDetailsError('Error occurred.'));
      await tester
          .pumpWidget(_makeTestableWidget(_makeTestableWidget(BookDetailsPage(
        bookId: bookDetailEntity.bookId!,
      ))));
      expect(find.byKey(const Key('Error')), findsOneWidget);
    });
  });
}
