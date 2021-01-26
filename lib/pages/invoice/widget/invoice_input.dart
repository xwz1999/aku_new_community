// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';

class InvoiceInput extends StatefulWidget {
  final bool isEnterprise;
  InvoiceInput({Key key, this.isEnterprise}) : super(key: key);

  @override
  _InvoiceInputState createState() => _InvoiceInputState();
}

class _InvoiceInputState extends State<InvoiceInput> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userPhone = new TextEditingController();
  TextEditingController _userAddress = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _listTextField = [
      {'title': '发票抬头', 'hintText': '请输入', 'controller': _userName},
      {'title': '税号', 'hintText': '请输入', 'controller': _userPhone},
      {'title': '开户银行', 'hintText': '选填', 'controller': _userAddress},
      {'title': '银行账号', 'hintText': '选填', 'controller': _userAddress},
      {'title': '企业地址', 'hintText': '选填', 'controller': _userAddress},
      {'title': '企业电话', 'hintText': '选填', 'controller': _userAddress},
    ];
    List<Widget> _listTextFieldView(List listInput) {
      return listInput
          .map((item) => Container(
                padding: EdgeInsets.only(
                  left: 77.w,
                  right: 32.w,
                  top: 28.w,
                  // bottom: 28.w,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Color(0xff333333),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // inputFormatters: item['title'] == '税号'
                            //     ? [
                            //         LengthLimitingTextInputFormatter(11),
                            //       ]
                            //     : [],
                            cursorColor: Color(0xffffc40c),
                            style: TextStyle(fontSize: 28.sp),
                            controller: item['controller'],
                            onChanged: (String value) {},
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                top: 0.w,
                                bottom: 0.w,
                              ),
                              hintText: item['hintText'],
                              border: InputBorder.none, //去掉输入框的下滑线
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.w),
                    Divider(height: 1),
                  ],
                ),
              ))
          .toList();
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: widget.isEnterprise
            ? _listTextFieldView(_listTextField)
            : _listTextFieldView([_listTextField.first]),
      ),
    );
  }
}
