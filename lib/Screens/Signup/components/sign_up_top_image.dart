import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Salut! Remplissez le formulaire".toUpperCase(),
           style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0, // Adjust the font size as needed
          ),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SizedBox(
                height: 200, // Match the old height
                width: 214, // Match the old width
                child: Image.asset("../../../assets/images/marathon.jpg"),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
