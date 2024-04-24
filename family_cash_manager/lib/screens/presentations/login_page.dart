import 'package:family_cash_manager/screens/presentations/signup.dart';
import 'package:flutter/material.dart';
import 'package:family_cash_manager/widgets/presentation/my_button.dart';
import 'package:family_cash_manager/util/input.dart';
// import 'package:family_cash_manager/util/social_media.dart';
import 'package:family_cash_manager/util/text.dart';

/// The LoginPage class represents the login screen of the Family Cash Manager app.
/// This class extends StatelessWidget and defines the UI layout using Scaffold. It includes a white background
/// and a body that consists of various widgets for the login form. The form includes text fields for entering
/// the user's email and password, along with a login button. There is also an option to navigate to the sign-up
/// page for creating a new account. The UI elements are organized in a column layout and styled using appropriate
/// padding, spacing, and font styles.

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                        'Welcome back! Sign in using your email to continue with us 🥰',
                    family: 'Circular Std',
                    color: Color.fromARGB(255, 121, 124, 123),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
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
                  SizedBox(
                    height: 80,
                  ),
                  MyButton(),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: TextWidget(
                      text: "Don't have Account? Create Account",
                      family: 'Circular Std',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
