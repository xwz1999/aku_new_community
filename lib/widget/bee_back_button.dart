import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeeBackButton extends StatelessWidget {
  const BeeBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context)
        ? IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.chevron_back,
            ),
          )
        : SizedBox();
  }
}
