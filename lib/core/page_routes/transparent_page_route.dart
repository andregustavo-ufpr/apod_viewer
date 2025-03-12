import "package:flutter/material.dart";

class TransparentPageRoute<T> extends PageRoute<T> {
  TransparentPageRoute({this.builder, this.transitionDuration =  const Duration(milliseconds: 0)}) : super();

  final WidgetBuilder? builder;
  @override
  final Duration transitionDuration;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder!(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0, 1);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }
}