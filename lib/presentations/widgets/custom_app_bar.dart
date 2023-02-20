import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/domain/entities/user_info.dart';
import 'package:demo_web/presentations/screens/sign_in/sign_in_page.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar(
      {Key? key, required this.isLoggedIn, required this.currentPage})
      : super(key: key);
  final bool isLoggedIn;
  final PageName currentPage;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isLoggedIn = false;

  AppUserInfo? appUserInfo;

  @override
  void initState() {
    _isLoggedIn = widget.isLoggedIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kPrimaryBackground,
      ),
      child: Row(
        children: [
          _buildAppLogo(),
          Expanded(child: _listTopic()),
          const SizedBox(
            width: 24,
          ),
          (_isLoggedIn && appUserInfo != null)
              ? _buildUserInfo(context, appUserInfo!)
              : _buildSignInSignUp(context)
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, AppUserInfo appUserInfo) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 24,
                color: Colors.black,
              ),
              Text(
                appUserInfo.email ?? '',
                style: const TextStyle(color: kPrimaryText, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            width: 24,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _isLoggedIn = false;
                });
              },
              child: const Text(
                'Sign out',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ))
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return const Text(
      'Tech Knowledge',
      style: TextStyle(
          color: kPrimaryText, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _buildSignInSignUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () => _goToSignInPage(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryText,
                      fontSize: 14),
                ),
              )),
          const SizedBox(
            width: 4,
          ),
          OutlinedButton(
            onPressed: () => _goToSignUpPage(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Text(
                'Sign up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryText,
                    fontSize: 14),
              ),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: kButtonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          )
        ],
      ),
    );
  }

  Widget _listTopic() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _topicItem('Home', () {
          _goToDestinationPage(context, AppRoute.homePage);
        }, PageName.home),
        // _topicItem('Concept', () {}, PageName.concept),
        // _topicItem('Lessons', () {}, PageName.lesson),
        // _topicItem('Construct', () {}, PageName.construct),
        // _topicItem('Exercise', () {}, PageName.exercise),
        // _topicItem('Operator', () {}, PageName.operator),
        _topicItem('Knowledge Manager', () {
          _goToDestinationPage(context, AppRoute.addKnowledgePage);
        }, PageName.knowledgeManager),
      ],
    );
  }

  Widget _topicItem(String title, VoidCallback? onTap, PageName pageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
              color: kPrimaryText, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: TextButton.styleFrom(
            backgroundColor: pageName == widget.currentPage
                ? Colors.black12
                : Colors.transparent),
      ),
    );
  }

  void _goToSignInPage(BuildContext context) async {
    final result = await SignInPage.showMe(context);
    if (result is AppUserInfo) {
      appUserInfo = result;
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _goToSignUpPage(BuildContext context) async {
    final result = await SignUpPage.showMe(context);
    if (result is AppUserInfo) {
      appUserInfo = result;
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _goToDestinationPage(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
