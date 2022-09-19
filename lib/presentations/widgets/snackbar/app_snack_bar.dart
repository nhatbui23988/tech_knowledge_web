


import 'package:demo_web/app/res/app_dimens.dart';
import 'package:flutter/material.dart';

class AppSnackBar{
  static void showCommonSnackBar(BuildContext context,
      {String title = '', String content = ''}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content, style: kSnackBarStyle,)));
  }
}