import 'package:flutter/material.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/widgets/custom_text_field.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
// ************************** CONTROLLER *********************************
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
// ************************** APP BAR *********************************
      appBar: AppBar(
        title: const Text(AppString.forgotPassword),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
// ************************** EMAIL GIF *********************************
            SizedBox(
              width: double.infinity,
              child: Image.asset(
               AppImage.password,
                fit: BoxFit.cover,
              ),
            ),
// ************************** EMAIL TEXT FIELD *********************************
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: CustomTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  labelText: AppString.email,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColor.primaryBlackColor,
                  )),
            ),

// ************************** REQUEST OTP BUTTON *********************************
            RectangleButton(
                btnName: AppString.requestOtp,
                loading: authViewModel.forgotPasswordLoading,
                btnCallBack: () {
                  authViewModel.checkEmail(context, _emailController);
                }),
          ],
        ),
      ),
    );
  }
}
