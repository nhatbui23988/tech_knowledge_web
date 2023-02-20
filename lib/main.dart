import 'package:demo_web/app/module/provider_module.dart';
import 'package:demo_web/provider/local_storage_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/my_application.dart';

void main() async {
  await LocalStorageProviderImpl.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBl_0u_OvrpleHociuLkM6Sv6r8GoTWZSI",
          authDomain: "flutter-web-bea41.firebaseapp.com",
          projectId: "flutter-web-bea41",
          storageBucket: "flutter-web-bea41.appspot.com",
          messagingSenderId: "758668832262",
          appId: "1:758668832262:web:41a1600a94571286589d87",
          measurementId: "G-FZ4QPHMK5T"));
  ProviderModule.init();

  runApp(const MyApp());
}
