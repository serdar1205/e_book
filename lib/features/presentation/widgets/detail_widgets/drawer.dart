import 'package:e_book/core/colors/app_colors.dart';
import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  final List<String> names = [
    'Log in',
    'My Cards',
    'Chat',
    'Dili',
    'Biz barada',
  ];
  final List<IconData> icons = [
    Icons.login,
    Icons.credit_card,
    Icons.chat,
    Icons.language,
    Icons.info_rounded,
  ];

  final navigators = [
    const LoginRoute(),
    const MyCardsRoute(),
    const ChatRoute(),
    const LanguageRoute(),
    const AboutUsRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 2 + 70,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                color: Theme.of(context).drawerTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, int index) {
              return iconAndTitle(
                  context: context,
                  title: names[index],
                  icon: icons[index],
                  onPress: () {
                    appRouter.push(navigators[index]);
                  });
            })),
        Positioned(
          right: 1,
          top: 20,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 2.0,
            fillColor: AppColors.mainbuttonColor,
            shape: const CircleBorder(),
            child: const SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
                key: Key('back'),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.mainbuttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text(
                "Komek gerkmi?",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ],
    );
  }
}

iconAndTitle({
  String? title,
  IconData? icon,
  VoidCallback? onPress,
  Key? key,
  required BuildContext context,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
           Icon(
            icon,
            size: 20,
          ),

          Container(
            padding: const EdgeInsets.only(left: 10, top: 13, bottom: 13),
            child: SmallText(
              title!,
              context: context,
            ),
          ),
          // Divider(thickness: 1,indent: 5,endIndent: 5,height: 4,)
        ],
      ),
    ),
  );
}
