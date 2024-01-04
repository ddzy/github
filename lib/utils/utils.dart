import 'dart:math';

import 'package:flutter/material.dart';

class IUtilsInterface {
  void showSnackBar(BuildContext context, Widget child,
      {bool center = true,
      Duration duration = const Duration(milliseconds: 2000)}) {
    var newChild = center
        ? SizedBox(
            child: Center(
              child: child,
            ),
          )
        : child;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: newChild,
      duration: duration,
    ));
  }

  /// 角度转弧度
  double angleToRadian(double angle) {
    return pi * angle / 180;
  }

  /// 弧度转角度
  double radianToAngle(double radian) {
    return 180 * radian / pi;
  }
}

var $utils = IUtilsInterface();
