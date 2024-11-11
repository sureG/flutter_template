import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

///默认设计稿尺寸（单位 dp or pt）
double _designW = 375.0;
///PC样式的宽度判断阈值
double _pcMinWidth = 600.0;

MediaQueryData? _mediaQueryData;
Size _screenSize = const Size(0, 0);

class ScreenUtil {
  /// 设置设计稿尺寸
  static void setDesignWith(double width) {
    _designW = width;
  }

  static Size getScreenSize() {
    final mediaQuery = MediaQueryData.fromWindow(window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenSize = mediaQuery.size;
    }
    return _screenSize;
  }

  static double getScreenWidth() {
    return getScreenSize().width;
  }

  static double getScreenHeight() {
    return getScreenSize().height;
  }

  static bool isPCScreen() {
    if (kIsWeb) {
      return getScreenWidth() >= _pcMinWidth;
    }
    return false;
  }

  /// 返回根据屏幕宽适配后尺寸
  static double getWidth(double size) {
    final screenWidth = isPCScreen() ? _pcMinWidth : getScreenWidth();
    return screenWidth == 0.0 ? size : (size * screenWidth / _designW);
  }
}

extension DoubleRate on double {
  /// 返回按设计稿尺寸等比处理后的值
  double get w {
    return ScreenUtil.getWidth(this);
  }
}

extension IntRate on int {
  /// 返回按设计稿尺寸等比处理后的值
  double get w {
    return toDouble().w;
  }

  /// 返回 pt.ceil() 后的值
  double get sp {
    return w.ceil().toDouble();
  }

}

extension WidgetCenterForPC on Widget {
  Widget get adaptWebForPC {
    if (ScreenUtil.isPCScreen()) {
      return Center(
          child: SizedBox(
              width: _pcMinWidth,
              child: this)
      );
    }
    return this;
  }
}



