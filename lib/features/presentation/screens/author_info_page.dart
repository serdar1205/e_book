import 'package:auto_route/annotations.dart';
import 'package:e_book/core/colors/app_colors.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/author_info_card_widget.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthorsInfoPage extends StatelessWidget {
  //ok
  const AuthorsInfoPage({Key? key, required this.authorId}) : super(key: key);

  final int authorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Authors Info'),
      ),
      body: BlocBuilder<AuthorInfoBloc, AuthorInfoState>(
        builder: (context, state) {
          if (state is AuthorInfoLoading) {
            return const Center(
              child: LoadingWidget(
                key: Key('loading'),
              ),
            );
          } else if (state is AuthorInfoLoaded) {
            return _buildBody(
              authorInfoEntity: state.authorInfoEntity,
            );
          } else if (state is AuthorInfoEmpty) {
            return const Center(child: Text('Empty author info'));
          } else if (state is AuthorInfoError) {
            return Center(child: Text(key: const Key('Error'),state.error));
          } else {
            return const Center(child: Text('Something goes wrong!'));
          }
        },
      ),
    );
  }

  _buildBody({required AuthorInfoEntity authorInfoEntity}) {
    return Builder(builder: (context) {
      return ListView(
        key: const Key('scroll'),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          AuthorInfoCard(
            authorInfoEntity: authorInfoEntity,
          ),
          VeryBigText(
            key: const Key('title'),
            'About author',
            context: context,
          ),
          const Divider(color: AppColors.textLight),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: BookDescription(
              text: authorInfoEntity.info!,
            ),
          ),
          const Divider(color: AppColors.textLight),
          ListView.builder(
            key: const Key('list'),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shrinkWrap: true,
            itemCount: authorInfoEntity.authorBooks!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return AuthorsMoreBooksCard(
                authorInfoEntity: authorInfoEntity,
                index: index,
              );
            },
          )
        ],
      );
    });
  }
}
