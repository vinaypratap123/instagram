import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';



////////////////
class UiHelper {



  // ****************************** FLUSH BAR() FUNCTION  ******************************
  static void flushBarMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 2),
          borderRadius: BorderRadius.circular(20),
          positionOffset: 10,
          icon: const Icon(
            Icons.check_circle_outline,
            color: AppColor.mobileBackgroundColor,
          ),
          message: message,
          backgroundColor: Colors.green,
        )..show(context));
  }

  // ****************************** FLUSH BAR() FUNCTION  ******************************
  static void flushBarErrorMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 2),
          borderRadius: BorderRadius.circular(20),
          positionOffset: 10,
          icon: const Icon(
            Icons.error,
            color: AppColor.mobileBackgroundColor,
          ),
          message: message,
          backgroundColor: Colors.red,
        )..show(context));
  }
  //  ****************************** TOAST MESSAGE() FUNCTION ******************************
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG);
  }

  // ****************************** SHOW SNACKBAR() FUNCTION  ******************************
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: Colors.red.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // ****************************** SHOW LOADING DIALOG() FUNCTION  ******************************
  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 30,
          ),
          Text(title)
        ],
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loadingDialog;
        });
  }

  //  ****************************** SHOW PROGRESS BAR() FUNCTION  ******************************
  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  //  ****************************** SHOW ALERT DIALOG() FUNCTION  ******************************
  static void showAlertDialog(
      BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      elevation: 25,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(AppString.ok))
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
