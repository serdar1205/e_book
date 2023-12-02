import 'package:auto_route/annotations.dart';
import 'package:e_book/features/presentation/blocs/nominated_books/nominated_books_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/detail_widgets/loading_widget.dart';
import '../widgets/page_widgets/nominated_books_card_widget.dart';

@RoutePage()
class NominatedBooksPage extends StatelessWidget {
  const NominatedBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Nominated books'),
        ),
        body: BlocBuilder<NominatedBooksListBloc, NominatedBooksListState>(
          builder: (context, state) {
            if (state is NominatedBooksListLoadingState) {
              return const Center(
                child: LoadingWidget(key: Key('loading'),),
              );
            } else if (state is NominatedBooksListLoadedState) {
              return ListView.builder(
                key: Key('Nominated_books_list'),
                scrollDirection: Axis.vertical,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                shrinkWrap: true,
                itemCount: state.nominatedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return NominatedBooksCardWidget(
                    key: const Key('nominatedBooksCard'),
                    nominatedBooksEntity: state.nominatedBooks[index],
                  );
                },
              );
            } else if (state is NominatedBooksListEmptyState) {
              return const Center(child: Text('Empty Nominated books'));
            } else if (state is NominatedBooksListErrorState) {
              print(state.error);
              return Center(child: Text(key:const Key('Error'),state.error));
            } else {
              return const Center(child: Text(''));
            }
          },
        ));
  }
}
