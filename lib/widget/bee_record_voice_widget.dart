import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/widget/bee_divider.dart';

class BeeRecordVoiceWidget extends StatefulWidget {
  const BeeRecordVoiceWidget({Key? key}) : super(key: key);

  @override
  _BeeRecordVoiceWidgetState createState() => _BeeRecordVoiceWidgetState();
}

class _BeeRecordVoiceWidgetState extends State<BeeRecordVoiceWidget> {
  bool _inRecordVoice = false;
  var myRecorder = FlutterSoundRecorder();
  var myPlayer = FlutterSoundPlayer();
  String? filePath;
  String fileName = 'record.aac';

  bool get reclaim => !_inRecordVoice && filePath != null;

  bool get play => !_inRecordVoice && filePath != null;

  Timer? _timer;
  int _recordSeconds = 0;
  int _maxSeconds = 0;

  String get _recordTime {
    var min = (_recordSeconds ~/ 60).toString();
    if (min.length < 2) {
      min = '0$min';
    }
    var sec = (_recordSeconds % 60).toString();
    if (sec.length < 2) {
      sec = '0$sec';
    }
    return '$min:$sec';
  }

  @override
  void initState() {
    myRecorder.openRecorder();
    myPlayer.openPlayer();
    Future.delayed(Duration(seconds: 0), () async {
      var permission = await Permission.microphone.isGranted;
      print(permission);
      if (!permission) {
        await Permission.microphone.request();
      }
    });
    super.initState();
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void startRecord() {
    cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordSeconds++;
      setState(() {});
    });
  }

  void startPlay() {
    cancelTimer();
    _maxSeconds = _recordSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_recordSeconds == 0) {
        cancelTimer();
        _recordSeconds = _maxSeconds;
        setState(() {});
      } else {
        _recordSeconds--;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    myRecorder.closeRecorder();
    myPlayer.closePlayer();
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 335.w,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kPrimaryColor, width: 5.w)),
          color: Colors.white),
      child: Column(
        children: [
          20.hb,
          '开始录音'
              .text
              .size(24.sp)
              .isIntrinsic
              .color(Colors.black.withOpacity(0.85))
              .make(),
          20.hb,
          _recordTime.text
              .size(24.sp)
              .isIntrinsic
              .bold
              .color(Colors.black.withOpacity(0.85))
              .make(),
          24.hb,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              '重录'
                  .text
                  .size(24.sp)
                  .isIntrinsic
                  .color(
                      reclaim ? kPrimaryColor : Colors.black.withOpacity(0.45))
                  .make(),
              12.wb,
              GestureDetector(
                onTap: reclaim
                    ? () async {
                        myRecorder.deleteRecord(fileName: fileName);
                        filePath = null;
                        _recordSeconds = 0;
                        setState(() {});
                      }
                    : null,
                child: Icon(
                  CupertinoIcons.mic_circle,
                  size: 60.w,
                  color:
                      reclaim ? kPrimaryColor : Colors.black.withOpacity(0.45),
                ),
              ),
              40.wb,
              GestureDetector(
                onTap: () async {
                  if (myRecorder.isRecording) {
                    filePath = await myRecorder.stopRecorder();
                    cancelTimer();
                  } else {
                    if (filePath != null) {
                      myRecorder.deleteRecord(fileName: fileName);
                    }
                    await myRecorder.startRecorder(toFile: fileName);
                    startRecord();
                  }
                  _inRecordVoice = !_inRecordVoice;
                  setState(() {});
                },
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.w),
                      border: Border.all(color: kPrimaryColor)),
                  child: AnimatedContainer(
                    width: _inRecordVoice ? 40.w : 80.w,
                    height: _inRecordVoice ? 40.w : 80.w,
                    decoration: BoxDecoration(
                      borderRadius: _inRecordVoice
                          ? BorderRadius.zero
                          : BorderRadius.circular(40.w),
                      color: _inRecordVoice
                          ? kPrimaryColor
                          : kPrimaryColor.withOpacity(0.25),
                    ),
                    duration: Duration(milliseconds: 400),
                  ),
                ),
              ),
              40.wb,
              GestureDetector(
                onTap: play
                    ? () async {
                        if (myPlayer.isPlaying) {
                          myPlayer.stopPlayer();
                          cancelTimer();
                          _recordSeconds = _maxSeconds;
                          setState(() {});
                        } else {
                          await myPlayer.startPlayer(fromURI: filePath);
                          startPlay();
                        }
                      }
                    : null,
                child: Icon(
                  CupertinoIcons.play_circle,
                  size: 60.w,
                  color: play ? kPrimaryColor : Colors.black.withOpacity(0.45),
                ),
              ),
              12.wb,
              '试听'
                  .text
                  .size(24.sp)
                  .color(play ? kPrimaryColor : Colors.black.withOpacity(0.45))
                  .isIntrinsic
                  .make()
            ],
          ),
          24.hb,
          BeeDivider.horizontal(),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 80.w,
                      alignment: Alignment.center,
                      child: '取消'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.85))
                          .isIntrinsic
                          .make(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 80.w,
                width: 1.w,
                color: Color(0xFFE8E8E8),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back(result: filePath);
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 80.w,
                      alignment: Alignment.center,
                      child: '确定'
                          .text
                          .size(28.sp)
                          .color(kPrimaryColor)
                          .isIntrinsic
                          .make(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
