import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/models/user/passed_house_list_model.dart';
import 'package:aku_new_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';

enum CardAuthType {
  FAIL,
  SUCCESS,
}

class HouseCard extends StatelessWidget {
  final PassedHouseListModel? model;
  final CardAuthType type;
  final bool isOwner;

  const HouseCard({
    Key? key,
    required this.model,
    required this.type,
    required this.isOwner,
  }) : super(key: key);

  const HouseCard.fail({
    Key? key,
    required this.model,
    required this.isOwner,
  })  : type = CardAuthType.FAIL,
        super(key: key);

  const HouseCard.success({
    Key? key,
    required this.model,
    required this.isOwner,
  })  : type = CardAuthType.SUCCESS,
        super(key: key);

  String get _assetPath {
    switch (type) {
      case CardAuthType.FAIL:
        return R.ASSETS_STATIC_HOUSE_AUTH_FAIL_WEBP;
      case CardAuthType.SUCCESS:
        return R.ASSETS_STATIC_HOUSE_AUTH_SUCCESS_WEBP;
    }
    // return '';
  }

  String get _roleName {
    switch (model?.type ?? 2) {
      case 1:
        return '业主';
      case 2:
        return '';
      case 3:
        return '租户';
      default:
        return '';
    }
  }

  List<BoxShadow> get _shadows {
    switch (type) {
      case CardAuthType.FAIL:
        return [
          BoxShadow(
            offset: Offset(0, 10.w),
            blurRadius: 30.w,
            color: Color(0xFFF0F0F0),
          ),
        ];
      case CardAuthType.SUCCESS:
        return [
          BoxShadow(
            offset: Offset(0, 10.w),
            blurRadius: 30.w,
            color: Color(0xFFFFF0BF),
          ),
        ];
    }
    // return [];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 686 / 386,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            28.hb,
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                height: 48.w,
                minWidth: 152.w,
                color: Colors.white,
                padding: EdgeInsets.zero,
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                child: Text(
                  '切换房屋',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 24.sp,
                  ),
                ),
                onPressed: () {
                  Get.to(() => PickMyHousePage());
                },
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(24.w)),
                ),
              ),
            ),
            12.hb,
            Text(
              S.of(context)!.tempPlotName,
              style: Theme.of(context).textTheme.headline3,
            ),
            10.hb,
            Text(
              model?.roomName ?? '',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '身份',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Color(0xFF666666),
                          ),
                    ),
                    Text(
                      _roleName,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ).expand(),
                //
                isOwner
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '到期时间：${_isOverDate(DateUtil.getDateTime(model?.effectiveTimeEnd ?? ''))}',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Color(0xFF666666),
                                    ),
                          ),
                          Text(
                            DateUtil.formatDateStr(
                                model?.effectiveTimeEnd ?? '',
                                format: 'yyyy-MM-dd'),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ).expand(),
              ],
            ),
            40.hb,
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          image: DecorationImage(image: AssetImage(_assetPath)),
          boxShadow: _shadows,
        ),
      ),
    );
  }

  String _isOverDate(DateTime? date) {
    if (date == null) {
      return '未知';
    }
    if (DateTime.now().isAfter(date)) {
      return '已过期';
    } else {
      return '未过期';
    }
  }
}
