import 'package:flutter/foundation.dart';
import 'package:instagram/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("statusCode", user.statusCode.toString());
    sharedPreferences.setString("type", user.type.toString());
    sharedPreferences.setString("token", user.data.token);

    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? statusCode = sharedPreferences.getString("statusCode");
    final String? type = sharedPreferences.getString("type");
    final String? token = sharedPreferences.getString("token");

    return UserModel(
      statusCode: statusCode.toString(),
      type: type.toString(),
      data: Data(userId: "", token: token ?? ""),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.remove("token");

    return true;
  }
}
