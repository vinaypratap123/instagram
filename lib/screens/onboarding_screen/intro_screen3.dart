import 'package:flutter/material.dart';
import 'package:instagram/utils/app_image.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppImage.header),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              AppImage.intro3,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Image.asset(AppImage.footer)
        ],
      ),
    );
  }
}
