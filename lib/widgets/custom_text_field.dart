import 'package:flutter/material.dart';
import 'package:instagram/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
// ******************** VARIABLES *********************
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final FocusNode? focusNode;
  final FocusNode? targetFocusNode;
// ******************** CUSTOM TEXT FIELD CONSTRUCTOR *********************
  const CustomTextField(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.isObscureText,
      required this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.targetFocusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(targetFocusNode);
        },
        style: const TextStyle(color: AppColor.primaryColor),
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isObscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColor.primaryColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColor.blackColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColor.primaryColor)),
        ),
      ),
    );
  }
}
