import 'package:akuCommunity/widget/bee_back_button.dart';
import 'package:flutter/material.dart';

class BeeScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  BeeScaffold({Key key, @required this.title, this.body}) : super(key: key);

  @override
  _BeeScaffoldState createState() => _BeeScaffoldState();
}

class _BeeScaffoldState extends State<BeeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        leading: BeeBackButton(),
      ),
      body: widget.body,
    );
  }
}
