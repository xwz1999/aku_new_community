import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final String name;
  final String title;
  ChatCard({Key key, this.name, this.title}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
