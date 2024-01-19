import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Re-Bonjour dans votre Application",
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
                height: 303,
                width: 330, 
              child: Image.asset("../../../assets/images/marathon.jpg"),
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
