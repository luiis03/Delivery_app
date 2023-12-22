import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/dimensions.dart';

class SearchBarInput extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Buscar...',
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Icon(
              Icons.search,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                FocusScope.of(context).unfocus();
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textColor),
            ),
            focusColor: AppColors.naranja,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.naranja),
            ),
            hintStyle: TextStyle(color: AppColors.textColor),
            labelStyle: TextStyle(color: AppColors.textColor),
            prefixStyle: TextStyle(color: AppColors.textColor),
            suffixStyle: TextStyle(color: AppColors.textColor),
            counterStyle: TextStyle(color: AppColors.textColor),
          ),
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
    );
  }



}
