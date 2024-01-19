import 'package:flutter/material.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Re-Bonjour dans votre Application ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0, // Adjust the font size as needed
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SizedBox(
                height: 419,
                width: 367,
                child: Image.asset(
                  "../../../assets/images/logo7.jpg", // Replace with your image path
                  fit: BoxFit.cover, // Adjust the BoxFit based on your needs
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
