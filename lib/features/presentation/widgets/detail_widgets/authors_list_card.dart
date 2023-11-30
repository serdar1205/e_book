import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picture_widgets.dart';

class AuthorsListCard extends StatelessWidget {
  const AuthorsListCard({super.key, required this.authorsEntity});

  final MostPopularAuthorsEntity authorsEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {

          appRouter.push(AuthorsInfoRoute(authorId: authorsEntity.authorId!));

          context
              .read<AuthorInfoBloc>()
              .add(GetAuthorInfo(authorsEntity.authorId!));
        },
        child: SizedBox(
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              pictureListCard(authorsEntity.image!),
              const SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BigText(
                      authorsEntity.name!,
                      context: context,
                    ),
                    const SizedBox(height: 10),
                    Material(
                      type: MaterialType.transparency,
                      child: SmallText(
                        authorsEntity.popularBookTitle!,
                        context: context,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    SmallText(
                      'Published books: ${authorsEntity.numberPublishedBooks!}',
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
