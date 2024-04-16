import 'package:flutter/material.dart';
import 'package:family_cash_manager/my_button.dart';
import 'package:family_cash_manager/util/input.dart';
// import 'package:family_cash_manager/util/social_media.dart';
import 'package:family_cash_manager/util/text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  TextWidget(
                    text: 'Log in to FamilyCash Manager',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextWidget(
                    text:
                        'Welcome back! Sign in using your social account or email to continue with us 🥰',
                    family: 'Circular Std',
                    color: Color.fromARGB(255, 121, 124, 123),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextWidget(
                          text: 'OR',
                          color: Color.fromARGB(255, 121, 124, 123),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputAccepter(label: 'Your email'),
                  SizedBox(
                    height: 20,
                  ),
                  InputAccepter(
                    label: 'Password',
                    obscurText: true,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                MyButton(),
                SizedBox(
                  height: 18,
                ),
                TextWidget(
                  text: 'Forgot password?',
                  color: Color.fromARGB(255, 36, 120, 109),
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
