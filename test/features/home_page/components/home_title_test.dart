import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod_viewer/features/home_page/components/home_title.dart';

void main(){
  group("Home Title component test", (){
    testWidgets("Check if title renders", (tester) async {
      await tester.pumpWidget(
        const Material(
          child: Directionality(
            textDirection: TextDirection.ltr, 
            child: HomeTitle()
          ),
        )
      );

      final finder = find.text("Astronomy Picture of the Day");
      expect(finder, findsOneWidget);
    });
  });
}