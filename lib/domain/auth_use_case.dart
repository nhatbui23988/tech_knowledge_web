



import 'package:demo_web/domain/entities/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUseCase{
 final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<AppUserInfo?> doLoginFirebase(String email, String password) async{
    final userCredential= await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if(userCredential.user != null){
      return AppUserInfo(email: userCredential.user?.email);
    }
    return null;
  }
}