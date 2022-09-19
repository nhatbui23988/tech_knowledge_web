import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:flutter/material.dart';

enum SnackBarState { normal, succeed, error, information }

class AppSnackBar {
  static void showCommonSnackBar(BuildContext context,
      {String title = '',
      String content = '',
      SnackBarState state = SnackBarState.normal}) {
    Color bgState;
    TextStyle textStyle = kSnackBarStyle;
    switch (state) {
      case SnackBarState.succeed:
        bgState = kSuccessColor;
        break;
      case SnackBarState.error:
        bgState = kErrorColor;
        break;
      case SnackBarState.information:
        bgState = kInformationColor;
        break;
      case SnackBarState.normal:
      default:
        bgState = kPrimaryBackground;
        textStyle = textStyle.copyWith(color: kPrimaryText);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        style: textStyle,
      ),
      backgroundColor: bgState,
      duration: const Duration(seconds: 3),
    ));
  }
}
