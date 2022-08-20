import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/presentations/screens/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState()  {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.homePagePath,
      theme: ThemeData(primarySwatch: Colors.blueGrey, visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(),
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}



