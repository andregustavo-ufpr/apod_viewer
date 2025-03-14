import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod_viewer/features/home_page/components/todays_image.dart';

void main(){
  group("Todays Image component test", (){
    testWidgets("Check if Image renders", (tester) async {
      await tester.pumpWidget(
        const Material(
          child: Directionality(
            textDirection: TextDirection.ltr, 
            child: TodaysImage()
          ),
        )
      );

      final finder = find.text( 
        "Discover!"
      );
      expect(finder, findsOneWidget);
    });
  });
}