import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/refund_shop_card.dart';

class EvaluateGoodPage extends StatefulWidget {
  final Bundle bundle;
  EvaluateGoodPage({Key key, this.bundle}) : super(key: key);

  @override
  _EvaluateGoodPageState createState() => _EvaluateGoodPageState();
}

class _EvaluateGoodPageState extends State<EvaluateGoodPage> {
  TextEditingController _evaluateContent = new TextEditingController();
  String hintText = '请您从多个角度评价该商品';
  List<Map<String, dynamic>> _listRadio = [
    {'radioName': '好评', 'isCheck': false},
    {'radioName': '中评', 'isCheck': false},
    {'radioName': '差评', 'isCheck': false}
  ];

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(AntDesign.left, size: Screenutil.size(40)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        '发表评价',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: BaseStyle.fontSize32,
          color: BaseStyle.color333333,
        ),
      ),
    );
  }

  Container _containerContentList(List<Map<String, dynamic>> listContent) {
    return Container(
      child: Column(
        children: listContent
            .map((item) => RefundShopCard(
                  imagePath: item['imagePath'],
                  content: item['content'],
                  specs: item['specs'],
                ))
            .toList(),
      ),
    );
  }

  Container _containerRadio() {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(8),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(32),
      ),
      child: Row(
        children: [
          Text(
            '描述相符',
            style: TextStyle(
                fontSize: BaseStyle.fontSize28, color: BaseStyle.color333333),
          ),
          SizedBox(width: Screenutil.length(34)),
          Row(
            children: _listRadio
                .map((item) => Container(
                      margin: EdgeInsets.only(left: Screenutil.length(44)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _listRadio.forEach((item) {
                              item['isCheck'] = false;
                            });
                            item['isCheck'] = true;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.radio_button_checked,
                              size: BaseStyle.fontSize36,
                              color: item['isCheck']
                                  ? BaseStyle.colorff8500
                                  : BaseStyle.colord8d8d8,
                            ),
                            SizedBox(width: Screenutil.length(16)),
                            Text(
                              item['radioName'],
                              style: TextStyle(
                                fontSize: BaseStyle.fontSize28,
                                color: item['isCheck']
                                    ? BaseStyle.colorff8500
                                    : BaseStyle.colord8d8d8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Container _containerEvaluateTextField() {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(70),
      ),
      padding: EdgeInsets.only(
        top: Screenutil.length(22),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      color: Colors.white,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor: Color(0xffffc40c),
              style: TextStyle(
                fontSize: BaseStyle.fontSize34,
              ),
              controller: _evaluateContent,
              onChanged: (String value) {},
              maxLines: 8,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: Screenutil.length(0),
                  bottom: Screenutil.length(0),
                ),
                hintText: hintText,
                border: InputBorder.none, //去掉输入框的下滑线
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(
                  color: BaseStyle.color999999,
                  fontSize: BaseStyle.fontSize28,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _containerAddImage() {
    return Container(
      padding: EdgeInsets.only(
          left: Screenutil.length(36),
          right: Screenutil.length(36),
          top: Screenutil.length(32),
          bottom: Screenutil.length(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '添加图片信息(0/9)',
            style: TextStyle(
                fontSize: BaseStyle.fontSize28, color: BaseStyle.color333333),
          ),
          SizedBox(height: Screenutil.length(24)),
          InkWell(
            onTap: () {},
            child: Container(
              width: Screenutil.length(218),
              height: Screenutil.length(218),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
                image: DecorationImage(
                    image: AssetImage(AssetsImage.IMAGEADD), fit: BoxFit.fill),
              ),
              // child: ,
            ),
          ),
        ],
      ),
    );
  }

  InkWell _inkWellRelease() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: Screenutil.length(85),
        width: Screenutil.length(686),
        padding: EdgeInsets.symmetric(
          vertical: Screenutil.length(20),
        ),
        decoration: BoxDecoration(
            color: Color(0xffffc40c),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          '发布',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: BaseStyle.color333333),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              _statusHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Screenutil.length(21),
                    left: Screenutil.length(24),
                    right: Screenutil.length(24),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          offset: Offset(1, 1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _containerContentList(
                          widget.bundle.getMap('details')['listContent']),
                      _containerRadio(),
                      _containerEvaluateTextField(),
                      _containerAddImage(),
                    ],
                  ),
                ),
                SizedBox(height: Screenutil.length(26)),
                _inkWellRelease(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
