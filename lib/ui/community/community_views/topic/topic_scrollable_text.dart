import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';

class TopicScrollableText extends StatefulWidget {
  final String title;
  TopicScrollableText({Key key, @required this.title}) : super(key: key);

  @override
  _TopicScrollableTextState createState() => _TopicScrollableTextState();
}

class _TopicScrollableTextState extends State<TopicScrollableText> {
  ScrollPosition _scrollPosition;

  _positionListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_positionListener);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollPosition = Scrollable.of(context)?.position;
    _scrollPosition?.addListener(_positionListener);
  }

  double get offset {
    if (_scrollPosition.pixels >= 500.w) return 1;
    if (_scrollPosition.pixels < 500.w && _scrollPosition.pixels >= 0) {
      return _scrollPosition.pixels / 500.w;
    } else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 202.w - offset * 160.w),
      child: Text(widget.title),
    );
  }
}
