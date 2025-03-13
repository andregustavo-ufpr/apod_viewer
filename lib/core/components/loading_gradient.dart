import "package:flutter/material.dart";
import "package:nasa_apod_viewer/core/data/local/colors.dart";

class LoadingGradient extends StatefulWidget{
  const LoadingGradient({
    this.borderRadius = 12,
    this.gradientColors = const [
      WHITE,
      Color(0xFFe0e0e0),
      Color(0xFFf5f5f5),
      WHITE
    ],
    this.height,
    this.width,
    super.key,
  });

  final List<Color> gradientColors;
  final double?
    borderRadius,
    height,
    width;

  @override
  State<LoadingGradient> createState() => _LoadingGradientState();
}

class _LoadingGradientState extends State<LoadingGradient> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _leftAlignmentAnimation;
  late Animation<Alignment> _rightAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _leftAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(begin: const Alignment(-2, 0), end: const Alignment(-0.5, 0)),
          weight: 1
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(begin: const Alignment(-0.5, 0), end: const Alignment(0.8, 0)),
          weight: 1
        )
      ]
    ).animate(_controller);

    _rightAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween<Alignment>(begin: const Alignment(-1, 0), end: const Alignment(0.7,0)),
          weight: 1
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(begin: const Alignment(0.7,0), end: const Alignment(2.2,0)),
          weight: 1
        )
      ]
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              gradient: LinearGradient(
                colors: widget.gradientColors,
                begin: _leftAlignmentAnimation.value,
                end: _rightAlignmentAnimation.value
              ),
            ),
          );
        },
      ),
    );
  }
}