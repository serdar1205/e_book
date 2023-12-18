import 'package:auto_route/annotations.dart';
import 'package:e_book/features/presentation/blocs/weekly_popular_books/weekly_popular_books_bloc.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class WeeklyPopularBooksPage extends StatelessWidget {
  const WeeklyPopularBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Weekly popular books'),
        ),
        body: Consumer<WeeklyPopularBooksProvider>(
          builder: (context, provider, _) {
            final state = provider.state;
            if (state is WeeklyPopularBooksLoading) {
              return const Center(
                child: LoadingWidget(key: Key('loading')),
              );
            } else if (state is WeeklyPopularBooksLoaded) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                shrinkWrap: true,
                itemCount: state.weeklyPopularBooksEntity.length,
                itemBuilder: (BuildContext context, int index) {
                  return WeeklyPopularBooksCardWidget(
                    key: const Key('weeklyPopularBooksCardWidget'),
                    weeklyPopularBooksEntity:
                        state.weeklyPopularBooksEntity[index],
                  );
                },
              );
            } else if (state is WeeklyPopularBooksEmpty) {
              return const Center(child: Text('Empty weekly popular books'));
            } else if (state is WeeklyPopularBooksError) {
              print(state.error);
              return Center(child: Text(key: const Key('Error'), state.error));
            } else {
              return const Center(child: Text(''));
            }
          },
        ));
  }
}
