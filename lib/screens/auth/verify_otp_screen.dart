import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String userEmail;
  const VerifyOtpScreen({super.key, required this.userEmail});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  // ************************* CONTROLLERS **************************
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  // ************************* DISPOSE METHOD **************************
  @override
  void dispose() {
    super.dispose();
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
// ******************************** APP BAR **********************************
      appBar: AppBar(
        title: const Text(AppString.verifyOtp),
      ),
      body: Column(
        children: [
// ******************************** OTP GIF **********************************
          SizedBox(
            width: double.infinity,
            child: Image.asset(
             AppImage.otp,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: Form(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
// ******************************** OTP1 TEXT FIELD FORM **********************************
                SizedBox(
                  height: 54,
                  width: 54,
                  child: TextFormField(
                    controller: otp1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.primaryColor)),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
// ******************************** OTP2 TEXT FIELD FORM **********************************
                SizedBox(
                  height: 54,
                  width: 54,
                  child: TextFormField(
                    controller: otp2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.primaryColor)),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
// ******************************** OTP3 TEXT FIELD FORM **********************************
                SizedBox(
                  height: 54,
                  width: 54,
                  child: TextFormField(
                    controller: otp3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.primaryColor)),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
// ******************************** OTP4 TEXT FIELD FORM **********************************
                SizedBox(
                  height: 54,
                  width: 54,
                  child: TextFormField(
                    controller: otp4,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColor.primaryColor)),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            )),
          ),
          const SizedBox(
            height: 30,
          ),
// ******************************** VERIFY OTP BUTTON **********************************
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: RectangleButton(
                btnName: AppString.verifyOtp,
                loading: authViewModel.verifyOtpLoading,
                btnCallBack: () {
                  if (otp1.text.isEmpty ||
                      otp2.text.isEmpty ||
                      otp3.text.isEmpty ||
                      otp4.text.isEmpty) {
                    UiHelper.showSnackBar(context, "Please Enter the Otp");
                  } else {
                    String finalOtp = otp1.text.toString() +
                        otp2.text.toString() +
                        otp3.text.toString() +
                        otp4.text.toString();

                    authViewModel.verifyOtp(
                        finalOtp, widget.userEmail, context);
                  }
                }),
          )
        ],
      ),
    );
  }
}
