import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/utils/network/base_list_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

/// ## BeeListView
///```dart
///BeeListView(
///   path: API.someAPI,
///   convert: (model) {
///     return model.tableList
///     .map((e) => SomeModel.fromJson(e))
///     .toList();
///   },
///   controller: _refreshController,
///   builder: (items) {
///     return ListView.builder(
///       itemBuilder: (context, index) {
///         return _buildSomeItem(items[index]);
///       },
///       itemCount: items.length,
///     );
///   },
///)
///```
class BeeListView<T> extends StatefulWidget {
  ///API path
  final String path;

  ///same as EasyRefreshController
  final EasyRefreshController? controller;

  ///转换器
  ///
  ///BaseListModel to T
  ///
  ///T is a tableList item.
  ///
  ///```dart
  ///...
  ///convert: (model) {
  ///   return model.tableList
  ///   .map((e) => SomeModel.fromJson(e))
  ///   .toList();
  ///},
  ///...
  ///```
  final List<T> Function(BaseListModel model) convert;

  ///子组件构造器
  final Widget Function(List<T> items) builder;

  ///每页记录数
  final int size;

  ///额外的参数
  final Map<String, dynamic>? extraParams;
  BeeListView({
    Key? key,
    required this.path,
    required this.controller,
    required this.convert,
    required this.builder,
    this.size = 10,
    this.extraParams,
  }) : super(key: key);

  @override
  _BeeListViewState<T> createState() => _BeeListViewState<T>();
}

class _BeeListViewState<T> extends State<BeeListView> {
  int _pageNum = 1;
  BaseListModel _model = BaseListModel.zero();
  List<T?> _models = [];
  Map<String, dynamic> get _params {
    Map<String, dynamic> tempMap = {
      'pageNum': _pageNum,
      'size': widget.size,
    };
    tempMap.addAll(widget.extraParams ?? {});
    return tempMap;
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: widget.controller,
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        _pageNum = 1;
        _model = await NetUtil().getList(
          widget.path,
          params: _params,
        );
        _models = widget.convert(_model) as List<T?>;
        widget.controller?.resetLoadState();
        if (mounted) setState(() {});
      },
      firstRefresh: true,
      onLoad: () async {
        _pageNum++;
        _model = await NetUtil().getList(
          widget.path,
          params: _params,
        );
        _models.addAll(widget.convert(_model) as List<T?>);
        if (_pageNum >= _model.pageCount!)
          widget.controller!.finishLoad(noMore: true);
        setState(() {});
      },
      child: widget.builder(_models),
    );
  }
}
