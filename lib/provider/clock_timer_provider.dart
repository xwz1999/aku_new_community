import 'dart:async';

import 'package:flutter/material.dart';

class ClockTimerProvider extends ChangeNotifier {
  ///登录页验证码计时器
  int second = 60;
  bool timerStart = false;
  Timer? timer;

  void startTimer() {
    timerStart = true;
    if (timer != null) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (second > 0) {
        second--;
        notifyListeners();
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    second = 60;
    timerStart = false;
    timer?.cancel();
    timer = null;
    notifyListeners();
  }
}
