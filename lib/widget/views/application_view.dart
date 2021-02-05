import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ApplicationView extends StatefulWidget {
  final List<AO> items;
  ApplicationView({Key key})
      : items = null,
        super(key: key);

  ApplicationView.custom({Key key, @required this.items})
      : assert(items != null),
        super(key: key);

  @override
  _ApplicationViewState createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  _buildTile(AO object) {
    return MaterialButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.zero,
      onPressed: () => Get.to(object.page),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            object.path,
            height: 75.w,
            width: 75.w,
          ),
          8.hb,
          object.title.text.size(24.sp).make(),
        ],
      ),
    );
  }

  bool get _isCustom => widget.items != null;
  List<AO> get _items {
    final appProvider = Provider.of<AppProvider>(context);

    return _isCustom ? widget.items : appProvider.myApplications;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        if (index == _items.length) return _buildTile(allApp);
        return _buildTile(_items[index]);
      },
      itemCount: _items.length + 1,
      shrinkWrap: true,
    );
  }
}
