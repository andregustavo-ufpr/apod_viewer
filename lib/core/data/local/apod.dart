import 'package:flutter/material.dart';

class Apod with ChangeNotifier{
  DateTime? date;
  String? copyright;
  String? explanation;
  String? highResUrl;
  String? imageUrl;
  String? mediaType;
  String? title;

  Apod({
    this.copyright,
    this.date,
    this.explanation,
    this.highResUrl,
    this.imageUrl,
    this.mediaType,
    this.title,
  });

  Map<String, dynamic> toMap(){
    return {
      "copyright": copyright,
      "date": date.toString(),
      "explanation": explanation,
      "hdurl": highResUrl,
      "media_type": mediaType,
      "title": title,
      "url": imageUrl,
    };
  }

  static Apod fromMap(Map<String, dynamic> map){
    return Apod(
      copyright: map["copyright"],
      date: DateTime.tryParse(map["date"]),
      explanation: map["explanation"],
      highResUrl: map["hdurl"],
      imageUrl: map["url"],
      mediaType: map["media_type"],
      title: map["title"],
    );
  }

  String? get copyrightName {
    if(copyright != null){
      return copyright!.replaceAll("\n", "");
    }

    return copyright;
  }

}