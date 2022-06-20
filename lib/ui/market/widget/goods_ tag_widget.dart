import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/cupertino.dart';

import '../../../base/base_style.dart';

class GoodsTagWidget extends StatelessWidget {
  final int type;
  const GoodsTagWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getIcon(type);
  }

  Widget _getIcon(int type) {
    if (type == 1) {
      return Container(
        width: 86.w,
        height: 26.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFEC5329), Color(0xFFF58123)],
          ),
        ),
        child: Text(
          '京东自营',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else if (type == 2) {
      return Container(
        alignment: Alignment.center,
        width: 86.w,
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFF59B1C), Color(0xFFF5AF16)],
          ),
        ),
        child: Text(
          '京东POP',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else
      return SizedBox();
  }

}
