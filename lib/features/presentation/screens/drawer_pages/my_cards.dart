import 'package:auto_route/annotations.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyCardsPage extends StatelessWidget {
  const MyCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).appBarTheme.backgroundColor,),
      body: Center(
        child:  VeryBigText(
          'My Cards Page',
          fontWeight: FontWeight.w500,
          context: context,
        ),
      ),
    );
  }
}
