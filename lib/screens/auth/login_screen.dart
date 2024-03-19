import 'package:flutter/material.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:instagram/widgets/custom_text_field.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// ****************************** CONTROLLERS **********************************
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// ****************************** FOCUS NODES **********************************
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
// ****************************** SCAFFOLD **********************************
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
// ****************************** HEADER IMAGE **********************************
            Image.asset(AppImage.header),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
// ****************************** EMAIL TEXT FIELD **********************************
                  CustomTextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      targetFocusNode: _passwordFocusNode,
                      labelText: AppString.usernameOrEmail,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: AppColor.blueColor,
                      )),
// ****************************** FORGOT PASSWORD BUTTON **********************************

                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgotPassword);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppString.forgotPassword,
                            style: AppStyle.textButtonStyle,
                          ),
                        ],
                      )),

                  const SizedBox(
                    height: 25,
                  ),
                  // ****************************** PASSWORD TEXT FIELD **********************************
                  CustomTextField(
                      isObscureText: true,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      labelText: AppString.password,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColor.blueColor,
                      )),
                  const SizedBox(
                    height: 25,
                  ),
// ****************************** LOGIN BUTTON **********************************
                  RectangleButton(
                      loading: authViewModel.loginLoading,
                      btnName: AppString.login,
                      btnCallBack: () {
                      
                        authViewModel.checkLoginValues(
                            context, _emailController, _passwordController);
                        
                      }),
                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width * .4,
                        color: AppColor.primaryBlackColor,
                      ),
                      const Text(
                        AppString.or,
                        style: AppStyle.regularTextStyle,
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width * .4,
                        color: AppColor.primaryBlackColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppString.donNotHaveAccount),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.signup);
                          },
                          child: const Text(AppString.signUp,
                              style: TextStyle(color: AppColor.blueColor))),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
// ****************************** FOOTER IMAGE **********************************
            Image.asset(AppImage.footer),
          ],
        ),
      )),
    );
  }
}
