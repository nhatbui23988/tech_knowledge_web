import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/domain/entities/user_info.dart';
import 'package:demo_web/presentations/screens/sign_in/sign_in_controller.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConceptTabPage extends GetView<SignInController> {
  const ConceptTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Center(child: Text('ConceptTabPage'));
  }

}
