import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              signatureController: _signatureController,
            ),
          );
        },
      ),
    );
  }

  final SignatureController signatureController;

  SignNameBoard({Key? key, required this.signatureController})
      : super(key: key);

  @override
  _SignNameBoardState createState() => _SignNameBoardState();
}

class _SignNameBoardState extends State<SignNameBoard> {
  @override
  void dispose() {
    widget.signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Signature signature = Signature(
      backgroundColor: Colors.white,
      controller: widget.signatureController,
      width: double.infinity,
      height: 1000.w,
    );
    IconButton finishButton = IconButton(
      onPressed: () {
        Get.back(result: widget.signatureController.toPngBytes());
      },
      icon: Icon(
        CupertinoIcons.checkmark_alt_circle,
        size: 100.w,
      ),
    );
    IconButton clearButton = IconButton(
      onPressed: () {
        widget.signatureController.clear();
        setState(() {});
      },
      icon: Icon(
        CupertinoIcons.clear_circled,
        size: 100.w,
      ),
    );
    return Center(
      child: Column(
        children: [
          signature,
          200.w.heightBox,
          Material(
            child: Row(
              children: [
                finishButton.expand(),
                clearButton.expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
