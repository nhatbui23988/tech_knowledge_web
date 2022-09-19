


import 'package:demo_web/domain/entities/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthProvider{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AppUserInfo?> doLoginFirebase(String email, String password) async{
    final userCredential= await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if(userCredential.user != null){
      return AppUserInfo(email: userCredential.user?.email);
    }
    return null;
  }

  Future doSignUpFirebase(String email, String password) async{
    try {
      UserCredential userCredential = await _firebaseAuth
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