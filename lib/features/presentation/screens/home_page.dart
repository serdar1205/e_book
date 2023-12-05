import 'package:auto_route/annotations.dart';
import 'package:e_book/core/constants/constants.dart';
import 'package:e_book/features/presentation/blocs/most_popular_authors_list/most_popular_authors_bloc.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/search.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:e_book/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/sizes/app_text.dart';
import '../../../core/themes/app_theme.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

//ok
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _myAppBar(context),
        drawer: MyDrawer(
          key: const ValueKey("drawer"),
        ),
        body: SingleChildScrollView(
          key: const Key('mySingleChildScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Search(),
              _mainGrid(),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                child: VeryBigText(
                  'Authors',
                  fontWeight: FontWeight.w500,
                  context: context,
                ),
              ),
              _authorsList(),
              // _mainLibraryGrid(),
            ],
          ),
        ),
      ),
    );
  }

  _myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        Strings.appName,
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            //  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                //locator<ThemeServices>().switchTheme();
                locator<ThemeProvider>().toggleTheme();
              },
              icon: const Icon(Icons.wb_sunny_outlined)),
        ),
      //  ChangeTheme(),
      ],
      centerTitle: true,
    );
  }

  _mainGrid() {
    return SizedBox(
      height: 280,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 210,
          childAspectRatio: 1.4,
        ),
        padding: const EdgeInsets.all(8.0),
        // padding around the grid
        itemCount: 4,
        // total number of items
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(7.0),
            child: MainCategoryCard(
              index: index,
            ),
          );
        },
      ),
    );
  }

  _authorsList() {
    return BlocBuilder<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
      builder: (context, state) {
        if (state is MostPopularAuthorsListLoading) {
          return const Center(
            child: LoadingWidget(key: Key('loading'),),
          );
        } else if (state is MostPopularAuthorsListLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.authors.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: AuthorsListCard(key: const Key('authorsList'),
                    authorsEntity: state.authors[index],
                  ),
                ),
              );
            },
          );
        } else if (state is MostPopularAuthorsListEmpty) {
          return const Center(child: Text('Empty Author'));
        } else if (state is MostPopularAuthorsListError) {
          return Center(child: Text( key:const Key('Error'),state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
