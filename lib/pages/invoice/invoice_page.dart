import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/round_check_box.dart';
import 'widget/invoice_input.dart';

class InvoicePage extends StatefulWidget {
  final Bundle bundle;
  InvoicePage({Key key, this.bundle}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _checkDetail = false;
  bool isEnterprise = false;
  List _checkRise = [true, false];

  @override
  void initState() {
    super.initState();
  }

  void checkDetail() {
    setState(() {
      _checkDetail = !_checkDetail;
    });
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      leading: IconButton(
        icon: Icon(AntDesign.left, size: Screenutil.size(40)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        '开具发票',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Screenutil.size(32),
          color: Color(0xff333333),
        ),
      ),
    );
  }

  Container _containerInvoiceDetailCheck() {
    return Container(
      color: Colors.white,
      height: Screenutil.length(96),
      padding: EdgeInsets.symmetric(
        vertical: Screenutil.length(28),
        horizontal: Screenutil.length(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  '发票内容',
                  style: TextStyle(
                    fontSize: Screenutil.size(28),
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(width: Screenutil.length(6)),
                Icon(
                  AntDesign.exclamationcircleo,
                  size: Screenutil.size(20),
                  color: Color(0xff999999),
                ),
              ],
            ),
          ),
          RoundCheckBox(
            value: _checkDetail,
            onChanged: checkDetail,
            title: '明细',
          ),
        ],
      ),
    );
  }

  InkWell _containerSubmit() {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xffffc40c),
        height: Screenutil.length(85),
        margin: EdgeInsets.symmetric(
          horizontal: Screenutil.length(43),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Screenutil.length(20),
        ),
        alignment: Alignment.center,
        child: Text(
          '确认',
          style: TextStyle(
            fontSize: Screenutil.size(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _listHeader = [
      {
        'title': '发票类型',
        'rightWidget': Container(
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  '增值税电子普票',
                  style: TextStyle(
                    fontSize: Screenutil.size(28),
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(width: Screenutil.length(12)),
                Icon(
                  AntDesign.right,
                  size: Screenutil.size(20),
                  color: Color(0xff333333),
                ),
              ],
            ),
          ),
        )
      },
      {
        'title': '抬头类型',
        'rightWidget': Container(
          child: Row(
            children: [
              RoundCheckBox(
                value: _checkRise[0],
                onChanged: () {
                  setState(() {
                    if (!_checkRise[0]) {
                      isEnterprise = false;
                      _checkRise = [true, false];
                    }
                    return;
                  });
                },
                title: '个人/事业单位',
              ),
              SizedBox(width: Screenutil.length(12)),
              RoundCheckBox(
                value: _checkRise[1],
                onChanged: () {
                  setState(() {
                    if (!_checkRise[1]) {
                      isEnterprise = true;
                      _checkRise = [false, true];
                    }
                    return;
                  });
                },
                title: '企业',
              ),
            ],
          ),
        )
      },
    ];

    Container _containerHeader() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 0.5, //宽度
              color: Color(0xffd8d8d8), //边框颜色
            ),
          ),
        ),
        child: Column(
          children: _listHeader
              .map((item) => Container(
                    padding: EdgeInsets.only(
                      left: Screenutil.length(77),
                      right: Screenutil.length(32),
                      top: Screenutil.length(28),
                      // bottom: Screenutil.length(28),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff333333),
                              ),
                            ),
                            item['rightWidget']
                          ],
                        ),
                        SizedBox(height: Screenutil.length(28)),
                        Divider(height: 1),
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          height: Screenutil.length(1334),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                _containerHeader(),
                Form(
                  key: _formKey,
                  autovalidate: true,
                  child: Column(
                    children: [InvoiceInput(isEnterprise: isEnterprise)],
                  ),
                ),
                SizedBox(height: Screenutil.length(66)),
                _containerInvoiceDetailCheck(),
                SizedBox(height: Screenutil.length(92)),
                _containerSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
