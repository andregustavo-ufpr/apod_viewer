import 'package:flutter/material.dart';

class SearchFiltersTitle extends StatelessWidget{
  const SearchFiltersTitle({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.filter_list
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Filters",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        )
      ],
    );
  }

}