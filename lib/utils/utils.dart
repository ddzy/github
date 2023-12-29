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
}

var $utils = IUtilsInterface();
