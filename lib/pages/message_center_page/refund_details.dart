import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';

class RefundDetails extends StatelessWidget {
  final double? statusHeight;

  const RefundDetails({Key? key, this.statusHeight}) : super(key: key);

  Container _containerHeader() {
    return Container(
      width: double.infinity,
      color: Color(0xffffd000),
      padding: EdgeInsets.only(
        top: 44.w,
        bottom: 44.w,
        left: 33.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '退款成功',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: ktextPrimary,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            '2020年7月8日 13:28',
            style: TextStyle(
              fontSize: BaseStyle.fontSize24,
              color: ktextPrimary,
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
        top: 24.w,
        bottom: 24.w,
        left: 33.w,
        right: 32.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '退款总金额',
            style: TextStyle(
              fontSize: BaseStyle.fontSize24,
              color: ktextPrimary,
            ),
          ),
          Text(
            '¥1123.60',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize28,
              color: ktextPrimary,
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
              top: 25.w,
              bottom: 22.w,
              left: 33.w,
            ),
            child: Text(
              '退款信息',
              style: TextStyle(
                fontSize: BaseStyle.fontSize24,
                color: ktextPrimary,
              ),
            ),
          ),
          Container(
            color: Color(0xfff2f2f2),
            padding: EdgeInsets.only(
              top: 30.w,
              bottom: 24.w,
              left: 33.w,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/example/tz1.png',
                  height: 120.w,
                  width: 120.w,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 544.w,
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
                    SizedBox(height: 10.w),
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
              top: 22.w,
              left: 33.w,
              bottom: 22.w,
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
                SizedBox(height: 22.w),
                Text(
                  '退款金额：${'¥1123.60'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
                SizedBox(height: 22.w),
                Text(
                  '申请时间：${'2020-7-7 21:09'}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize24,
                    color: BaseStyle.color999999,
                  ),
                ),
                SizedBox(height: 22.w),
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
            MediaQuery.of(context).size.height - kToolbarHeight - statusHeight!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _containerHeader(),
            _containerPrice(),
            SizedBox(height: 44.w),
            _containerContent(),
          ],
        ),
      ),
    );
  }
}
