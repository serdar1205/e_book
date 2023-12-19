// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../blocs/most_popular_authors_list/most_popular_authors_provider.dart';
//
//
// class AuthorPage extends StatelessWidget {
//   const AuthorPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: BlocBuilder<MostPopularAuthorsListBloc, MostPopularAuthorsListState>(
//             builder: (context, state) {
//               if (state is MostPopularAuthorsListLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (state is MostPopularAuthorsListLoaded) {
//                 return Text(state.authors[0].name!);
//               } else if (state is MostPopularAuthorsListEmpty) {
//                 return const Center(child: Text('Empty Author'));
//               } else if (state is MostPopularAuthorsListError) {
//                 return Center(child: Text(state.message));
//               } else {
//                 return const Center(child: Text(''));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
