// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'num_ext.dart';

extension WidgetListExt on List<Widget> {
  List<Widget> sepWidget({Widget separate}) {
    if (this.isEmpty) return [];
    return List.generate(this.length * 2 - 1, (index) {
      if (index.isEven)
        return this[index ~/ 2];
      else
        return separate ?? 10.wb;
    });
  }
}
