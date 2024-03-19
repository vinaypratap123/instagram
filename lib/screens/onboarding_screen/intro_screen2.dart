import 'package:flutter/material.dart';
import 'package:instagram/utils/app_image.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppImage.header),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Image.asset(
             AppImage.intro2,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Image.asset(AppImage.footer)
        ],
      ),
    );
  }
}
