import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO Please remove those sh*t code.
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;
  bool expand;

  ExpandableText({Key key, this.text, this.maxLines, this.style, this.expand})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  void initState() {
    super.initState();
    if (widget.expand == null) {
      setState(() {
        widget.expand = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, size) {
          final span = TextSpan(text: widget.text ?? '', style: widget.style);
          final tp = TextPainter(
            text: span,
            maxLines: widget.maxLines,
            textDirection: TextDirection.ltr,
          );
          tp.layout(maxWidth: size.maxWidth);
          if (tp.didExceedMaxLines) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.expand
                    ? Text(
                        widget.text ?? '',
                        style: widget.style,
                      )
                    : Text(
                        widget.text ?? '',
                        maxLines: widget.maxLines,
                        overflow: TextOverflow.ellipsis,
                        style: widget.style,
                      ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      widget.expand = !widget.expand;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      widget.expand ? '收起' : '全文',
                      style: TextStyle(
                          fontSize: widget.style != null
                              ? widget.style.fontSize
                              : null,
                          color: Color(0xffffc40c)),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text(widget.text ?? '', style: widget.style);
          }
        },
      ),
    );
  }
}
