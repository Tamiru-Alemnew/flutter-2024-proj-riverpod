import 'package:family_cash_manager/Pages/home_page.dart';
import 'package:flutter/material.dart';
import '../styling/colors.dart';
import '../styling/heights_and_widths.dart';
import '../styling/paddings_and_margins.dart';
import '../styling/typography.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: CustomMargins.mediumMargin),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              )
            );
           
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(ButtonWidth.elevatedButtonMinWidth,
                ButtonHeight.elevatedButtonHeight),
            backgroundColor: primaryColor,
          ),
          child: Text(
            "Create an account",
            style: TextStyle(
              color: whiteTextColor,
              fontFamily: CustomTypography.primaryFontFamily,
              fontSize: CustomTypography.largeFontSize,
              fontWeight: CustomTypography().light,
            ),
          ),
        ));
  }
}
