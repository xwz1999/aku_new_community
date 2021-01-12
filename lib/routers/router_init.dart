import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'page_routers.dart';

class RouterInit {
  static final router = Router();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static setupRouter() {
    pageRoutes.forEach((path, handler) {
      router.define(
        path.toString(),
        handler: handler.getHandler(),
        transitionType: TransitionType.cupertino,
      );
    });
  }
}
