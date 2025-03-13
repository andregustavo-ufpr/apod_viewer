import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_viewer.dart';
import 'package:nasa_apod_viewer/core/components/default_appbar.dart';
import 'package:nasa_apod_viewer/core/constants/shared_preferences.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/features/navigation_bar/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FavoritesState extends State<Favorites>{
  
  List<Apod> favoriteImages = [];

  @override
  void initState(){
    _buildFavoriteImages();
    super.initState();
  }

  void _buildFavoriteImages(){
    SharedPreferences.getInstance().then((prefs){
      List<String> storedImages = prefs.getStringList(favoritesList) ?? [];
      List<Apod> treatedImages = [];

      for(String image in storedImages){
        treatedImages.add(Apod.fromMap(jsonDecode(image)));
      }

      setState(() {
        favoriteImages = treatedImages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        onLeading: null,
        title: "Favorites",
      ),
      backgroundColor: WHITE,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: kToolbarHeight + 20
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (c, i) => ApodViewer(
              apod: favoriteImages[i],
              callback: _buildFavoriteImages,
            ), 
            separatorBuilder: (c, i) => const SizedBox(
              height: 8,
            ),  
            itemCount: favoriteImages.length
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        pageIndex: 1, 
      ),
    ); 
  }

}

class Favorites extends StatefulWidget{
  const Favorites({super.key});
  
  @override
  State<Favorites> createState() => _FavoritesState();

}