import 'package:flutter/material.dart';
import 'package:instagram/provider/check_last_screen.dart';
import 'package:instagram/screens/onboarding_screen/intro_screen1.dart';
import 'package:instagram/screens/onboarding_screen/intro_screen2.dart';
import 'package:instagram/screens/onboarding_screen/intro_screen3.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastScreenProvider = Provider.of<CheckLastScreenProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              isLastScreenProvider.setLastScreen(index == 2);
            },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.login,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      AppString.skip,
                      style: AppStyle.headerTextStyle,
                    )),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                Consumer<CheckLastScreenProvider>(
                    builder: (context, value, child) {
                  return value.isLastScreen
                      ? InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.login,
                              (route) => false,
                            );
                          },
                          child: const Text(
                            AppString.done,
                            style: AppStyle.headerTextStyle,
                          ))
                      : InkWell(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(microseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            AppString.next,
                            style: AppStyle.headerTextStyle,
                          ));
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
