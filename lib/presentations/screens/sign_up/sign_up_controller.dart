import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}

class SignUpController extends BaseController {
  final FirebaseAuth authProvider = FirebaseAuth.instance;
  String? _email;
  String? _password;
  RxBool rxIsEnableBtn = RxBool(false);

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

  void onCreateAccount() async {
    if (_email != null ||
        _email?.isNotEmpty == true ||
        _password != null ||
        _password?.isNotEmpty == true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email!, password: _password!);
        final user = userCredential.user;
        if(user != null){
          print('userCredential user ${user.email}');
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
    }
  }
}