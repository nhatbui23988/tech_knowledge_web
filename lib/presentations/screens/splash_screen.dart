import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:demo_web/presentations/screens/home_page.dart';
import 'package:demo_web/res/app_images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        if (mounted) _cacheImages();
      },
    );

    super.initState();
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Be',
                  style: TextStyle(
                      fontSize: 43.0,
                      color: Colors.red,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(width: 20.0, height: 100.0),
                Stack(
                  children: [
                    Text('OPTIMISTIC',
                        style: const TextStyle(
                            fontSize: 45.0,
                            color: Colors.transparent,
                            decoration: TextDecoration.none)),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 45.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        totalRepeatCount: 3,
                        onNext: (_, __) {
                          if (_isLoading) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        onFinished: () {},
                        animatedTexts: [
                          RotateAnimatedText('AWESOME'),
                          RotateAnimatedText('OPTIMISTIC'),
                          RotateAnimatedText('DIFFERENT'),
                        ],
                        // onTap: () {
                        //   MyHomePage.showMe(context);
                        // },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: AnimatedOpacity(
                opacity: _isLoading ? 0 : 1,
                duration: const Duration(milliseconds: 1000),
                child: GestureDetector(
                  onTap: () {
                    MyHomePage.showMe(context);
                  },
                  child: Text(
                    'Go to Home page',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )),
          )
        ],
      )),
    ));
  }

  Future _cacheImages() async {
    await precacheImage(const Image(image: AppImages.imgHomeBg).image, context);
    await precacheImage(
        const Image(image: AppImages.icResearchPath).image, context);
  }
}
