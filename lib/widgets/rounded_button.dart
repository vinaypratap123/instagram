import 'package:flutter/material.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_style.dart';

class RoundedButton extends StatelessWidget {
// ******************** VARIABLES *********************
  final String btnName;
  final Icon? btnIcon;
  final Color? btnColor;
  final bool loading;
  final TextStyle? btnStyle;
  final VoidCallback btnCallBack;

// ******************** ROUNDED BUTTON CONSTRUCTOR  *********************
  const RoundedButton({
    Key? key,
    required this.btnName,
    this.btnIcon,
    this.btnColor,
    this.loading = false,
    this.btnStyle,
    required this.btnCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.07,
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
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColor.mobileBackgroundColor,
                    ),
                  )
                : btnIcon != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btnIcon!, Text(btnName)],
                      )
                    : Text(
                        btnName,
                        style: AppStyle.regularTextStyles,
                      ),
          ),
        ),
      ),
    );
  }
}
