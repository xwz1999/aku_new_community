import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/utils/hive_store.dart';
import 'package:aku_community/widget/bee_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/market/goods_item.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

enum OrderType {
  NORMAL,
  SALES,
  PRICE_HIGH,
  PRICE_LOW,
}

class SearchDetailPage extends StatefulWidget {
  SearchDetailPage({Key? key}) : super(key: key);

  @override
  SearchDetailPageState createState() => SearchDetailPageState();
}

class SearchDetailPageState extends State<SearchDetailPage> {
  TextEditingController _editingController = TextEditingController();
  OrderType _orderType = OrderType.NORMAL;
  IconData priceIcon = CupertinoIcons.chevron_up_chevron_down;
  EasyRefreshController _refreshController = EasyRefreshController();
  List<String> _searchHistory = [];
  String _searchText = "";
  FocusNode _contentFocusNode = FocusNode();
  bool _showList = true;

  @override
  void initState() {
    super.initState();
    getSearchListFromSharedPreferences();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final normalTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.NORMAL;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '综合',
        style: TextStyle(
          color:
          _orderType == OrderType.NORMAL ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.NORMAL ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.NORMAL
              ?FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final salesTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.SALES;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '销量',
        style: TextStyle(
          color:
          _orderType == OrderType.SALES ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.SALES ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.SALES
              ?FontWeight.bold
              : FontWeight.normal,
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
            priceIcon = CupertinoIcons.chevron_up;
            break;
          case OrderType.PRICE_HIGH:
            _orderType = OrderType.PRICE_LOW;
            priceIcon = CupertinoIcons.chevron_down;
            break;
          case OrderType.PRICE_LOW:
            _orderType = OrderType.PRICE_HIGH;
            priceIcon = CupertinoIcons.chevron_up;
            break;
        }
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
                  ?FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Icon(
            priceIcon,
            size: 32.w,
            color: _orderType == OrderType.PRICE_HIGH ||
                _orderType == OrderType.PRICE_LOW
                ? kBalckSubColor
                : ktextPrimary,
          ),
        ],
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return BeeScaffold(
      titleSpacing: 0,
      bgColor: Color(0xFFF9F9F9),
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
                _searchText = text;
                setState(() {});
              },
              onSubmitted: (_submitted) async {
                _contentFocusNode.unfocus();
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
              },
              style: TextStyle(
                textBaseline: TextBaseline.ideographic,
                fontSize: 32.sp,
                color: Colors.black,
              ),
              controller: _editingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.w),
                //filled: true,
                fillColor: Color(0xFFF3F3F3),
                hintText: "请输入想要搜索的内容...",
                hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),

                //isDense: true,
                // prefixIcon: Icon(CupertinoIcons.search),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ktextPrimary),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE52E2E)),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          20.wb,
          Image.asset(R.ASSETS_ICONS_ICON_CHANGE_LIST_PNG,width: 48.w,height: 48.w,),

          Text(
            '搜索',
            style: TextStyle(color: ktextPrimary, fontSize: 28.sp),
          ),
        ],
      ),
      body: Column(
        children: [
        Row(
            children: [
              normalTypeButton,
              salesTypeButton,
              priceButton,
            ],
          ),
          10.hb,
          10.hb,
          _showList
              ? Container(
                color: Color(0xFFF2F3F4),
                child: BeeListView(
                    path: API.market.search,
                    controller: _refreshController,
                    extraParams: {'searchName': ''},
                    convert: (model) => model.tableList!
                        .map((e) => GoodsItem.fromJson(e))
                        .toList(),
                    builder: (items) {
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 10.w,
                            left: 20.w, right: 20.w, bottom: 32.w),
                        // gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   mainAxisSpacing: 20.w,
                        //   crossAxisSpacing: 20.w,
                        // ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _hotGoodsCard(
                              item, index); //GoodsCard(item: item);
                        },
                        separatorBuilder: (_, __) {
                          return 32.w.heightBox;
                        },
                        itemCount: items.length,
                      );
                    },
                  ),
              ).expand()
              : SizedBox(),
        ],
      ),
    );
  }

  _hotGoodsCard(GoodsItem goodsItem, int index) {
    return Row(
      children: [
        Stack(
          children: [
            Material(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16.w),
              clipBehavior: Clip.antiAlias,
              child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(ImgModel.first(goodsItem.imgList)),
                fit: BoxFit.fill,
                width: 124.w,
                height: 124.w,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    width: 124.w,
                    height: 124.w,
                  );
                },
              ),
            ),
            // Image.asset(
            //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            //   fit: BoxFit.fill,
            //   width: 124.w,
            //   height: 124.w,
            // ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.w),
                        topRight: Radius.circular(16.w),
                        bottomLeft: Radius.circular(16.w)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: index == 0
                          ? <Color>[
                              Color(0xFFE52E2E),
                              Color(0xFFF58123),
                            ]
                          : index == 1
                              ? <Color>[
                                  Color(0xFFF58123),
                                  Color(0xFFF5AF16),
                                ]
                              : index == 2
                                  ? <Color>[
                                      Color(0xFFF5AF16),
                                      Color(0xFFF5AF16),
                                    ]
                                  : <Color>[
                                      Color(0xFFBBBBBB),
                                      Color(0xFFBBBBBB),
                                    ],
                    ),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                    ),
                  ),
                )),
          ],
        ),
        32.wb,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 500.w,
              child: Text(
                goodsItem.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ktextPrimary, fontSize: 28.sp),
              ),
            ),
            8.hb,
            Row(
              children: [
                Text(
                  '人气值',
                  style: TextStyle(color: ktextSubColor, fontSize: 24.sp),
                ),
                10.wb,
                Text(
                  '99251',
                  style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 24.sp),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  _searchHistoryWidget() {
    List<Widget> choiceChipList = [];
    if (_searchHistory != null && _searchHistory.length > 0) {
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
              _editingController.text = text;
              _searchText = text;
              FocusManager.instance.primaryFocus!.unfocus();
              setState(() {});
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
                          (_searchHistory != null && _searchHistory.length > 0)
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

  getSearchListFromSharedPreferences() async {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    _searchHistory = HiveStore.appBox!.get(
        userProvider.userInfoModel?.id.toString() ?? '' + "userSearhHistory")!;
    if (_searchHistory == null) {
      _searchHistory = [];
    }
    setState(() {});
  }

  saveSearchListToSharedPreferences(List<String> value) async {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);

    HiveStore.appBox!.put(
        userProvider.userInfoModel?.id.toString() ?? '' + "userSearhHistory",
        value);
  }
}
