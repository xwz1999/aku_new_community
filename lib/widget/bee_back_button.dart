// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

class BeeBackButton extends StatelessWidget {
  final Color color;
  const BeeBackButton({Key key, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context)
        ? IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: color,
            ),
          )
        : SizedBox();
  }
}
