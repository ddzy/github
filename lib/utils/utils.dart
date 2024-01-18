import 'dart:math';

import 'package:flutter/material.dart';



class IUtilsInterface {
  void showSnackBar(BuildContext context, Widget child, {bool center = true, Duration duration = const Duration(milliseconds: 2000)}) {
    var newChild = center
        ? SizedBox(
            child: Center(
              child: child,
            ),
          )
        : child;
    var messenger = ScaffoldMessenger.of(context);

    messenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: newChild,
          duration: duration,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  /// 角度转弧度
  double angleToRadian(double angle) {
    return pi * angle / 180;
  }

  /// 弧度转角度
  double radianToAngle(double radian) {
    return 180 * radian / pi;
  }

  /// 检查某个值是否存在
  bool isExist(v) {
    return !['', false, null, 0, ""].contains(v);
  }
}

var $utils = IUtilsInterface();
