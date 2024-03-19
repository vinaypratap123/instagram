import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram/provider/splash_view_provider.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices sp = SplashServices();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      sp.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(AppString.appName, style: AppStyle.appNameStyle),
            const SizedBox(height: 16),
            Image.asset(
              AppImage.intro3,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            const SizedBox(height: 16),
            const Text(AppString.madeInIndia, style: AppStyle.appNameStyle),
          ],
        ),
      ),
    );
  }
}
