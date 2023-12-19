import 'package:auto_route/annotations.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/most_popular_books/most_popular_books_provider.dart';


@RoutePage()
class MostPopularBooksPage extends StatelessWidget {
  const MostPopularBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Most Popular books'),
        ),
        body: Consumer<MostPopularBooksProvider>(
          builder: (context, provider, _) {
            final state = provider.state;
            if (state is MostPopularBooksLoading) {
              return const Center(
                child: LoadingWidget(key: Key('loading')),
              );
            } else if (state is MostPopularBooksLoaded) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                shrinkWrap: true,
                itemCount: state.mostPopularBooksEntity.length,
                itemBuilder: (BuildContext context, int index) {
                  return MostPopularBooksCardWidget(
                    key: const Key('mostPopularBooksCardWidget'),
                    mostPopularBooksEntity: state.mostPopularBooksEntity[index],
                  );
                },
              );
            } else if (state is MostPopularBooksEmpty) {
              return const Center(child: Text('Empty popular books'));
            }
            else if (state is MostPopularBooksError) {
              return Center(child: Text(key: const Key('Error'),state.error));
            } else {
              return const Center(child: Text(''));
            }
          },
        ));
  }
}
