import 'package:aku_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:flutter/services.dart';

class BeeInputRow extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  BeeInputRow(
      {Key? key,
      required this.title,
      required this.controller,
      this.formatters,
      required this.hintText})
      : super(key: key);

  @override
  _BeeInputRowState createState() => _BeeInputRowState();
}

class _BeeInputRowState extends State<BeeInputRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.text.size(28.sp).color(ktextPrimary).make(),
          32.w.heightBox,
          TextField(
            inputFormatters: widget.formatters,
            controller: widget.controller,
            textAlign: TextAlign.start,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: widget.hintText ?? '',
              isDense: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 2.w),
              ),
            ),
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
