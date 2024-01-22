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

  String formatTimesAgo(DateTime from, DateTime now) {
    const eachSecond = 1000;
    const eachMinute = 60 * eachSecond;
    const eachHour = 60 * eachMinute;
    const eachDay = 24 * eachHour;
    const eachMonth = 30 * eachDay;
    const eachYear = 365 * eachMonth;
    var msBetween = now.difference(from).inMilliseconds;

    switch (msBetween) {
      case <= eachSecond:
        return '1秒前';
      case < eachMinute:
        return '${(msBetween / eachSecond).round()}秒前';
      case eachMinute:
        return '1分钟前';
      case < eachHour:
        return '${(msBetween / eachMinute).round()}分钟前';
      case eachHour:
        return '1小时前';

      case < eachDay:
        return '${(msBetween / eachMinute).round()}小时前';
      case eachDay:
        return '1天前';

      case < eachMonth:
        return '${(msBetween / eachDay).round()}天前';
      case eachMonth:
        return '1个月前';

      case < eachYear:
        return '${(msBetween / eachMonth).round()}个月前';
      case eachYear:
        return '1年前';

      case > eachYear:
        return '${(msBetween / eachYear).round()}年前';
      default:
        return '';
    }
  }
}

var $utils = IUtilsInterface();
