import 'package:auto_route/annotations.dart';
import 'package:e_book/features/presentation/blocs/awarded_books/awarded_books_bloc.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/features/presentation/widgets/page_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocBuilder<AwardedBooksBloc, AwardedBooksState>(
          builder: (context, state) {
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
              return Center(child: Text(key:const Key('Error'),state.error));
            } else {
              return const Center(child: Text(''));
            }
          },
        ));
  }
}
