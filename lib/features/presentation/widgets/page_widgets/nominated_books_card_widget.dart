import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/picture_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/book_details/book_details_provider.dart';


class NominatedBooksCardWidget extends StatelessWidget {
  const NominatedBooksCardWidget({super.key, required this.nominatedBooksEntity});

  final NominatedBooksEntity nominatedBooksEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap:(){


          appRouter.push(BookDetailsRoute(bookId: nominatedBooksEntity.bookId!));

          context.read<BookDetailsProvider>().getBookDetailsById(nominatedBooksEntity.bookId!);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    detailBigPicture(nominatedBooksEntity.image!),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          VeryBigText(
                            nominatedBooksEntity.bookName!,
                            context: context,
                          ),
                          const SizedBox(height: 10.0),
                          MediumText(
                            nominatedBooksEntity.author!,
                            context: context,
                          ),
                          const SizedBox(height: 10),
                          MediumText(
                            'votes: ${nominatedBooksEntity.votes!}',
                            context: context,
                          ),
                          const SizedBox(height: 10),
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