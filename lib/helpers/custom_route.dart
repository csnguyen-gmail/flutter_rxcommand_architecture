import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

class FadeFullScreenPageRoute<T> extends MaterialPageRoute<T> {
  final bool statusBarDarkStyle;
  final bool statusBarDarkStyleBack;

  FadeFullScreenPageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    this.statusBarDarkStyle = true,
    this.statusBarDarkStyleBack = true,
  }) : super(builder: builder, settings: settings, fullscreenDialog: true);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. If you don't want any animation, just return child.
    return new FadeTransition(opacity: animation, child: child);
  }

  @override
  TickerFuture didPush() {
    Future.delayed(const Duration(milliseconds: 300), () {
      FlutterStatusbarManager.setStyle(statusBarDarkStyle ? StatusBarStyle.DARK_CONTENT : StatusBarStyle.LIGHT_CONTENT);
    });
    return super.didPush();
  }

  @override
  bool didPop(T result) {
    Future.delayed(const Duration(milliseconds: 300), () {
      FlutterStatusbarManager.setStyle(statusBarDarkStyleBack ? StatusBarStyle.DARK_CONTENT : StatusBarStyle.LIGHT_CONTENT);
    });
    return super.didPop(result);
  }
}

class CustomMaterialPageRoute<T> extends MaterialPageRoute<T> {
  final bool statusBarDarkStyle;
  final bool statusBarDarkStyleBack;

  CustomMaterialPageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
    this.statusBarDarkStyle = true,
    this.statusBarDarkStyleBack = true,
  }) : super(builder: builder, settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  TickerFuture didPush() {
    Future.delayed(const Duration(milliseconds: 300), () {
      FlutterStatusbarManager.setStyle(statusBarDarkStyle ? StatusBarStyle.DARK_CONTENT : StatusBarStyle.LIGHT_CONTENT);
    });
    return super.didPush();
  }

  @override
  bool didPop(T result) {
    Future.delayed(const Duration(milliseconds: 300), () {
      FlutterStatusbarManager.setStyle(statusBarDarkStyleBack ? StatusBarStyle.DARK_CONTENT : StatusBarStyle.LIGHT_CONTENT);
    });
    return super.didPop(result);
  }
}
