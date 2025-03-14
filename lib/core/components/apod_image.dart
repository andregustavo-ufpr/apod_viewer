import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';

class ApodImage extends StatelessWidget{
  const ApodImage({required this.apod, super.key});

  final Apod apod;

  @override
  Widget build(BuildContext context) {
    if(apod.imageUrl == null || apod.imageUrl!.isEmpty){
      return Center(
        child: Text("Unavailable Image"),
      );
    }

    return Image(
      image: CachedNetworkImageProvider(
        apod.imageUrl ?? ""
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
    );
  }
}