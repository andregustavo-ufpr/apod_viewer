import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/default_appbar.dart';
import 'package:nasa_apod_viewer/features/navigation_bar/bottom_navigation_bar.dart';
import 'package:nasa_apod_viewer/features/search_page/components/search_date_button.dart';

class _SearchState extends State<Search>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        onLeading: null,
        title: "Search",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: kToolbarHeight + 20
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SearchDateButton(), // TODO: Add callback so the search page saves the date to send to api
                  SearchDateButton()
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        pageIndex: 2,
      ),
    );
  }

}

class Search extends StatefulWidget{
  const Search({super.key});
  
  @override
  State<Search> createState() => _SearchState();

}