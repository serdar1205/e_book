import 'package:e_book/core/sizes/app_text.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/entity.dart';
import 'detail_widgets.dart';
import 'picture_widgets.dart';

class AuthorInfoCard extends StatelessWidget {
  const AuthorInfoCard({super.key,required this.authorInfoEntity});
  final AuthorInfoEntity authorInfoEntity;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 30),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    detailBigPicture(authorInfoEntity.image!),
                    const SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          VeryBigText(
                            authorInfoEntity.name!,
                            context: context,
                          ),
                          const SizedBox(height: 10.0),
                          _setChipView(authorInfoEntity.genres, context),
                          const SizedBox(height: 10),
                          buildRating(authorInfoEntity.rating!),
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
  Widget _setChipView(List<String>? genres, BuildContext context) {
    var size = genres?.length ?? 0;
    return Container(
      alignment: AlignmentDirectional.topStart,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8,
        children: [
          for (var i = 0; i < size; i++)
            MediumText(genres![i], context: context)
        ],
      ),
    );
  }
}