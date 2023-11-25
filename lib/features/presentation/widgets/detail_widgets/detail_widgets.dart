import 'package:flutter/material.dart';

Row buildRating(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      const SizedBox(width: 20),
      Text(rating.toString()),
    ],
  );
}