// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

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
                width: 328.w,
                height: 180.w,
              ),
            ),
            SizedBox(height: 16.w),
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
