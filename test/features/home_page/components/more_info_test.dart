import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod_viewer/core/components/dropdown_exposer.dart';
import 'package:nasa_apod_viewer/features/home_page/components/more_info.dart';

void main(){
  group("More Info component test", (){
    testWidgets("Check if info renders", (tester) async {
      await tester.pumpWidget(
        const Material(
          child: Directionality(
            textDirection: TextDirection.ltr, 
            child: MoreInfo()
          ),
        )
      );

      final finder = find.widgetWithText(
        DropdownExposer, 
        "Astronomy Picture of the Day (APOD) is a website "
        "provided by NASA and Michigan Technological University (MTU). "
        "It reads: Each day a different image or photograph of our universe "
        "is featured, along with a brief explanation written by a "
        "professional astronomer."
      );
      expect(finder, findsOneWidget);
    });
  });
}