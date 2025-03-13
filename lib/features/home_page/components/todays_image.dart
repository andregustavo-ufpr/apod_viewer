import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_viewer.dart';
import 'package:nasa_apod_viewer/core/components/loading_gradient.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/domain/services/nasa_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TodaysImageState extends State<TodaysImage>{
  Apod? todaysImage;
  bool error = false,
    loading = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String? lastSetDate = prefs.getString("LAST_SET");

      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

      if(lastSetDate != null && !DateTime.parse(lastSetDate).isBefore(yesterday)){
        String? storedImage = prefs.getString("TODAYS");
        
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
          error = true;
          loading = false;
        });
      }

      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("TODAYS", jsonEncode(r));
        prefs.setString("LAST_SET", DateTime.now().toIso8601String());
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
          color: WHITE,
          border: Border.all(color: BLACK),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text("Discover!")
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