import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpController> {
  SignUpPage();

  static void showMe(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Text(
                    'Create an account',
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
                      onPressed: controller.rxIsEnableBtn.value ? controller.onCreateAccount : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Text(
                          'Create your account',
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
