


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthProvider{
  final FirebaseAuth authProvider;
  AuthProvider(this.authProvider);

  void doLoginFirebase(String email, String password) async {
    final userCredential = await authProvider.signInWithEmailAndPassword(email: email, password: password);

  }

  void doSignUpFirebase(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
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