import 'dart:async';
import 'dart:math';

import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class VoicePlayer extends StatefulWidget {
  final String url;

  const VoicePlayer({Key? key, required this.url}) : super(key: key);

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
  int _voiceLength = 0;

  void stopPlay() {
    inAnimate = false;
    controller.stop();
    player.stop();
    _timer?.cancel();
    _timer = null;
    if (mounted) {
      setState(() {});
    }
  }

  void startPlay() {
    inAnimate = true;
    controller.forward();
    player.play();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _voiceLength--;
      if (_voiceLength <= 0) {
        _voiceLength = (player.duration?.inSeconds) ?? 0;
        _timer?.cancel();
        _timer = null;
        controller.stop();
        inAnimate = false;
      }
      if (mounted) {
        setState(() {});
      }
    });
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
    Future.delayed(Duration(milliseconds: 0), () async {
      await player.setUrl(SARSAPI.image(widget.url));
      var length = await player.load();
      _voiceLength = length?.inSeconds ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
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
        child: Container(
          width: width,
          // height: height,
          padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 20.w),
          decoration: BoxDecoration(
              color: Color(0xFFFFE7BA),
              borderRadius: BorderRadius.circular(8.w)),
          child: Row(
            children: [
              CustomPaint(
                painter: VoicePlayerPainter(inAnimate ? animation.value : 3),
              ),
              40.wb,
              Text('${_voiceLength}\"'),
            ],
          ),
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
