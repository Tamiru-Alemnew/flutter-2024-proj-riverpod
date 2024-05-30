import 'package:flutter/material.dart';
import 'package:family_cash_manager/presentation/widgets/styling/colors.dart';
import 'package:family_cash_manager/presentation/widgets/styling/paddings_and_margins.dart';
import 'package:family_cash_manager/presentation/widgets/styling/typography.dart';
import 'package:family_cash_manager/presentation/widgets/custom/signup_textfeilds.dart';


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
          body:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomPaddings.mediumPadding),
                    alignment: Alignment.center,
                    child: Text(
                      "Please fill the form below to create an account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: CustomTypography.smallFontSize,
                        color: const Color.fromARGB(255, 29, 25, 25),
                      ),
                    ),
                  ),
                  Expanded(child: SignUpTextFields()),

                ],
            ),
        ));
  }
}

