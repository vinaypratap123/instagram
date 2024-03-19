import 'package:flutter/material.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_style.dart';

class RectangleButton extends StatelessWidget {
// ******************** VARIABLES *********************
  final String btnName;
  final Icon? btnIcon;
  final bool loading;
  final Color? btnColor;
  final TextStyle? btnStyle;
  final VoidCallback btnCallBack;
// ******************** RECTANGLE BUTTON CONSTRUCTOR *********************
  const RectangleButton({
    Key? key,
    required this.btnName,
    this.btnIcon,
    this.btnColor,
    this.btnStyle,
    required this.btnCallBack,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          btnCallBack();
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.blueColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: AppColor.mobileBackgroundColor,
                  )
                : btnIcon != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btnIcon!, Text(btnName)],
                      )
                    : Text(
                        btnName,
                        style: AppStyle.buttonTextStyle,
                      ),
          ),
        ),
      ),
    );
  }
}
