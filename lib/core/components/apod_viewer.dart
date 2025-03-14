import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_image.dart';
import 'package:nasa_apod_viewer/core/components/apod_video.dart';
import 'package:nasa_apod_viewer/core/components/dropdown_exposer.dart';
import 'package:nasa_apod_viewer/core/components/interactive_image_viewer.dart';
import 'package:nasa_apod_viewer/core/constants/shared_preferences.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/page_routes/transparent_page_route.dart';
import 'package:nasa_apod_viewer/utils/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ApodViewerState extends State<ApodViewer>{

  bool favorite = false;

  @override
  void initState() {

    if(!widget.favoritePage){
      _checkFavorite().then((bool isFavorite) {
        setState(() => favorite = isFavorite);
      });
      return;
    }

    setState(() {
      favorite = true;
    });
    super.initState();
  }

  Future<bool> _checkFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesList) ?? [];

    return favorites.contains(jsonEncode(widget.apod.toMap()));
  }

  void _addToFavorites(){
    SharedPreferences.getInstance().then((prefs) {
      List<String> favorites = prefs.getStringList(favoritesList) ?? [];
      
      favorites.add(jsonEncode(widget.apod.toMap()));
      prefs.setStringList(favoritesList, favorites);

      setState(() => favorite = true);
    });
  }

  void _fullScreen(BuildContext context, ImageProvider image){
    Navigator.of(context).push(
      TransparentPageRoute(
        builder: (context) => InteractiveImageViewer(
          image: image
        )
      )
    );
  }

  void _removeFromFavorites(){
    SharedPreferences.getInstance().then((prefs) {
      List<String> favorites = prefs.getStringList(favoritesList) ?? [];

      favorites.removeWhere((apod) => apod == jsonEncode(widget.apod.toMap()));
      prefs.setStringList(favoritesList, favorites);

      setState(() => favorite = false);
    });
  }

  void _toggleFavorite(){
    if(!favorite){
      _addToFavorites();
      return;
    }

    _removeFromFavorites();

    if(widget.callback != null){
      widget.callback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BLUE_BG,
        border: Border.all(
          color: LIGHT_BLUE,
          width: 1
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.apod.title != null)
            Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 16,
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    widget.apod.title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          if(widget.apod.date != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    visualFormatDate(widget.apod.date!),
                    style: TextStyle(
                      fontSize: 12,
                      color: GRAY
                    ),
                  )
                ]
              ),
            ),
          Stack(
            children: [
              InkWell(
                onTap: () => _fullScreen(
                  context, 
                  CachedNetworkImageProvider(widget.apod.highResUrl ?? ""),
                ),
                onDoubleTap: _toggleFavorite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: (widget.apod.mediaType ?? "image") == "image" ? 
                    ApodImage(apod: widget.apod)
                  :
                    ApodVideo(apod: widget.apod)
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: (favorite ? DARK_BLUE : BLUE_BG).withOpacity(0.6),
                      border: Border.all(color: favorite ? DARK_BLUE : BLACK),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: favorite ? WHITE : BLACK,
                          size: 12,
                        ),
                      ]
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          if(widget.apod.copyrightName != null && widget.apod.copyrightName!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                widget.apod.copyrightName!,
                style: TextStyle(
                  fontSize: 12,
                  color: GRAY,
                  fontWeight: FontWeight.w300
                ),
              ),
            ),
          if(widget.apod.explanation != null)
            DropdownExposer(
              collapsableText: widget.apod.explanation!, 
              label: "Description",
              labelSize: 12,
              iconSize: 10,
            ),
        ],
      ),
    );
  }
}

class ApodViewer extends StatefulWidget{

  const ApodViewer({
    required this.apod,
    this.callback,
    this.favoritePage = false,
    super.key
  });
  
  final Apod apod;
  final VoidCallback? callback;
  final bool favoritePage;

  @override
  State<ApodViewer> createState() => _ApodViewerState();
}
