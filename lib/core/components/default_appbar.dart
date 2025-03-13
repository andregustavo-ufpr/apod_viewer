import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget{
  const DefaultAppbar({
    required this.onLeading,
    required this.title,
    this.actions,
    this.showLeading = false,
    super.key
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);
  
  @override
  final Size preferredSize;

  final Function? onLeading;
  final String title;
  final List<Widget>? actions;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: WHITE.withOpacity(0.6),
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      automaticallyImplyLeading: showLeading,
      leadingWidth: showLeading ? 44 : 0,
      centerTitle: showLeading,
      leading: showLeading ? 
        IconButton(
          onPressed: (){
            Navigator.of(context).pop();
            if(onLeading != null) onLeading!();
          }, 
          icon: Icon(
            Icons.west_rounded,
            color: BLACK,
          )
        )
      : null,
      titleSpacing: 16,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}