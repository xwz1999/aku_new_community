import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';

class RefundDetails extends StatelessWidget {
  final double statusHeight;
  const RefundDetails({Key key, this.statusHeight}) : super(key: key);

  Container _containerHeader() {
    return Container(
      width: double.infinity,
      color: Color(0xffffd000),
      padding: EdgeInsets.only(
        top: Screenutil.length(44),
        bottom: Screenutil.length(44),
        left: Screenutil.length(33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '退款成功',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: BaseStyle.color333333,
            ),
          ),
          SizedBox(height: Screenutil.length(10)),
          Text(
            '2020年7月8日 13:28',
            style: TextStyle(
              fontSize: BaseStyle.fontSize24,
              color: BaseStyle.color333333,
            ),
          ),
        ],
      ),
    );
  }

  Container _containerPrice() {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.only(
        top: Screenutil.length(24),
        bottom: Screenutil.length(24),
        left: Screenutil.length(33),
        right: Screenutil.length(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '退款总金额',
            style: TextStyle(
              fontSize: BaseStyle.fontSize24,
              color: BaseStyle.color333333,
            ),
          ),
          Text(
            '¥1123.60',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color333333,
            ),
          ),
        ],
      ),
    );
  }

  Container _containerContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xffffffff),
            width: double.infinity,
            padding: EdgeInsets.only(
              top: Screenutil.length(25),
              bottom: Screenutil.length(22),
              left: Screenutil.length(33),
            ),
            child: Text(
              '退款信息',
              style: TextStyle(
                fontSize: BaseStyle.fontSize24,
                color: BaseStyle.color333333,
              ),
            ),
          ),
          Container(
            color: Color(0xfff2f2f2),
            padding: EdgeInsets.only(
              top: Screenutil.length(30),
              bottom: Screenutil.length(24),
              left: Screenutil.length(33),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/example/tz1.png',
                  height: Screenutil.length(120),
                  width: Screenutil.length(120),
                  fit: BoxFit.fill,
                ),
                SizedBox(width: Screenutil.length(20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Screenutil.length(544),
                      child: Text(
                        '轻便自由 男士针织休闲西装 全身羊毛修身意大利进口精致裁剪',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize24,
                          color: BaseStyle.color999999,
                        ),
                      ),
                    ),
                    SizedBox(height: Screenutil.length(10)),
                    Text(
                      '规格分类：M 黑色',
                      style: TextStyle(
                        fontSize: BaseStyle.fontSize24,
                        color: BaseStyle.color999999,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: double.infinity,
            padding: EdgeInsets.only(
              top: Screenutil.length(22),
              left: Screenutil.length(33),
              bottom: Screenutil.length(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '退款原因：${'拍多/拍错/不想要'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
                SizedBox(height: Screenutil.length(22)),
                Text(
                  '退款金额：${'¥1123.60'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
                SizedBox(height: Screenutil.length(22)),
                Text(
                  '申请时间：${'2020-7-7 21:09'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
                SizedBox(height: Screenutil.length(22)),
                Text(
                  '退款编号：${'8324982349230293'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height:
            MediaQuery.of(context).size.height - kToolbarHeight - statusHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _containerHeader(),
            _containerPrice(),
            SizedBox(height: Screenutil.length(44)),
            _containerContent(),
          ],
        ),
      ),
    );
  }
}
