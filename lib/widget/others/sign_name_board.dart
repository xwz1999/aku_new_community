import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SignNameBoard extends StatefulWidget {
  static Future defalutBoard() async {
    SignatureController _signatureController = SignatureController(
      penColor: Colors.black,
      penStrokeWidth: 5.w,
      exportBackgroundColor: Colors.transparent,
    );
    return await navigator!.push(
      PageRouteBuilder(
        fullscreenDialog: true,
        opaque: false,
        pageBuilder: (context, animation, sAnimation) {
          return FadeTransition(
            opacity: animation,
            child: SignNameBoard(
              width: 600.w,
              height: double.infinity,
              signatureController: _signatureController,
            ),
          );
        },
      ),
    );
  }

  final SignatureController signatureController;
  final bool forceToHorizontal;
  final double width;
  final double height;
  SignNameBoard(
      {Key? key,
      required this.signatureController,
      this.forceToHorizontal = true,
      required this.width, required this.height})
      : super(key: key);

  @override
  _SignNameBoardState createState() => _SignNameBoardState();
}

class _SignNameBoardState extends State<SignNameBoard> {
  @override
  void initState() {
    super.initState();
    if (widget.forceToHorizontal) {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  void dispose() {
    widget.signatureController.dispose();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Signature signature = Signature(
      backgroundColor: Colors.white,
      controller: widget.signatureController,
      width: widget.width,
      height:widget.height,
    );
    IconButton finishButton = IconButton(
      iconSize: 50.w,
      onPressed: () {
        Get.back(result: widget.signatureController.toPngBytes());
      },
      icon: Icon(
        CupertinoIcons.checkmark_alt_circle,
        color: Colors.blue,
        // size: 100.w,
      ),
    );
    IconButton clearButton = IconButton(
      iconSize: 50.w,
      onPressed: () {
        widget.signatureController.clear();
        setState(() {});
      },
      icon: Icon(
        CupertinoIcons.clear_circled,
        color: Colors.red,
        // size: 100.w,
      ),
    );
    return Scaffold(
      body: widget.forceToHorizontal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                signature,
                Material(
                  child: Column(
                    children: [
                      finishButton.expand(),
                      clearButton.expand(),
                    ],
                  ),
                ).expand()
              ],
            )
          : Column(
              children: [
                signature,
                Material(
                  child: Row(
                    children: [
                      finishButton.expand(),
                      clearButton.expand(),
                    ],
                  ),
                ).expand(),
              ],
            ),
    );
  }
}
