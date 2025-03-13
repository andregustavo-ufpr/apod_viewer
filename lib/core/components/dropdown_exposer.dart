import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';

class _DropdownExposerState extends State<DropdownExposer>{
  bool open = false;
  final Duration animationDuration = Duration(
    milliseconds: 200
  );

  @override
  void initState() {
    setState(() => open = widget.startOpened);
    super.initState();
  }

  void _toggleOpen(){
    setState(() => open = !open);
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: _toggleOpen,
      child: Column(
        children: [
          if(!open)
            Row(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: widget.labelSize,
                    color: GRAY,
                    decoration: TextDecoration.underline,
                    decorationThickness: 0.5
                  ),
                ),
                SizedBox(width: 8,),
                AnimatedRotation(
                  duration: animationDuration,
                  turns: open ? -0.25 : 0.25,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: widget.iconSize,
                    color: GRAY,
                  ), 
                )
              ],
            )
          else
            SizedBox(
              height: 12,
            ),
          AnimatedSize(
            duration: animationDuration,
            reverseDuration: animationDuration,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: Container(
              child: open ? 
                Text(
                  widget.collapsableText,
                  style: TextStyle(
                    fontSize: widget.collapsedSize
                  ),
                )
              :
                SizedBox.shrink(),
            ),
          ),
        ]
      ),
    );
  }

}

class DropdownExposer extends StatefulWidget{
  const DropdownExposer({
    required this.collapsableText,
    required this.label,
    this.labelSize = 16,
    this.iconSize = 12,
    this.collapsedSize = 12,
    this.startOpened = false,
    super.key
  });

  final String collapsableText;
  final String label;
  final double labelSize;
  final double iconSize;
  final double collapsedSize;
  final bool startOpened;

  @override
  State<DropdownExposer> createState() => _DropdownExposerState();
}