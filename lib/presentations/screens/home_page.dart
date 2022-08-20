import 'dart:ui';

import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/presentations/widgets/custom_app_bar.dart';
import 'package:demo_web/res/app_images.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static void showMe(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.homePagePath);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        isLoadingImage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            pinned: true,
            backgroundColor: kPrimaryBackground,
            leading: SizedBox.shrink(),
            title: CustomAppBar(isLoggedIn: false),
          ),
        ];
      },
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AnimatedOpacity(
                    opacity: isLoadingImage ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image(
                              width: MediaQuery.of(context).size.width / 1.5,
                              image: AppImages.imgHomeBg,
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                color: Colors.black.withOpacity(0.1),
                                alignment: Alignment.center,
                                child: Image(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  image: AppImages.imgHomeBg,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),

                            // ClipRRect(
                            //     borderRadius: BorderRadius.circular(16),
                            //     child: BackdropFilter(
                            //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            //       child: Container(
                            //         color: Colors.grey.withOpacity(0.1),
                            //         child: Image(
                            //           width: MediaQuery.of(context).size.width / 1.5,
                            //           image: AppImages.imgHomeBg,
                            //         ),
                            //       ),
                            //     )),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Technology Education',
                                    style: TextStyle(
                                        color: kSecondaryText,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Technology Academy, sharing programming knowledge and providing software engineer training courses through real projects.',
                                    style: const TextStyle(
                                        color: kSecondaryText, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 42,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                                        Text(
                                          'More information',
                                          style: TextStyle(
                                              color: kSecondaryText,
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_circle_right, color: Colors.white,)
                                      ],),
                                    ),
                                    style: OutlinedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _goToLoginPage(){

  }

  void _goToSignUpPage(){

  }
}
