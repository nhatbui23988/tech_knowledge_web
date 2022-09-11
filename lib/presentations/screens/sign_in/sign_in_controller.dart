import 'package:demo_web/domain/auth_use_case.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    final authUseCase =AuthUseCase();
    // Get.put(authUseCase);
    Get.put(SignInController(authUseCase));
  }
}

class SignInController extends BaseController {
  final AuthUseCase authUseCase;
  SignInController(this.authUseCase);
  String? _email;
  String? _password;
  RxBool rxIsEnableBtn = RxBool(false);
  RxBool rxIsLoading = RxBool(false);

  void onEmailFieldChanged(String? text) {
    _email = text;
    enableButton();
  }

  void onPasswordFieldChanged(String? text) {
    _password = text;
    enableButton();
  }

  void enableButton() {
    rxIsEnableBtn.value =
        (_email?.isNotEmpty == true) && (_password?.isNotEmpty == true);
  }

  void onCreateAccount(BuildContext context) async {
    if (_email != null ||
        _email?.isNotEmpty == true ||
        _password != null ||
        _password?.isNotEmpty == true) {
      try {
        rxIsLoading.value = true;
        final appUserInfo = await authUseCase.doLoginFirebase(_email!, _password!);
        if(appUserInfo != null){
          Navigator.of(context).pop(appUserInfo);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      finally{
        rxIsLoading.value = false;
      }
    }
  }
}