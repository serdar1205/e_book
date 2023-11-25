import 'package:auto_route/annotations.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:  VeryBigText(
          'Chat Page',
          fontWeight: FontWeight.w500,
          context: context,
        ),
      ),
    );
  }
}
