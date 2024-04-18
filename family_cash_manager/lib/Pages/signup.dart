import 'package:flutter/material.dart';
import 'package:family_cash_manager/styling/colors.dart';
import 'package:family_cash_manager/styling/paddings_and_margins.dart';
import 'package:family_cash_manager/styling/typography.dart';
import 'package:family_cash_manager/widgets/create_account_button.dart';
import 'package:family_cash_manager/widgets/signup_textfeilds.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: signUpBackgroundColor,
          appBar: AppBar(
            title: Text(
              "Signup",
              style: TextStyle(
                color: headerColor,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(CustomPaddings.mediumPadding),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // header
                  Container(
                    padding: const EdgeInsets.all(CustomPaddings.mediumPadding),
                    alignment: Alignment.center,
                    child: Text(
                      "SignUp with Email",
                      style: TextStyle(
                        fontSize: CustomTypography.largeFontSize,
                        fontWeight: CustomTypography().medium,
                      ),
                    ),
                  ),

                  // Sub header text

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomPaddings.mediumPadding),
                    alignment: Alignment.center,
                    child: Text(
                      "Get chatting with friends and family today by signing up for our neo-chat app!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: CustomTypography.smallFontSize,
                        color: subtitleColor,
                      ),
                    ),
                  ),

                  Expanded(child: SignUpTextFeilds()),
                  CreateAccountButton()
                ],
              ),
            ),
          ),
        ));
  }
}
