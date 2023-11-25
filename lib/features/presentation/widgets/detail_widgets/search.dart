
import 'package:e_book/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: TextField(
        style: const TextStyle(
            fontSize: 14),
        decoration: InputDecoration(
            hintText: Strings.searchText,
            hintStyle: const TextStyle(
                color: AppColors.textGray
            ),
            prefixIcon: Container(
                height: 10,width: 10,
                margin: const EdgeInsets.all(5),
                child: const Icon(Icons.search, size: 20,)),
            prefixIconColor: Colors.black26,
            //focusColor: Colors.black26,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            fillColor:Colors.grey[300],
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 5)
        ),
      ),
    );
  }
}
