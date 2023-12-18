import 'dart:io';
import 'package:e_book/core/constants/strings.dart';
import 'package:e_book/features/data/model/model.dart';
import 'package:e_book/features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockMostPopularAuthorsProvider authorsListProvider;

  setUp(() {
    authorsListProvider = MockMostPopularAuthorsProvider();
    HttpOverrides.global = null;
  });
  const authorEntity = MostPopularAuthorModel(
      authorId: 3389,
      name: "Stephen King",
      image:
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/authors/1362814142i/3389._UX150_CR0,37,150,150_RO75,1,255,255,255,255,255,255,15_.jpg",
      url: "https://www.goodreads.com/author/show/3389.Stephen_King",
      popularBookTitle: "The Shining",
      popularBookUrl: "https://www.goodreads.com/book/show/11588.The_Shining",
      numberPublishedBooks: 2567);
  // ignore: no_leading_underscores_for_local_identifiers
  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MostPopularAuthorsProvider>(
      create: (context) => authorsListProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('appbar', () {
    testWidgets('HomePage appbar has title, dark mode icon, drawer ',
        (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(const HomePage()));

      final appBar = tester.widget(find.byType(AppBar));
      final darkModeIcon = tester.widget(find.byIcon(Icons.wb_sunny_outlined));
      final drawer = tester.widget(find.byIcon(Icons.menu));

      expect(drawer, isNotNull);
      expect(appBar, isNotNull);
      expect(find.text(Strings.appName), findsOneWidget);
      expect(darkModeIcon, isNotNull);
    });
  });

  group('has these wdigets on HomePage body', () {
    testWidgets('HomePage has search widget', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(const HomePage()));

      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'Notebook');
      await tester.pump();
      expect(find.text('Notebook'), findsOneWidget);
      //expect(find.byType(Search), findsOneWidget);
    });
    testWidgets('HomePage has 4 MainCategoryCard grid for main categories',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const HomePage())));

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(MainCategoryCard), findsNWidgets(4));
    });

    testWidgets('LoadingWidget should render', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoadingWidget(key: Key('loading')),
      ));

      // Verify that LoadingWidget is rendered.
      expect(find.byKey(const Key('loading')), findsOneWidget);
    });

    testWidgets('AuthorsListCard should render', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(
        home: AuthorsListCard(
            key: Key('authorsList'), authorsEntity: authorEntity),
      ));

      expect(find.byKey(const Key('authorsList')), findsOneWidget);
    });
  });

  group('when state changes these widgets should render', () {
    testWidgets(
        'LoadingWidget should render when state is MostPopularAuthorsListLoading',
        (WidgetTester tester) async {
      when(authorsListProvider.state).thenReturn(MostPopularAuthorsListLoading());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const HomePage())));

      expect(find.byKey(const Key('loading')), findsOneWidget);
    });
    testWidgets('Text should render when state is MostPopularAuthorsListEmpty',
        (WidgetTester tester) async {
      when(authorsListProvider.state).thenReturn(MostPopularAuthorsListEmpty());
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const HomePage())));
      expect(find.text('Empty Author'), findsOneWidget);
    });

    testWidgets(
        'AuthorsListCard should render when state is MostPopularAuthorsListLoaded',
        (WidgetTester tester) async {
      when(authorsListProvider.state)
          .thenReturn(const MostPopularAuthorsListLoaded([authorEntity]));
      await tester.pumpWidget(
          _makeTestableWidget(_makeTestableWidget(const HomePage())));

      expect(find.byKey(const Key('authorsList')), findsOneWidget);
    });

    testWidgets('Text should render when state is NominatedBooksListErrorState',
            (WidgetTester tester) async {
          when(authorsListProvider.state).thenReturn(const MostPopularAuthorsListError('Error occurred.'));
          await tester.pumpWidget(
              _makeTestableWidget(_makeTestableWidget(const HomePage())));
          expect(find.byKey( const Key('Error')), findsOneWidget);
        });
  });
}
