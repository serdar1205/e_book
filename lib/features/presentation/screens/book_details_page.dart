import 'package:auto_route/annotations.dart';
import 'package:e_book/core/sizes/app_text.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/book_detail_card_widget.dart';
import 'package:e_book/features/presentation/widgets/detail_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_colors.dart';
import '../providers/book_details/book_details_provider.dart';

@RoutePage()
class BookDetailsPage extends StatelessWidget {
  final int bookId;
  const BookDetailsPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Book Details'),
      ),
      body: Consumer<BookDetailsProvider>(
        builder: (context, provider, child) {
          final state = provider.state;
          if (state is BookDetailsLoading) {
            return const Center(
              child: LoadingWidget(key: Key('loading')),
            );
          } else if (state is BookDetailsLoaded) {
            return _buildBody(bookDetailEntity: state.bookDetailEntity);
          } else if (state is BookDetailsError) {
            return Center(child: Text(key:const Key('Error'),state.error));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

   _buildBody( {required BookDetailEntity bookDetailEntity}) {
    return Builder(
      builder: (context) {
        return ListView(
            key: const Key('scroll'),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  BookDetailCardWidget(bookDetailEntity: bookDetailEntity,),
                  VeryBigText(
                    'Book description',
                    context: context,
                  ),
                  const Divider(color: AppColors.textLight),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: BookDescription(
                      text: bookDetailEntity.synopsis!,
                    ),
                  ),
                  const Divider(color: AppColors.textLight),
                ],
              );
      }
    );
  }
}


