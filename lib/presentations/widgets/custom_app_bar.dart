import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/res/app_images.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.isLoggedIn}) : super(key: key);
  final isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kPrimaryBackground,
      ),
      child: Row(
        children: [
          _buildAppLogo(),
          Expanded(child: _listTopic()),
          isLoggedIn ? const SizedBox.shrink() : _buildSignInSignUp()
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return Text(
      'Tech Knowledge',
      style: TextStyle(color: kPrimaryText),
    );
  }

  Widget _buildSignInSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  'Login',
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
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Text(
                'Sign up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryText,
                    fontSize: 14),
              ),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: kOutlineBtnPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          )
        ],
      ),
    );
  }

  Widget _listTopic(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _topicItem('Home', () { }),
        _topicItem('Lessons', () { }),
        _topicItem('Documentation', () { }),
        _topicItem('About us', () { }),
      ],
    );
  }

  Widget _topicItem(String title, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: onTap,
        child: Text(title, style: TextStyle(color: kPrimaryText, fontWeight: FontWeight.bold, fontSize: 16),),
      ),
    );
  }
}
