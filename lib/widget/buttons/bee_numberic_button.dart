import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/painters/as_numberic_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///## 数量选择组件
class BeeNumberPickerButton extends StatefulWidget {
  ///初始值
  final int initValue;

  ///最小值
  ///
  ///包含该值
  ///
  ///default value : `0`
  final int minValue;

  ///最大值
  ///
  ///包含该值
  ///
  ///default value : `9999`
  final int maxValue;

  ///后缀
  final String? suffix;

  ///达到最大值
  final Function(int value)? reachMax;

  ///达到最小值
  final Function(int value)? reachMin;

  ///
  final Function(int value) onChange;

  ///圆形或方形
  final bool circle;

  BeeNumberPickerButton({
    Key? key,
    required this.initValue,
    this.suffix,
    this.minValue = 0,
    this.maxValue = 9999,
    this.reachMax,
    this.reachMin,
    required this.onChange,
  })   : this.circle = false,
        super(key: key);

  BeeNumberPickerButton.circle({
    Key? key,
    required this.initValue,
    this.minValue = 0,
    this.maxValue = 9999,
    this.reachMax,
    this.reachMin,
    this.suffix,
    required this.onChange,
  })   : this.circle = true,
        super(key: key);

  @override
  _ASNumericButtonState createState() => _ASNumericButtonState();
}

class _ASNumericButtonState extends State<BeeNumberPickerButton> {
  FocusNode _focusNode = FocusNode();
  TextEditingController? _controller;
  BorderSide _outline = BorderSide(
    color: Color(0xFFD8D4D4),
    width: 1.w,
  );

  late int _displayValue;

  Widget _buildButton({
    required Widget painter,
    required VoidCallback onPressed,
    // required BorderRadius borderRadius,
  }) {
    return MaterialButton(
      minWidth: 40.w,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: painter,
      splashColor: kPrimaryColor,
      highlightColor: kPrimaryColor.withOpacity(0.3),
      // shape: RoundedRectangleBorder(
      //   borderRadius: borderRadius,
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    _displayValue = widget.initValue;
    _controller = TextEditingController(text: widget.initValue.toString());
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      constraints: BoxConstraints(minWidth: (40 + 40 + 72).w),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD8D4D4),
          width: 1.w,
        ),
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(widget.circle ? 20.w : 0.w),
            left: Radius.circular(widget.circle ? 20.w : 0.w)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            painter: widget.circle
                ? CustomPaint(
                    painter: ASNUmericPainter.minus(),
                  )
                : Icon(CupertinoIcons.minus,
                    size: 20.w, color: Color(0xFFC4C4C4)),
            onPressed: () {
              _focusNode.unfocus();
              if (_displayValue > widget.minValue) {
                _displayValue--;
                widget.onChange(_displayValue);
                _controller!.text = _displayValue.toString();
                setState(() {});
              } else {
                if (widget.reachMin != null) widget.reachMin!(_displayValue);
              }
            },
            // borderRadius: BorderRadius.horizontal(
            //     left: Radius.circular(widget.circle ? 16.w : 0.w)),
          ),
          GestureDetector(
            onTap: () {
              _focusNode.requestFocus();
            },
            child: Container(
              constraints: BoxConstraints(minWidth: 72.w),
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  onChanged: (text) {
                    int? value = int.tryParse(text);
                    _displayValue = value ?? widget.initValue;
                    setState(() {});
                    widget.onChange(_displayValue);
                  },
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: ktextPrimary,
                    fontSize: 20.sp,
                  ),
                  cursorColor: kPrimaryColor,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    isDense: true,
                    hintText: _displayValue.toString(),
                    suffixText: widget.suffix,
                    suffixStyle: TextStyle(
                      color: Colors.black.withOpacity(0.32),
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: _outline,
                  right: _outline,
                ),
                color: Color(0xFFF7F7F7),
              ),
            ),
          ),
          _buildButton(
            painter: widget.circle
                ? CustomPaint(
                    painter: ASNUmericPainter.plus(),
                  )
                : Icon(
                    CupertinoIcons.plus,
                    size: 20.w,
                    color: Color(0xFFC4C4C4),
                  ),
            onPressed: () {
              _focusNode.unfocus();
              if (_displayValue < widget.maxValue) {
                _displayValue++;
                widget.onChange(_displayValue);
                _controller!.text = _displayValue.toString();
                setState(() {});
              } else {
                if (widget.reachMax != null) widget.reachMax!(_displayValue);
              }
            },
            // borderRadius: BorderRadius.horizontal(
            //     right: Radius.circular(widget.circle ? 16.w : 0.w)),
          ),
        ],
      ),
    );
  }
}
