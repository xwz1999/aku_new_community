import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class BeeRecordVoiceWidget extends StatefulWidget {
  const BeeRecordVoiceWidget({Key? key}) : super(key: key);

  @override
  _BeeRecordVoiceWidgetState createState() => _BeeRecordVoiceWidgetState();
}

class _BeeRecordVoiceWidgetState extends State<BeeRecordVoiceWidget> {
  bool _inRecordVoice = false;
  var myPlayer = FlutterSoundRecorder();

  @override
  void initState() {
    myPlayer.openRecorder();
    super.initState();
  }

  @override
  void dispose() {
    myPlayer.closeRecorder();
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
          '00:00'
              .text
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
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              12.wb,
              Icon(
                CupertinoIcons.mic_circle,
                size: 60.w,
                color: Colors.black.withOpacity(0.45),
              ),
              40.wb,
              GestureDetector(
                onTap: () async {
                  var permission = await Permission.microphone.isGranted;
                  if (!permission) {
                    await Permission.microphone.request();
                  }
                  if (myPlayer.isRecording) {
                    await myPlayer.pauseRecorder();
                  } else if (myPlayer.isPaused) {
                    await myPlayer.resumeRecorder();
                  } else {
                    await myPlayer.startRecorder();
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
              Icon(
                CupertinoIcons.play_circle,
                size: 60.w,
                color: Colors.black.withOpacity(0.45),
              ),
              12.wb,
              '试听'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
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
              Container(
                height: 80.w,
                width: 1.w,
                color: Color(0xFFE8E8E8),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
