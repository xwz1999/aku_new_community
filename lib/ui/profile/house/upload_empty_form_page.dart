import 'package:flutter/material.dart';

import 'package:aku_community/painters/contact_manager_painter.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class UploadEmptyFormPage extends StatefulWidget {
  UploadEmptyFormPage({Key? key}) : super(key: key);

  @override
  _UploadEmptyFormPageState createState() => _UploadEmptyFormPageState();
}

class _UploadEmptyFormPageState extends State<UploadEmptyFormPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '联系物业',
      body: Center(
        child: Column(
          children: [
            CustomPaint(
              painter: ContactManagerPainter(),
            )
          ],
        ),
      ),
    );
  }
}
