import 'package:flutter/material.dart';

class AnimatedHomeBackground extends StatefulWidget {
  final double height;
  final Color backgroundColor;

  AnimatedHomeBackground(
      {Key? key, required this.height, required this.backgroundColor})
      : super(key: key);

  @override
  AnimatedHomeBackgroundState createState() => AnimatedHomeBackgroundState();
}

class AnimatedHomeBackgroundState extends State<AnimatedHomeBackground> {
  late Color displayColor;

  @override
  void initState() {
    super.initState();
    displayColor = widget.backgroundColor;
  }

  changeColor(Color color) {
    setState(() {
      displayColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(64)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // displayColor,
            // displayColor,
            //Color(0xFFF8F7F8),

            Color(0xFFC5483A),
            Color(0xFFC24739),
          ],
        ),
      ),
    );
  }
}
