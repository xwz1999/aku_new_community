import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:aku_new_community/models/message/announce_list_model.dart';
import 'package:aku_new_community/pages/message_center_page/announce/announce_card.dart';

class ListDateModel {
  final String month;
  final int index;
  final List<AnnounceListModel> models;

  ListDateModel(this.month, this.models, this.index);
}

class AnnounceView extends StatefulWidget {
  const AnnounceView({
    Key? key,
  }) : super(key: key);

  @override
  _AnnounceViewState createState() => _AnnounceViewState();
}

class _AnnounceViewState extends State<AnnounceView> {
  EasyRefreshController _refreshController = EasyRefreshController();
  late AutoScrollController _autoScrollController;

  List<ListDateModel> _modelLists = [];
  String _headMonth = '';

  void monthListDepart(List<AnnounceListModel> models) {
    for (var item in models) {
      var index =
          _modelLists.indexWhere((element) => element.month == item.month);
      if (index >= 0) {
        _modelLists[index].models.add(item.copyWith());
      } else {
        _modelLists.insert(_modelLists.length,
            ListDateModel(item.month, [item.copyWith()], _modelLists.length));
      }
    }
  }

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.top + 130.w),
      axis: Axis.vertical,
    );

    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Offstage(
        //   offstage: _modelLists.isEmpty,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 32.w),
        //     width: double.infinity,
        //     color: Color(0xFFF9F9F9),
        //     height: 98.w,
        //     child: Row(
        //       children: [
        //         '$_headMonth'.text.size(36.sp).color(ktextPrimary).bold.make(),
        //         20.w.widthBox,
        //         _popupMenuButton(),
        //       ],
        //     ),
        //   ),
        // ),
        Flexible(
          child: EasyRefresh(
            firstRefresh: true,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            scrollController: _autoScrollController,
            onRefresh: () async {
              _modelLists.clear();
              // monthListDepart();
              if (_modelLists.isNotEmpty) {
                _headMonth = _modelLists[0].month;
              }
              setState(() {});
            },
            onLoad: () async {},
            child: _modelLists.isEmpty
                ? Container()
                : ListView.separated(
                    shrinkWrap: true,
                    controller: _autoScrollController,
                    itemBuilder: (context, index) {
                      return AutoScrollTag(
                        key: ValueKey(index),
                        index: index,
                        controller: _autoScrollController,
                        child: AnnounceCard(
                          modelList: _modelLists[index],
                          index: index,
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => SizedBox(),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 32.w),
                    //   alignment: Alignment.centerLeft,
                    //   width: double.infinity,
                    //   height: 98.w,
                    //   child: _modelLists[index + 1]
                    //       .month
                    //       .text
                    //       .size(36.sp)
                    //       .black
                    //       .make(),
                    // ),
                    itemCount: _modelLists.length),
          ),
        ),
      ],
    );
  }

  PopupMenuButton _popupMenuButton() {
    return PopupMenuButton(
      child: Icon(
        CupertinoIcons.arrowtriangle_down_fill,
        size: 24.w,
      ),
      itemBuilder: (context) {
        return List.generate(
            _modelLists.length,
            (index) => PopupMenuItem(
                  child: Text(_modelLists[index].month),
                  value: _modelLists[index].index,
                ));
      },
      onSelected: (value) {
        _headMonth = _modelLists[value].month;
        print(value);
        _autoScrollController.scrollToIndex(value,
            preferPosition: AutoScrollPosition.end);
        setState(() {});
      },
    );
  }
}
