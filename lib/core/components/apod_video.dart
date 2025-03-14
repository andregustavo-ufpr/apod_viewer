import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class _ApodVideoState extends State<ApodVideo>{
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.apod.imageUrl!.split("/")[4].substring(0, 11),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller,);
  }
}
 
class ApodVideo extends StatefulWidget{
  const ApodVideo({
    required this.apod, 
    super.key
  });

  final Apod apod;

  @override
  State<ApodVideo> createState() => _ApodVideoState();

}
