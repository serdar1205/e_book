import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';

class BookDetailCardWidget extends StatelessWidget {
  const BookDetailCardWidget({super.key, required this.bookDetailEntity});

  final BookDetailEntity bookDetailEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            detailBigPicture(bookDetailEntity.image!),
            const SizedBox(width: 20.0),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  VeryBigText(
                    bookDetailEntity.name!,
                    context: context,
                  ),
                  const SizedBox(height: 10.0),
                  MediumText(
                    bookDetailEntity.author![0],
                    context: context,
                  ),
                  const SizedBox(height: 10),
                  MediumText(
                    bookDetailEntity.publishedDate!,
                    context: context,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(bookDetailEntity.rating.toString()),
                      const Text('|'),
                      MediumText(
                        '${bookDetailEntity.pages} pages',
                        context: context,
                      ),
                    ],
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
      ),
    );
  }
}
