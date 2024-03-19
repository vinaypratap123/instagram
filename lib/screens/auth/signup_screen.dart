import 'package:flutter/material.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/widgets/custom_text_field.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
// ***************************** CONTROLLERS ****************************
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

// ***************************** FOCUS NODES ****************************
  final FocusNode _nameFieldFocusNode = FocusNode();
  final FocusNode _userNameFieldFocusNode = FocusNode();
  final FocusNode _emailFieldFocusNode = FocusNode();
  final FocusNode _passwordFieldFocusNode = FocusNode();
  final FocusNode _confirmPasswordFieldFocusNode = FocusNode();

// ================================= BUILD() FUNCTION ====================================
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
// ================================= HEADER IMAGE ====================================
            Image.asset("assets/images/header.png"),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),

// ================================= FULL NAME TEXT FIELD  ====================================

                  CustomTextField(
                      focusNode: _nameFieldFocusNode,
                      targetFocusNode: _userNameFieldFocusNode,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColor.blueColor,
                      ),
                      controller: _fullNameController,
                      labelText: AppString.fullName),

                  const SizedBox(
                    height: 10,
                  ),
// ================================= USER NAME TEXT FIELD  ====================================

                  CustomTextField(
                      focusNode: _userNameFieldFocusNode,
                      targetFocusNode: _emailFieldFocusNode,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColor.blueColor,
                      ),
                      controller: _userNameController,
                      labelText: AppString.userName),

                  const SizedBox(
                    height: 10,
                  ),
// ================================= EMAIL TEXT FIELD  ====================================

                  CustomTextField(
                      focusNode: _emailFieldFocusNode,
                      targetFocusNode: _passwordFieldFocusNode,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: AppColor.blueColor,
                      ),
                      controller: _emailController,
                      labelText: AppString.email),

                  const SizedBox(
                    height: 10,
                  ),
// ================================= PASSWORD TEXT FIELD  ====================================

                  CustomTextField(
                    focusNode: _passwordFieldFocusNode,
                    targetFocusNode: _confirmPasswordFieldFocusNode,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColor.blueColor,
                    ),
                    controller: _passwordController,
                    labelText: AppString.password,
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
// ================================= CONFIRM PASSWORD TEXT FIELD  ====================================

                  CustomTextField(
                    focusNode: _confirmPasswordFieldFocusNode,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColor.blueColor,
                    ),
                    controller: _confirmPasswordController,
                    labelText: AppString.confirmPassword,
                    isObscureText: true,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

// ================================= SIGNUP BUTTON ====================================
                  RectangleButton(
                      loading: authViewModel.signupLoading,
                      btnName: AppString.signUp,
                      btnCallBack: () {
                        authViewModel.checkValues(
                            context,
                            _fullNameController,
                            _userNameController,
                            _emailController,
                            _passwordController,
                            _confirmPasswordController);
                      }
                      ),
                  const SizedBox(
                    height: 10,
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppString.alreadyHaveAnAccount),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                           AppString.login,
                            style: TextStyle(color: AppColor.blueColor),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
// ================================= FOOTER IMAGE ====================================
            Image.asset("assets/images/footer.png"),
          ],
        ),
      )),
    );
  }
}
