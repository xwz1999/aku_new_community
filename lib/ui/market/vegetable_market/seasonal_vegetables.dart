import 'package:aku_new_community/base/base_style.dart';

import 'package:aku_new_community/models/market/goods_popular_model.dart';

import 'package:aku_new_community/provider/user_provider.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/text_utils.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../search/search_goods_page.dart';

class SeasonalVegetables extends StatefulWidget {
  final String searchText;

  const SeasonalVegetables({Key? key, required this.searchText})
      : super(key: key);

  @override
  _SeasonalVegetablesState createState() => _SeasonalVegetablesState();
}

class _SeasonalVegetablesState extends State<SeasonalVegetables> {
  OrderType _orderType = OrderType.NORMAL;
  String priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;

  EasyRefreshController _refreshController = EasyRefreshController();
  EasyRefreshController _refreshController1 = EasyRefreshController();
  TextEditingController _editingController = TextEditingController();
  List<String> _searchHistory = [];
  String _searchText = "";
  FocusNode _contentFocusNode = FocusNode();
  bool _showList = true;
  bool _startSearch = false;
  int? orderBySalesVolume;
  int? orderByPrice;
  int? brandId;
  double? minPrice;
  double? maxPrice;
  bool _onLoad = true;
  List vegetablesList = [];

  // List<SearchGoodsModel> _models = [];
  // ScrollController _scrollController = new ScrollController();
  List<GoodsPopularModel> goodsPopularModels = [];
  int? categoryThirdId;
  bool _showCategory = false;

