import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

Widget pictureListCard(String image){
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    elevation: 4,
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: CachedNetworkImage(
        imageUrl:
        image,
        placeholder: (context, url) => const SizedBox(
          height: 150.0,
          width: 100.0,
          child: LoadingWidget(
            isImage: true,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/noPhoto.png',
          fit: BoxFit.cover,
          height: 150.0,
          width: 100.0,
        ),
        fit: BoxFit.cover,
        height: 150.0,
        width: 100.0,
      ),
    ),
  );
}

CachedNetworkImage detailBigPicture(String image) {
  return CachedNetworkImage(
    imageUrl: image,
    placeholder: (context, url) => const SizedBox(
      height: 200.0,
      width: 130.0,
      child: LoadingWidget(),
    ),
    errorWidget: (context, url, error) =>
    const Icon(Icons.error),
    fit: BoxFit.cover,
    height: 200.0,
    width: 130.0,
  );
}