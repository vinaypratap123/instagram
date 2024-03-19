import 'package:flutter/material.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/provider/user_view_provider.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/routes/routes_name.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      if (value.data.token == "null" || value.data.token == "") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.tutorialScreen,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavbar,
          (route) => false,
        );
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
