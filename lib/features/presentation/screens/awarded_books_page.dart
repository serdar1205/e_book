import 'package:auto_route/annotations.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/awarded_books/awarded_books_provider.dart';

@RoutePage()
class AwardedBooksPage extends StatelessWidget {
  const AwardedBooksPage({Key? key}) : super(key: key);

//ok
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Awarded books'),
        ),
        body: Consumer<AwardedBooksProvider>(
          builder: (context, provider, _) {
            final state = provider.state;
            if (state is AwardedBooksLoading) {
              return const Center(
                child: LoadingWidget(key: Key('loading')),
              );
            } else if (state is AwardedBooksLoaded) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                shrinkWrap: true,
                itemCount: state.awardedBooksEntity.length,
                itemBuilder: (BuildContext context, int index) {
                  return AwardedBooksCardWidget(
                    key: const Key('awardedBooksCard'),
                    awardedBooksEntity: state.awardedBooksEntity[index],
                  );
                },
              );
            } else if (state is AwardedBooksEmpty) {
              return const Center(child: Text('Empty Awarded books'));
            } else if (state is AwardedBooksError) {
              print(state.error);
              return Center(child: Text(key: const Key('Error'), state.error));
            } else {
              return const Center(child: Text(''));
            }
          },
        ));
  }
}
