import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/dropdown_exposer.dart';

class _MoreInfoState extends State<MoreInfo>{

  @override
  Widget build(BuildContext context) {

    return DropdownExposer(
      collapsableText: "Astronomy Picture of the Day (APOD) is a website "
        "provided by NASA and Michigan Technological University (MTU). "
        "It reads: Each day a different image or photograph of our universe "
        "is featured, along with a brief explanation written by a "
        "professional astronomer.",
      label: "About this project",
      labelSize: 12,
      iconSize: 10,
      startOpened: true,
    );
  }

}

class MoreInfo extends StatefulWidget{
  const MoreInfo({super.key});


  @override
  State<MoreInfo> createState() => _MoreInfoState();
}