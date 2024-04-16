import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup/styling/colors.dart';
import 'package:signup/styling/heights_and_widths.dart';
import 'package:signup/styling/paddings_and_margins.dart';
import 'package:signup/styling/typography.dart';

class SignUpTextFeilds extends StatelessWidget {
  const SignUpTextFeilds({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: CustomPaddings.mediumPadding,
          bottom: CustomPaddings.mediumPadding,
          left: CustomPaddings.smallPadding,
          right: CustomPaddings.smallPadding),
      child:  Expanded(
        child: ListView(
          children: const [
            // Email textfield
             CustomTextFeild(label: 'Your name'),
             CustomTextFeild(label: 'Your email'),
             CustomTextFeild(label: 'Password'),
             CustomTextFeild(label: 'Confirm password'),
          ],
        ),
      ),
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  final String label;
  const CustomTextFeild({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: CustomMargins.mediumMargin),
      height: TextFeildHeight.large,
      child: TextField(
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.only(top: CustomPaddings.largePadding),
          // TO DO: adding a padding between the label text and the bottom border
          // constraints: BoxConstraints(maxHeight: TextFeildHeight.large),
          labelText: label,
          labelStyle: TextStyle(
              color: primaryColor,
              fontSize: CustomTypography.smallFontSize,
              fontFamily: CustomTypography.primaryFontFamily),

          disabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                  color: subtitleColor, width: BorderThickness.thick)),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(color: primaryColor, width: BorderThickness.thick),
          ),
        ),
      ),
    );
  }
}