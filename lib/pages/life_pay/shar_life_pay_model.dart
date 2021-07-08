
import 'package:aku_community/models/life_pay/life_pay_list_model.dart';
import 'package:flutter/material.dart';

class SharLifPayModel extends InheritedWidget {
  SharLifPayModel({Key? key, required this.child, required this.models})
      : super(key: key, child: child);

  final Widget child;
   List<LifePayListModel> models;

  static SharLifPayModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharLifPayModel>();
  }

  @override
  bool updateShouldNotify(SharLifPayModel oldWidget) {
    return oldWidget.models != models;
  }
  
}
