import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';

void snackbar({
  required BuildContext context,
  Color backgroundColor = GRAY,
  List<Widget> children = const [],
  Duration duration = const Duration(seconds: 3)
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      content: Row(
        children: children,
      )
    )
  );

}