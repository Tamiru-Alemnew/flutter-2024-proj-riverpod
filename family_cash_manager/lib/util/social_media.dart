import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 24,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/facebook.png',
                height: 48,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 24,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 23,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/google.png',
                height: 48,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 24,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 23,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/apple.png',
                height: 48,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
