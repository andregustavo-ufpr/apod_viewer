import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_viewer.dart';
import 'package:nasa_apod_viewer/core/components/loading_gradient.dart';
import 'package:nasa_apod_viewer/core/constants/shared_preferences.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/domain/services/nasa_api_service.dart';
import 'package:nasa_apod_viewer/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TodaysImageState extends State<TodaysImage>{
  Apod? todaysImage;
  bool loading = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String? lastSetDate = prefs.getString(lastImagesSetDate);

      DateTime yesterday = DateTime.now().copyWith(hour: 0, minute: 0);

      if(lastSetDate != null && !(DateTime.parse(lastSetDate).isBefore(yesterday))){
        String? storedImage = prefs.getString(todaysSetImage);
        
        if(storedImage != null){
          setState(() {
            todaysImage = Apod.fromMap(jsonDecode(storedImage));
          });
        }
      }
    });
    super.initState();
  }

  void _searchTodaysImage(){
    setState(() => loading = true);

    NasaApiService().searchApod().then((r) {
      if(!r["success"]){
        setState(() {
          loading = false;
        });

        if(context.mounted){
          snackbar(
            context: context,
            children: [
              Text(
                r["msg"] ?? "Failed to retrieve todays image. Try again later",
                style: TextStyle(
                  color: WHITE,
                  fontSize: 16
                ),
              )
            ]
          );
        }
      }

      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(todaysSetImage, jsonEncode(r));
        prefs.setString(lastImagesSetDate, DateTime.now().toIso8601String());
      });

      setState(() {
        todaysImage = Apod.fromMap(r);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(todaysImage != null){
      return Center(
        child: ApodViewer(
          apod: todaysImage!
        )
      );
    }

    if(loading){
      return Center(
        child: LoadingGradient(
          height: 200,
        ),
      );
    }

    return InkWell(
      onTap: _searchTodaysImage,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: DARK_BLUE,
          border: Border.all(color: DARK_BLUE),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: BLUE_BG,
                size: 20,
              ),
              SizedBox( width: 8,),
              Text(
                "Discover!",
                style: TextStyle(
                  color: BLUE_BG,
                  fontSize: 20
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

}

class TodaysImage extends StatefulWidget{
  const TodaysImage({super.key});

  @override
  State<TodaysImage> createState() => _TodaysImageState();

}