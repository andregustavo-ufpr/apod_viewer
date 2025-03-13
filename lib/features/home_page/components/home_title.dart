import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget{
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Astronomy Picture of the Day",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
    );
  }

}