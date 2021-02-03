// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t grid_buttons need to be cleaned.")
class GridButtons extends StatefulWidget {
  final List<GridButton> gridList;
  final int crossCount;
  GridButtons({Key key, this.crossCount, this.gridList}) : super(key: key);

  @override
  _GridButtonsState createState() => _GridButtonsState();
}

class GridButton {
  String title;
  String path;
  VoidCallback onTap;
  GridButton(this.title, this.path, this.onTap);
}

class _GridButtonsState extends State<GridButtons> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.gridList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: widget.gridList[index].onTap,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  widget.gridList[index].path,
                  height: 53.w,
                  width: 53.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  widget.gridList[index].title,
                  style: TextStyle(fontSize: 24.sp),
                )
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossCount,
        mainAxisSpacing: 6.0,
        childAspectRatio: 1.0,
      ),
    );
  }
}
