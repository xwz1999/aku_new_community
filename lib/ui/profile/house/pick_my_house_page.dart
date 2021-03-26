import 'package:akuCommunity/model/user/house_model.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/house/house_func.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/utils/headers.dart';

class PickMyHousePage extends StatefulWidget {
  PickMyHousePage({Key key}) : super(key: key);

  @override
  _PickMyHousePageState createState() => _PickMyHousePageState();
}

class _PickMyHousePageState extends State<PickMyHousePage> {
  _renderTitle(String title) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      sliver: SliverToBoxAdapter(
        child: Text(title, style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }

  Widget get _renderSep => SliverToBoxAdapter(child: 24.hb);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '我的房屋',
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () async {
          final appProvider = Provider.of<AppProvider>(context, listen: false);
          appProvider.updateHouses(await HouseFunc.houses);
        },
        firstRefresh: true,
        child: CustomScrollView(
          slivers: [
            _renderSep,
            _renderTitle('当前房屋'),
            SliverToBoxAdapter(
              child: _HouseCard(
                model: appProvider.selectedHouse,
                highlight: true,
              ),
            ),
          ],
        ),
      ).material(color: Colors.white),
      bottomNavi: ElevatedButton(
        child: Text('新增房屋'),
        onPressed: () {},
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 26.w)),
        ),
      ),
    );
  }
}

class _HouseCard extends StatelessWidget {
  final HouseModel model;
  final bool highlight;
  const _HouseCard({Key key, @required this.model, this.highlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      height: 136.w,
      child: Row(
        children: [
          Container(
            child: Text(
              model.typeValue,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            alignment: Alignment.center,
            height: 88.w,
            width: 88.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              gradient: LinearGradient(
                colors: model.backgroundColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          24.wb,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '人才公寓智慧小区',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color:
                            highlight ? Color(0xFFFF8200) : Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                8.hb,
                Text(
                  model.roomName,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Color(0xFF999999),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
