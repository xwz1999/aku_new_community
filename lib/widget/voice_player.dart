import 'dart:async';
import 'dart:math';

import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class VoicePlayer extends StatefulWidget {
  final String url;
  final VoidCallback? onDelete;
  final bool showXmark;

  const VoicePlayer(
      {Key? key, required this.url, this.onDelete, this.showXmark = false})
      : super(key: key);

  @override
  _VoicePlayerState createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer>
    with SingleTickerProviderStateMixin {
  final double width = 150.w;
  final double height = 45.w;
  late Animation<int> animation;
  late AnimationController controller;
  late Tween<int> _rotation;
  bool inAnimate = false;
  final player = AudioPlayer();
  Timer? _timer;
  Duration? _voiceLength;
  int _currentLength = 0;

  void stopPlay() {
    inAnimate = false;
    controller.stop();
    player.pause();
    _timer?.cancel();
    _timer = null;
    if (mounted) {
      setState(() {});
    }
  }

  void startPlay() async {
    inAnimate = true;
    controller.forward();
    player.play();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _currentLength--;
      if (_currentLength <= 0) {
        resetPlay();
      } else {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Future initVoice() async {
    await player.setUrl(SARSAPI.image(widget.url));
    _voiceLength = await player.load();
    _currentLength = _voiceLength?.inSeconds ?? 0;
    await player.setClip(start: Duration(seconds: 0), end: _voiceLength);
    if (mounted) {
      setState(() {});
    }
  }

  Future resetPlay() async {
    _timer?.cancel();
    _timer = null;
    controller.stop();
    inAnimate = false;
    player.stop();
    _currentLength = _voiceLength?.inSeconds ?? 0;
    await player.setClip(start: Duration(seconds: 0), end: _voiceLength);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _rotation = IntTween(begin: 1, end: 3);
    animation = _rotation
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate))
      ..addListener(() {
        // _current = animation.value;
        if (mounted) {
          setState(() {});
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    initVoice();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VoicePlayer oldWidget) {
    resetPlay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    stopPlay();
    player.dispose();
    controller.dispose();
    animation.removeListener(() {});
    animation.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (player.playing) {
          stopPlay();
        } else {
          startPlay();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width,
              // height: height,
              padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Color(0xFFFFE7BA),
                  borderRadius: BorderRadius.circular(8.w)),
              child: Row(
                children: [
                  CustomPaint(
                    painter:
                        VoicePlayerPainter(inAnimate ? animation.value : 3),
                  ),
                  40.wb,
                  Text('${_currentLength}\"'),
                ],
              ),
            ),
            if (widget.showXmark)
              Positioned(
                  top: -10.w,
                  right: -10.w,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      size: 30.w,
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}

class VoicePlayerPainter extends CustomPainter {
  final int tween;

  VoicePlayerPainter(this.tween);

  @override
  void paint(Canvas canvas, Size size) {
    var startAngel = -pi / 4;
    var sweepAngel = pi / 2;
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, size.height / 2), radius: 5),
        startAngel,
        sweepAngel,
        true,
        paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    if (tween >= 2) {
      canvas.drawArc(
          Rect.fromCircle(center: Offset(0, size.height / 2), radius: 8),
          startAngel,
          sweepAngel,
          false,
          paint);
    }
    if (tween >= 3) {
      canvas.drawArc(
          Rect.fromCircle(center: Offset(0, size.height / 2), radius: 12),
          startAngel,
          sweepAngel,
          false,
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
