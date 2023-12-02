import 'package:e_book/core/routers/app_router.dart';
import 'package:e_book/core/routers/app_routes.dart';
import 'package:e_book/features/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

//ok
class MainCategoryCard extends StatelessWidget {
  MainCategoryCard({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<String> categoryNames = [
    'Nominated books',
    'Awarded books',
    'Weekly popular books',
    'Most popular books',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:
          appRouter.push(const NominatedBooksRoute());  // Navigator.of(context).pushNamed(AppRoutesConstant.nominatedBooksRoute);
              break;
            case 1:
              appRouter.push(const AwardedBooksRoute());  // Navigator.of(context).pushNamed(AppRoutesConstant.awardedBooksRoute);
              break;
            case 2:
              appRouter.push(const WeeklyPopularBooksRoute()); // Navigator.of(context).pushNamed(AppRoutesConstant.weeklyPopularBooksRoute);
              break;
            case 3:
              appRouter.push(const MostPopularBooksRoute()); //Navigator.of(context).pushNamed(AppRoutesConstant.mostPopularBooksRoute);
              break;
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/library.jpg',
                        fit: BoxFit.contain,
                        height: 120,
                        width: 170,
                        errorBuilder: (context, url, error) => Image.asset(
                          'assets/images/noPhoto.png',
                          fit: BoxFit.contain,
                          height: 90,
                          width: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoryNames[index],
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white, letterSpacing: 0.2),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
