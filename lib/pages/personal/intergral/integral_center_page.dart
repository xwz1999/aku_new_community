import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/personal/intergral/progress_paint.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class integralCenterPage extends StatefulWidget {
  const integralCenterPage({Key? key}) : super(key: key);

  @override
  _integralCenterPageState createState() => _integralCenterPageState();
}

class _integralCenterPageState extends State<integralCenterPage> {
  double _proportion = 0.3;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5000), () async {
      _proportion = 0.5;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gridview = Container(
      // height: 400.w,
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 48.w),
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        children: [
          gridCard(Assets.icons.identify.path, '身份标识', () {}),
          gridCard(Assets.icons.identify.path, '积分加速', () {}),
          gridCard(Assets.icons.identify.path, '支付优惠', () {}),
          gridCard(Assets.icons.identify.path, '生日祝福', () {}),
          gridCard(Assets.icons.identify.path, '会员活动', () {}),
          gridCard(Assets.icons.identify.path, '炫彩用户名', () {}),
        ],
      ),
    );
    var top = Positioned(
        top: 198.w,
        child: Column(
          children: [
            Assets.icons.vip1.image(width: 178.w, height: 220.w),
            32.w.heightBox,
            '一级会员'.text.size(32.sp).color(Color(0xFFFFD89F)).bold.make(),
          ],
        ));
    var back = ClipPath(
      clipper: _IntegralBackgroundClip(),
      child: Container(
        color: Color(0xFF303843),
        width: double.infinity,
        height: 850.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 48.w),
              child: Row(
                children: [
                  '等级特权专属'.text.size(32.sp).white.bold.make(),
                  24.w.widthBox,
                  '更多特权还在路上～'
                      .text
                      .size(22.sp)
                      .color(Colors.white.withOpacity(0.45))
                      .make(),
                ],
              ),
            ),
            gridview,
          ],
        ),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: RichText(
            text: TextSpan(children: [
          WidgetSpan(
            child: Assets.icons.vipFont.image(height: 32.w),
          ),
          TextSpan(
              text: ' 积分中心',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 36.w,
                  fontWeight: FontWeight.bold))
        ])),
        centerTitle: true,
        leading: BeeBackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.question_circle,
                size: 32.sp,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(Assets.static.integralBackground.path))),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            back,
            top,
            Positioned(
                top: 547.w,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.w),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: 686.w,
                    height: 343.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.w),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xD9FBB246),
                              Color(0xE6FF7145),
                            ])),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 32.w, top: 32.w, right: 32.w),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  '活跃度'.text.size(28.sp).white.make(),
                                  24.w.heightBox,
                                  '2501'.text.size(56.sp).white.make(),
                                ],
                              ),
                              48.w.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  '积分'.text.size(28.sp).white.make(),
                                  24.w.heightBox,
                                  '123'.text.size(56.sp).white.make(),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  '积分获取比例'.text.size(28.sp).white.make(),
                                  24.w.heightBox,
                                  '5%'.text.size(56.sp).white.make(),
                                ],
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: double.infinity,
                          height: 110.w,
                          alignment: Alignment.center,
                          child: ProgressPaint(
                            activity: 300,
                            lowLevel: 1,
                            proportion: _proportion,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget gridCard(String path, String title, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            path,
            width: 106.w,
            height: 106.w,
          ),
          16.w.heightBox,
          title.text
              .minFontSize(4)
              .maxFontSize(28)
              .maxLines(1)
              .stepGranularity(2)
              .white
              .make()
        ],
      ),
    );
  }
}

class _IntegralBackgroundClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var offset = 25.0;
    var path = Path();
    path.moveTo(0, offset);
    path.quadraticBezierTo(size.width / 2, 0, size.width, offset);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, offset);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
