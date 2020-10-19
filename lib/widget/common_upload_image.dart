import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';

class CommonUploadImage extends StatefulWidget {
  final String imagePath, title;
  CommonUploadImage({Key key, this.imagePath, this.title}) : super(key: key);

  @override
  _CommonUploadImageState createState() => _CommonUploadImageState();
}

class _CommonUploadImageState extends State<CommonUploadImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.asset(
                widget.imagePath,
                width: Screenutil.length(328),
                height: Screenutil.length(180),
              ),
            ),
            SizedBox(height: Screenutil.length(16)),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: BaseStyle.fontSize24, color: BaseStyle.color999999),
            ),
          ],
        ),
      ),
    );
  }
}
