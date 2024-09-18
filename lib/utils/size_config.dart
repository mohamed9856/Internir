import 'dart:math';

import 'package:flutter/widgets.dart';

class SizeConfig {
  static const double designWidth = 390;
  static const double designHeight = 798;
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalBlock;
  static late double verticalBlock;
  static late double statusBarHeight;
  static late double textRatio;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    statusBarHeight = _mediaQueryData.padding.top;
    horizontalBlock = (_mediaQueryData.size.width) / designWidth;
    verticalBlock = (screenHeight - statusBarHeight) / (designHeight);
    textRatio = min(verticalBlock, horizontalBlock);
  }
}