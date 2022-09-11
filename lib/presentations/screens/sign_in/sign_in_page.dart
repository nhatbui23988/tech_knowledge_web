import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/domain/entities/user_info.dart';
import 'package:demo_web/presentations/screens/sign_in/sign_in_controller.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  static Future<dynamic> showMe(BuildContext context) async {
   final result = await Navigator.pushNamed(context, AppRoute.signIn);
   return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Sign in now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: kPrimaryText),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildTextField(
                      context, 'Your email', controller.onEmailFieldChanged),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildTextField(
                      context, 'Password', controller.onPasswordFieldChanged,
                      isHideText: true),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(()=>OutlinedButton(
                          onPressed: controller.rxIsEnableBtn.value ? ()=> controller.onCreateAccount(context) : null,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: kSecondaryText),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: controller.rxIsEnableBtn.value
                                  ? kOutlineBtnPrimary
                                  : Colors.black.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32))),
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Obx(()=>controller.rxIsLoading.value ? Container(
            color: Colors.black.withOpacity(.5),
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: SizedBox(height: 40, width: 40, child: CircularProgressIndicator(strokeWidth: 6,)),
          ) :const SizedBox.shrink())
        ],
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, String hintText, Function(String?) onTextChange,
      {bool isHideText = false}) {
    return TextField(
      obscureText: isHideText,
      onChanged: onTextChange,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}