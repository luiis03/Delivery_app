import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/dimensions.dart';

class SearchBarInput extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 45,
          width: 300,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Buscar ',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              prefixStyle: TextStyle(color: Colors.white),
              suffixStyle: TextStyle(color: Colors.white),
              counterStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

}