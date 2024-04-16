import 'package:flutter/material.dart';
import 'package:signup/styling/colors.dart';
import 'package:signup/styling/heights_and_widths.dart';
import 'package:signup/styling/paddings_and_margins.dart';
import 'package:signup/styling/typography.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: CustomMargins.mediumMargin),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(ButtonWidth.elevatedButtonMinWidth,
                ButtonHeight.elevatedButtonHeight),
            // fixedSize: MaterialStateProperty.all(

            //     Size.fromHeight(ButtonHeight.elevatedButtonHeight)),
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