  // bool _showListOrGrid = true;

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context, listen: false);
    final normalTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.NORMAL;
        priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;
        orderBySalesVolume = null;
        orderByPrice = null;
        _refreshController.callRefresh();
        setState(() {});
      },
      child: Text(
        '综合',
        style: TextStyle(
          color: _orderType == OrderType.NORMAL ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.NORMAL ? 32.sp : 28.sp,
          // fontWeight: _orderType == OrderType.NORMAL
          //     ? FontWeight.bold
          //     : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final salesTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.SALES;
        orderBySalesVolume = 2;
        orderByPrice = null;
        priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;
        _refreshController.callRefresh();
        setState(() {});
      },
      child: Text(
        '销量',
        style: TextStyle(
          color: _orderType == OrderType.SALES ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.SALES ? 32.sp : 28.sp,
          // fontWeight: _orderType == OrderType.SALES
          //     ? FontWeight.bold
          //     : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final priceButton = MaterialButton(
      onPressed: () {
        switch (_orderType) {
          case OrderType.NORMAL:
          case OrderType.SALES:
            _orderType = OrderType.PRICE_HIGH;
            orderByPrice = 1;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_TOP_PNG;
            break;
          case OrderType.PRICE_HIGH:
            _orderType = OrderType.PRICE_LOW;
            orderByPrice = 2;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_BOTTOM_PNG;
            break;
          case OrderType.PRICE_LOW:
            _orderType = OrderType.PRICE_HIGH;
            orderByPrice = 1;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_TOP_PNG;
            break;
        }
        _refreshController.callRefresh();
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            '价格',
            style: TextStyle(
              color: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? kBalckSubColor
                  : ktextPrimary,
              fontSize: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? 32.sp
                  : 28.sp,
              fontWeight: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          // Icon(
          //   priceIcon,
          //   size: 32.w,
          //   color: _orderType == OrderType.PRICE_HIGH ||
          //       _orderType == OrderType.PRICE_LOW
          //       ? kBalckSubColor
          //       : ktextPrimary,
          // ),
          Image.asset(
            priceIcon,
            width: 32.w,
            height: 32.w,
          )
        ],
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final listButton = MaterialButton(
        onPressed: () async {
          _orderType = OrderType.LIST;
          _refreshController.callRefresh();
          setState(() {});
        },
        child: Image.asset(
          Assets.icons.list.path,
          //R.ASSETS_ICONS_ICON_CHANGE_LIST_PNG,
          width: _orderType == OrderType.LIST ? 42.w : 36.w,
          height: _orderType == OrderType.LIST ? 42.w : 36.w,
        ));
    return BeeScaffold(
        titleSpacing: 0,
        bgColor: Colors.white,
        bodyColor: Color(0xFFF9F9F9),
        title: Row(
          children: [
            Container(
              width: 520.w,
              height: 68.w,
              child: TextField(
                keyboardType: TextInputType.text,
                onEditingComplete: () {
                  setState(() {});
                  // _refreshController.callRefresh();
                },
                focusNode: _contentFocusNode,
                onChanged: (text) {
                  _startSearch = false;
                  _searchText = text;
                  setState(() {});
                },
                onTap: () {
                  _showCategory = false;
                  setState(() {});
                },
                onSubmitted: (_submitted) async {
                  if (TextUtils.isEmpty(_searchText)) return;
                  _startSearch = true;
                  _contentFocusNode.unfocus();
                  _searchText = _searchText.trimLeft();
                  _searchText = _searchText.trimRight();
                  remember();
                  saveSearchListToSharedPreferences(_searchHistory);
                  _refreshController1.callRefresh();
                  setState(() {});
                },
                style: TextStyle(
                  textBaseline: TextBaseline.ideographic,
                  fontSize: 32.sp,
                  color: Colors.black,
                ),
                controller: _editingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.w),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: _showCategory ? '' : "请输入想要搜索的内容...",
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  prefixIcon: _showCategory
                      ? GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 18.w, right: 18.w),
                            margin: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: Color(0xFFF2F2F2)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '生鲜果蔬',
                                  //widget.categoryName ?? '',
                                  style: TextStyle(
                                    color: ktextSubColor,
                                    fontSize: 24.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.close,
                                  color: Colors.grey[500],
                                  size: 30.w,
                                )
                              ],
                            ),
                            height: 44.w,
                          ),
                        )
                      : null,

                  //isDense: true,
                  // prefixIcon: Icon(CupertinoIcons.search),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ktextPrimary),
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE52E2E)),
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                ),
              ),
            ),
            20.wb,
            GestureDetector(
              onTap: () {
                if (TextUtils.isEmpty(_searchText)) return;
                _startSearch = true;
                _contentFocusNode.unfocus();
                _searchText = _searchText.trimLeft();
                _searchText = _searchText.trimRight();
                remember();
                saveSearchListToSharedPreferences(_searchHistory);
                _refreshController.callRefresh();
                setState(() {});
              },
              child: Text(
                '搜索',
                style: TextStyle(color: ktextPrimary, fontSize: 28.sp),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: PreferredSize(
                  preferredSize: Size.fromHeight(40.w),
                  child: _goodsTitle(normalTypeButton, salesTypeButton,
                      priceButton, listButton)),
            ),
            _searchHistoryWidget(),
            10.hb,
            Expanded(
                child: EasyRefresh(
                    firstRefresh: true,
                    header: MaterialHeader(),
                    footer: MaterialFooter(),
                    controller: _refreshController,
                    onRefresh: () async {
                      _onLoad = false;
                      setState(() {});
                    },
                    onLoad: () async {
                      setState(() {});
                    },
                    child: _onLoad
                        ? const SizedBox()
                        : vegetablesList.isEmpty
                            ? _getListNull()
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return Text('');
                                },
                                itemCount: vegetablesList.length,
                              )))
          ],
        ));
  }

  _goodsTitle(
    Widget normalTypeButton,
    Widget salesTypeButton,
    Widget priceButton,
    Widget listButton,
  ) {
    return Container(
      height: 90.w,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60.w,
        child: Row(
          children: [
            normalTypeButton,
            salesTypeButton,
            priceButton,
            listButton,
          ],
        ),
      ),
    );
  }

  ///列表为空
  _getListNull() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          500.hb,
          // Assets.images.houseEmpty.image(width: 480.w, height: 480.w),
          '当前类目暂未上传商品'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.25))
              .make(),
        ],
      ),
    );
  }

  ///搜索记录
  _searchHistoryWidget() {
    List<Widget> choiceChipList = [];
    if (_searchHistory.length > 0) {
      for (var text in _searchHistory) {
        choiceChipList.add(Padding(
          padding: EdgeInsets.only(right: 10, bottom: 5),
          child: ChoiceChip(
            backgroundColor: Colors.white,
            // disabledColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),
            labelPadding: EdgeInsets.only(left: 20, right: 20),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: (bool value) {
              _startSearch = true;
              _editingController.text = text;
              _searchText = text;
              setState(() {});
              FocusManager.instance.primaryFocus!.unfocus();
              _refreshController.callRefresh();
            },
            label: Text(text),
            selected: false,
          ),
        ));
      }
    }

    return _searchHistory.length == 0
        ? SizedBox()
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                36.hb,
                Container(
                  child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '历史搜索',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          (_searchHistory.length > 0)
                              ? GestureDetector(
                                  onTap: () {
                                    _searchHistory = [];
                                    saveSearchListToSharedPreferences(
                                        _searchHistory);
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    R.ASSETS_ICONS_DELETE_PNG,
                                    width: 40.w,
                                    height: 40.w,
                                  ),
                                )
                              : Container(),
                          36.wb,
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Wrap(
                    children: choiceChipList,
                  ),
                ),
                // Spacer()
                24.hb,
              ],
            ),
          );
  }

  ///获取搜索记录
  getSearchListFromSharedPreferences() async {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    var history = HiveStore.appBox!.get(
        userProvider.userInfoModel?.id.toString() ?? '' + "userSearhHistory");
    if (history != null) {
      _searchHistory = (history as List).cast<String>().toList();
    }
    setState(() {});
  }

  ///保存搜索记录
  saveSearchListToSharedPreferences(List<String> value) async {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);

    HiveStore.appBox!.put(
        userProvider.userInfoModel?.id.toString() ?? '' + "userSearhHistory",
        value);
  }

  ///保存搜索记录
  remember() {
    if (_searchHistory.contains(_searchText)) {
      _searchHistory.remove(_searchText);
      List<String> list = [_searchText];
      list.addAll(_searchHistory);
      _searchHistory = list;
    } else {
      List<String> list = [_searchText];
      list.addAll(_searchHistory);
      _searchHistory = list;
      while (_searchHistory.length > 15) {
        _searchHistory.removeLast();
      }
    }
    saveSearchListToSharedPreferences(_searchHistory);
    setState(() {});
  }
}
