import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/sizes/app_text.dart';
import 'widgets.dart';

class AuthorsMoreBooksCard extends StatelessWidget {
  //ok
  const AuthorsMoreBooksCard({
    super.key,
    required this.authorInfoEntity,
    required this.index,
  });

  final AuthorInfoEntity authorInfoEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              pictureListCard(
                'https://w0.peakpx.com/wallpaper/911/495/HD-wallpaper-the-lamp-blossom-flowers-nature-pink-pink-flowers-thumbnail.jpg',
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BigText(
                      authorInfoEntity.authorBooks![index].name!,
                      context: context,
                    ),
                    const SizedBox(height: 10),
                    buildRating(authorInfoEntity.authorBooks![index].rating!),
                    const SizedBox(height: 15.0),
                    SmallText(
                      authorInfoEntity.authorBooks![index].date!.toString(),
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
