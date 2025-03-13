import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/dropdown_exposer.dart';
import 'package:nasa_apod_viewer/core/components/interactive_image_viewer.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/page_routes/transparent_page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ApodViewerState extends State<ApodViewer>{

  bool favorite = false;

  @override
  void initState() {
    _checkFavorite().then((bool isFavorite) {
      setState(() => favorite = isFavorite);
    });

    super.initState();
  }

  Future<bool> _checkFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList("FAVORITES") ?? [];

    return favorites.contains(jsonEncode(widget.apod.toMap()));
  }

  void _addToFavorites(){
    SharedPreferences.getInstance().then((prefs) {
      List<String> favorites = prefs.getStringList("FAVORITES") ?? [];
      
      favorites.add(jsonEncode(widget.apod.toMap()));
      prefs.setStringList("FAVORITES", favorites);

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
      List<String> favorites = prefs.getStringList("FAVORITES") ?? [];

      favorites.removeWhere((apod) => apod == jsonEncode(widget.apod.toMap()));
      prefs.setStringList("FAVORITES", favorites);

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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.apod.title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          Stack(
            children: [
              InkWell(
                onTap: () => _fullScreen(
                  context, 
                  NetworkImage(widget.apod.highResUrl ?? ""),
                ),
                onDoubleTap: _toggleFavorite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: NetworkImage(
                      widget.apod.imageUrl ?? ""
                    ),
                    errorBuilder: (context, exception, trace) {
                      return Container();
                    },
                    loadingBuilder: (
                      BuildContext context, 
                      Widget child, 
                      ImageChunkEvent? loadingProgress
                    ) {
                      if (loadingProgress == null) return child;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ? 
                              // ignore: lines_longer_than_80_chars
                              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                          ),
                        ),
                      );
                    },
                  ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(widget.apod.copyrightName != null)
                Expanded(
                  child: Text(
                    widget.apod.copyrightName!,
                    style: TextStyle(
                      fontSize: 12,
                      color: GRAY,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
            ],
          ),
          if(widget.apod.explanation != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: DropdownExposer(
                collapsableText: widget.apod.explanation!, 
                label: "Description",
                labelSize: 12,
                iconSize: 10,
              ),
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
    super.key
  });
  
  final Apod apod;
  final VoidCallback? callback;

  @override
  State<ApodViewer> createState() => _ApodViewerState();
}
