import 'package:flutter/material.dart';
import '../../../../core/sizes/app_text.dart';

class BookDescription extends StatefulWidget {
  const BookDescription({super.key, required this.text});

  final String text;

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  late String firstHalf;

  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();
    _splitText();
  }

  void _splitText() {
    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? MediumText(
        (flag ? firstHalf : (firstHalf + secondHalf))
            .replaceAll(r'\n', '\n')
            .replaceAll(r'\r', '')
            .replaceAll(r"\'", "'"),
        context: context,
      )
          : Column(
        children: <Widget>[
          MediumText(
            (flag ? ('$firstHalf...') : (firstHalf + secondHalf))
                .replaceAll(r'\n', '\n\n')
                .replaceAll(r'\r', '')
                .replaceAll(r"\'", "'"),
            context: context,
          ),
          GestureDetector(
            key: Key("show"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SmallText(
                  flag ? 'show more' : 'show less',
                  context: context,
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}