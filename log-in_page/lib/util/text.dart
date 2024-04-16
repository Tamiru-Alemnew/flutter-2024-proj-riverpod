import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign align;
  final String family;

  const TextWidget(
      {super.key,
      required this.text,
      this.size = 14,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.align = TextAlign.center,
      this.family = 'Caros'});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        fontFamily: family,
      ),
      textAlign: align,
    );
  }
}
