import 'dart:math';

import 'package:flutter/material.dart';

class HomePersistentHeaderDelegate extends SliverPersistentHeaderDelegate{
  @override
  final double minExtent;
  @override
  final double maxExtent;

  HomePersistentHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    double screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      height: _shrinkSetter(shrinkOffset, maxExtent, minValue: minExtent),
      width: screenWidth,
      child: Stack( 
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            height: _shrinkSetter(shrinkOffset, maxExtent, minValue: minExtent),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF).withOpacity(0.1),
                  Color(0xFFFFFFFF).withOpacity(0.6),
                ]
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/California_Mendez_960.jpg")
              )
            )
          ),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(220)),
              child: Image(
                fit: BoxFit.cover,
                height: _shrinkSetter(shrinkOffset, 220, minValue: 70),
                width: _shrinkSetter(shrinkOffset, 220, minValue: 70),
                image: AssetImage("assets/NASA_logo.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }


  double _shrinkSetter(double offset, double maxValue, {double? minValue}){
    double newHeight = maxValue -(offset/maxExtent)*maxValue;

    return (minValue !=null && newHeight < minValue) ? minValue : newHeight;
  }

  double _expandSetter(double offset, double minValue, double maxValue){
    double newValue = minValue + (offset/maxExtent)*(maxValue - minValue);
    
    return (newValue > maxValue) ? maxValue : newValue;
  }
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}