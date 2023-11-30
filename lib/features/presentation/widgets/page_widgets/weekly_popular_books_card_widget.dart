import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/sizes/app_text.dart';
import '../../../domain/entity/weekly_popular_books_entity.dart';

class WeeklyPopularBooksCardWidget extends StatelessWidget {
  const WeeklyPopularBooksCardWidget(
      {super.key, required this.weeklyPopularBooksEntity});

  final WeeklyPopularBooksEntity weeklyPopularBooksEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          appRouter
              .push(BookDetailsRoute(bookId: weeklyPopularBooksEntity.bookId!));

          context
              .read<BookDetailsBloc>()
              .add(GetBookDetails(weeklyPopularBooksEntity.bookId!));
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    detailBigPicture(weeklyPopularBooksEntity.image!),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          VeryBigText(
                            weeklyPopularBooksEntity.name!,
                            context: context,
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {},
                            child: MediumText(
                              'Tap to read',
                              context: context,
                            ),
                          ),
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
