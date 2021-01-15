import 'package:akuCommunity/utils/logger_card.dart';
import 'package:akuCommunity/utils/logger_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoggerFAB extends StatefulWidget {
  static openLogger(BuildContext context) {
    Overlay.of(context).insert(OverlayEntry(
      builder: (context) {
        return LoggerFAB();
      },
    ));
  }

  LoggerFAB({Key key}) : super(key: key);

  @override
  _LoggerFABState createState() => _LoggerFABState();
}

class _LoggerFABState extends State<LoggerFAB> {
  double _x = 100;
  double _y = 100;

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  bool _moving = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: _moving ? Duration.zero : Duration(milliseconds: 300),
          left: _x - 25,
          top: _y - 25,
          child: GestureDetector(
            onPanStart: (detail) {
              _moving = true;
            },
            onPanUpdate: (details) {
              setState(() {
                _x = details.globalPosition.dx;
                _y = details.globalPosition.dy;
              });
            },
            onPanEnd: (detail) {
              if (_x < 100) _x = 50;
              if (_y < 100) _y = 75;
              if (_x > screenWidth - 50) _x = screenWidth - 50;
              if (_y > screenHeight - 50) _y = screenHeight - 50;
              _moving = false;
              setState(() {});
            },
            onTap: () {
              Get.to(LoggerView());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 50,
              width: 50,
              child: Icon(Icons.code),
            ),
          ),
        )
      ],
    );
  }
}

class LoggerView extends StatefulWidget {
  LoggerView({Key key}) : super(key: key);
  init() {}

  @override
  _LoggerViewState createState() => _LoggerViewState();
}

class _LoggerViewState extends State<LoggerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            LoggerCard(data: LoggerData.data[index]),
        itemCount: LoggerData.data.length,
      ),
    );
  }
}