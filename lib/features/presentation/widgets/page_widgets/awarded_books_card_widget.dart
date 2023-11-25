import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/presentation/blocs/book_details/book_details_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwardedBooksCardWidget extends StatelessWidget {
  //ok
  const AwardedBooksCardWidget({super.key, required this.awardedBooksEntity});

  final AwardedBooksEntity awardedBooksEntity;



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: (){
         // Navigator.of(context).pushNamed(AppRoutesConstant.bookDetailsRoute);
          Navigator.of(context).push( MaterialPageRoute(builder: (_) =>
              BookDetailsPage(bookId: awardedBooksEntity.bookId!)));

          context.read<BookDetailsBloc>().add(GetBookDetails(awardedBooksEntity.bookId!));
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    detailBigPicture(awardedBooksEntity.image!),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          VeryBigText(
                            awardedBooksEntity.name!,
                            context: context,
                          ),
                          const SizedBox(height: 10.0),
                          MediumText(
                            awardedBooksEntity.winningCategory!,
                            context: context,
                          ),
                          const SizedBox(height: 10),
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
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Divider(),
                )
              ],
            )),
      ),
    );
  }
}