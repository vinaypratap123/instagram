import 'package:flutter/material.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/widgets/custom_text_field.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String token;
  const CreateNewPasswordScreen({super.key, required this.token});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  // ******************************** CONTROLLER *********************************
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // ******************************** FOCUS NODE *********************************
  final FocusNode _passwordFieldFocusNode = FocusNode();
  final FocusNode _confirmPasswordFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.newPassword),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
// ******************************** PASSWORD GIF *********************************
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                 AppImage.password,
                  fit: BoxFit.cover,
                ),
              ),
//******************************** PASSWORD TEXT FIELD ********************************

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: CustomTextField(
                  focusNode: _passwordFieldFocusNode,
                  targetFocusNode: _confirmPasswordFieldFocusNode,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColor.primaryBlackColor,
                  ),
                  controller: _passwordController,
                  labelText: AppString.newPassword,
                  isObscureText: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
// ******************************** CONFIRM PASSWORD TEXT FIELD  ********************************

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: CustomTextField(
                  focusNode: _confirmPasswordFieldFocusNode,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColor.primaryBlackColor,
                  ),
                  controller: _confirmPasswordController,
                  labelText: AppString.confirmPassword,
                  isObscureText: true,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

//******************************** NEW PASSWORD BUTTON ********************************
              RectangleButton(
                  btnName: AppString.submit,
                  loading: authViewModel.newPasswordLoading,
                  btnCallBack: () {
                    authViewModel.checkNewPassword(
                      context,
                      widget.token,
                      _passwordController,
                      _confirmPasswordController,
                    );
                  })
            ],
          ),
        ));
  }
}
