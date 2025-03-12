import 'package:flutter/material.dart';

class Apod with ChangeNotifier{
  String? imageUrl;
  String? title;
  String? author;
  String? explanation;
  DateTime? date;

  Apod({
    this.author,
    this.date,
    this.explanation,
    this.imageUrl,
    this.title
  });

  Map<String, dynamic> toMap(){
    return {
      "copyright": author ?? "",
      "date": date.toString(),
      "explanation": explanation ?? "",
      "url": imageUrl ?? "",
      "title": title ?? ""
    };
  }

  static Apod fromMap(Map<String, dynamic> map){
    return Apod(
      author: "André Gustavo Silveira",
      date: DateTime.tryParse(map["date"]),
      explanation: map["explanation"],
      imageUrl: map["url"],
      title: map["title"]
    );
  }

  String? get authorName {
    if(author != null){
      return author!.replaceAll("\n", "");
    }

    return author;
  }

}