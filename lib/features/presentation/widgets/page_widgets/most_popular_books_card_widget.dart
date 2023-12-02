import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/screens/book_details_page.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/sizes/app_text.dart';
import '../../../domain/entity/most_popular_books_entity.dart';


class MostPopularBooksCardWidget extends StatelessWidget {
  const MostPopularBooksCardWidget({super.key, required this.mostPopularBooksEntity});

  final MostPopularBooksEntity mostPopularBooksEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: (){


        appRouter.push(BookDetailsRoute(bookId: mostPopularBooksEntity.bookId!));

        context.read<BookDetailsBloc>().add(GetBookDetails(mostPopularBooksEntity.bookId!));
          },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    detailBigPicture(mostPopularBooksEntity.image!),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          VeryBigText(
                            mostPopularBooksEntity.name!,
                            context: context,
                          ),
                          const SizedBox(height: 20),
                          buildRating(mostPopularBooksEntity.rating!),
                          const SizedBox(height: 10.0),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: MediumText(
                          //     'Tap to read',
                          //     context: context,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Divider(),
                )
              ],
            )),
      ),
    );
  }
}