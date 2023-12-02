import 'package:auto_route/annotations.dart';
import 'package:e_book/core/colors/app_colors.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  int lang = 0;
  List<String> lan = ['Turkmen dili','Rus dili'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).appBarTheme.backgroundColor,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      InkWell(
                        onTap:(){
                          setState((){
                            lang = index;
                          });

                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 5),

                          child: SmallText(lan[index],context: context,),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}