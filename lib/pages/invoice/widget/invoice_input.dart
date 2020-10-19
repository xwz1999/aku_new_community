import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/services.dart';

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
  TextEditingController _userAddressDetail = new TextEditingController();

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
                        Expanded(
                          child: TextFormField(
                            // inputFormatters: item['title'] == '税号'
                            //     ? [
                            //         LengthLimitingTextInputFormatter(11),
                            //       ]
                            //     : [],
                            cursorColor: Color(0xffffc40c),
                            style: TextStyle(fontSize: Screenutil.size(28)),
                            controller: item['controller'],
                            onChanged: (String value) {},
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                top: Screenutil.length(0),
                                bottom: Screenutil.length(0),
                              ),
                              hintText: item['hintText'],
                              border: InputBorder.none, //去掉输入框的下滑线
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: Screenutil.size(24)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screenutil.length(28)),
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
