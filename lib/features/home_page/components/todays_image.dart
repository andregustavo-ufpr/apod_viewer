import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_viewer.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/domain/services/nasa_api_service.dart';

class _TodaysImageState extends State<TodaysImage>{
  Apod? todaysImage;
  bool error = false,
    loading = false;

  void _searchTodaysImage(){
    setState(() => loading = true);

    NasaApiService().searchApod().then((r) {
      print(r);
      if(!r["success"]){
        setState(() {
          error = true;
          loading = false;
        });
      }

      setState(() {
        todaysImage = Apod.fromMap(r);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Move to different component
    if(todaysImage != null){
      return Center(
        child: ApodViewer(
          apod: todaysImage!
        )
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
        child: Center(child: Text("Load todays Picture!")),
      ),
    );

    
  }

}

class TodaysImage extends StatefulWidget{
  const TodaysImage({super.key});

  @override
  State<TodaysImage> createState() => _TodaysImageState();

}