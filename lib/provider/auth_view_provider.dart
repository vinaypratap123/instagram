import 'package:flutter/material.dart';
import 'package:instagram/repository/auth_view_repository.dart';
import 'package:instagram/screens/auth/create_new_password_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  bool _forgotPasswordLoading = false;
  bool get forgotPasswordLoading => _forgotPasswordLoading;

  bool _verifyOtpLoading = false;
  bool get verifyOtpLoading => _verifyOtpLoading;

  bool _newPasswordLoading = false;
  bool get newPasswordLoading => _newPasswordLoading;

  bool _otpLoading = false;
  bool _signupLoading = false;

  bool get signupLoading => _signupLoading;
  bool get otpLoading => _otpLoading;

  // ************************* SET LOGIN LOADING FUNCTION ************************
  void setLoginLoading(value) {
    _loginLoading = value;
    notifyListeners();
  }

  // ************************* SET FORGOT PASSWORD LOADING FUNCTION ************************
  void setForgotPasswordLoading(value) {
    _forgotPasswordLoading = value;
    notifyListeners();
  }

  // ************************* SET VERIFY OTP LOADING FUNCTION ************************
  void setVerifyOtpLoading(value) {
    _verifyOtpLoading = value;
    notifyListeners();
  }

  // ************************* SET NEW PASSWORD LOADING FUNCTION ************************
  void setNewPasswordLoading(value) {
    _newPasswordLoading = value;
    notifyListeners();
  }

  // ************************* SET SIGNUP LOADING FUNCTION ************************
  void setSignupLoading(value) {
    _signupLoading = value;
    notifyListeners();
  }

  // ************************* OTP LOADING FUNCTION ************************
  void setOtpLoading(value) {
    _otpLoading = value;
    notifyListeners();
  }

  // ************************* LOGIN API ************************
  Future<void> loginApi(dynamic loginCredential, BuildContext context) async {
    setLoginLoading(true);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    _myRepo.loginApi(loginCredential).then((value) {
      setLoginLoading(false);

      String statusCode = value["statusCode"].toString();
      String token = value["data"]["token"].toString();
      String userId = value["data"]["userId"].toString();
      String userName = value["data"]["user"]["userName"].toString();

      sharedPreferences.setString("token", token);
      sharedPreferences.setString("userId", userId);
      sharedPreferences.setString("userName", userName);
      sharedPreferences.setString("profilePic", "");
      if (statusCode == "200") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavbar,
          (route) => false,
        );
        UiHelper.flushBarMessage(context, "Login SuccessFully");
      }
    }).onError((error, stackTrace) {
      setLoginLoading(false);

      UiHelper.toastMessage(error.toString());
    });
  }

// ************************* CHECK VALUE FOR LOGIN CREDENTIAL ******************************

  void checkLoginValues(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if (email == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Email");
      // UiHelper.toastMessage("Required Field, Please Enter The Email");
    } else if (password == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Password");
      // UiHelper.toastMessage("Required Field, Please Enter The Password");
    } else if (!isEmailValid(email)) {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Correct Email");
      // UiHelper.toastMessage("Please Enter The Correct Email");
    } else if (!isStrongPassword(password)) {
      UiHelper.flushBarErrorMessage(
          context, "Please Enter The Correct Password");
      // UiHelper.toastMessage("Please Enter The Correct Password");
    } else {
      Map loginCredential = {
        "email": emailController.text.toString(),
        "password": passwordController.text.toString()
      };

      loginApi(loginCredential, context);
    }
  }

  // ************************* SIGNUP API ************************
  Future<void> signupApi(
      dynamic signUpCredential, String email, BuildContext context) async {
    setSignupLoading(true);
   
    _myRepo.registerApi(signUpCredential).then((value) {
      
      setSignupLoading(false);
      String statusCode = value["statusCode"].toString();
      if (statusCode == "200") {
        Navigator.pushNamed(context, RoutesName.verifyOtp, arguments: email);
        UiHelper.flushBarMessage(context,
            "Four digit otp has been send to your email, please check");
      }
    }).onError((error, stackTrace) {
     
      setSignupLoading(false);
      UiHelper.toastMessage(error.toString());
    });
  }

// ************************* CHECKVALUE FUNCTION FOR SIGNUP API ******************************
  void checkValues(
      BuildContext context,
      TextEditingController fullNameController,
      TextEditingController userNameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    String email = emailController.text.toString().trim();
    String name = fullNameController.text.toString().trim();
    String userName = userNameController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String confirmPassword = confirmPasswordController.text.toString().trim();
    if (name == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Name");

      // UiHelper.toastMessage("Required Field, Please Enter The Name");
    } else if (name.length < 2) {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Valid Name");
      // UiHelper.toastMessage("Please Enter The Valid Name");
    } else if (userName == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The UserName");
      // UiHelper.toastMessage("Required Field, Please Enter The UserName");
    } else if (userName.length < 2) {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Valid UserName");
      // UiHelper.toastMessage("Please Enter The Valid UserName");
    } else if (email == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Email");
      // UiHelper.toastMessage("Required Field, Please Enter The Email");
    } else if (!isEmailValid(email)) {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Correct Email");
      // UiHelper.toastMessage("Please Enter The Correct Email");
    } else if (password == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Password");
      // UiHelper.toastMessage("Required Field, Please Enter The Password");
    } else if (confirmPassword == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Confirm Password");
      // UiHelper.toastMessage(
      //     "Required Field, Please Enter The Confirm Password");
    } else if (!isStrongPassword(password)) {
      UiHelper.showAlertDialog(context, "Please Follow The Password Rule",
          "1 - At least one Upper Case letter.\n2 - At least one lower case letter.\n3 - At least one digit.\n4 - At least one special character.\n5 - Password should be at least 8 character long.");
    } else if (password != confirmPassword) {
      UiHelper.toastMessage("Password and Confirm Password Miss Match");
    } else {
      Map signUpCredential = {
        "name": fullNameController.text.toString(),
        "userName": userNameController.text.toString(),
        "email": emailController.text.toString(),
        "password": passwordController.text.toString()
      };
   
      signupApi(signUpCredential, email, context);
     
    }
  }

  // ************************* VERIFY OTP FOR SIGN UP ******************************
  void verifyOtp(String otp, String email, BuildContext context) {
    Map otpCredential = {"email": email, "otp": otp};

    verifyOtpApi(otpCredential, context);
  }

  // ************************* VERIFY OTP API FOR SIGNUP ************************
  Future<void> verifyOtpApi(dynamic otpCredential, BuildContext context) async {
    setVerifyOtpLoading(true);
    _myRepo.verifyOtpApi(otpCredential).then((value) {
      setVerifyOtpLoading(false);
      if (value["statusCode"].toString() == 200.toString()) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
      }
      UiHelper.flushBarMessage(context, "OTP Has Been Verify Successfully");
    }).onError((error, stackTrace) {
      setVerifyOtpLoading(false);
      UiHelper.toastMessage(error.toString());
    });
  }

  // ************************* FORGOT PASSWORD API ************************
  Future<void> forgotPasswordApi(
      dynamic credential, String email, BuildContext context) async {
    setForgotPasswordLoading(true);
    _myRepo.forgotPasswordApi(credential).then((value) {
      setForgotPasswordLoading(false);
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        Navigator.pushNamed(context, RoutesName.forgotPasswordOtp,
            arguments: email);
        UiHelper.flushBarMessage(context,
            "Four digit otp has been send to your email, please check");
      }
    }).onError((error, stackTrace) {
      setForgotPasswordLoading(false);
      UiHelper.toastMessage("$error.toString()");
    });
  }

  // ************************* CHECK EMAIL FOR FORGOT PASSWORD ******************************
  void checkEmail(
    BuildContext context,
    TextEditingController emailController,
  ) {
    String email = emailController.text.toString().trim();
    if (email == "") {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Email");
      // UiHelper.toastMessage("Please Enter The Email");
    } else if (!isEmailValid(email)) {
      UiHelper.flushBarErrorMessage(context, "Please Enter The Correct Email");
      // UiHelper.toastMessage("Please Enter The Correct Email");
    } else {
      Map emailCredential = {
        "email": emailController.text.toString(),
      };

      forgotPasswordApi(emailCredential, email, context);
    }
  }

  // ************************* VERIFY OTP FORGOT PASSWORD API FOR FORGOT PASSWORD ************************
  Future<void> verifyOtpForgotPasswordApi(
      Map otpCredential, BuildContext context) async {
    setVerifyOtpLoading(true);
    _myRepo.verifyOtpForgotPasswordApi(otpCredential).then((value) {
      setVerifyOtpLoading(false);
      String token = value["data"].toString();

      if (value["statusCode"].toString() == 200.toString()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateNewPasswordScreen(
                      token: token,
                    )));

        UiHelper.flushBarMessage(context, "OTP Has Been Verify Successfully");
      }
    }).onError((error, stackTrace) {
      setVerifyOtpLoading(false);
      UiHelper.toastMessage(error.toString());
    });
  }

  // ************************* NEW PASSWORD API ************************
  Future<void> newPasswordApi(
      dynamic credential, String token, BuildContext context) async {
    setNewPasswordLoading(true);
    _myRepo.newPasswordApi(credential, token).then((value) {
      setNewPasswordLoading(false);
      String statusCode = value["statusCode"].toString();
      if (statusCode == "200") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        UiHelper.flushBarMessage(context, "Password Reset Successfully");
      }
    }).onError((error, stackTrace) {
      setNewPasswordLoading(false);
      UiHelper.toastMessage(error.toString());
    });
  }

  // ************************* CHECK NEW PASSWORD CREDENTIAL ******************************
  void checkNewPassword(
    BuildContext context,
    String token,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) {
    String password = passwordController.text.toString().trim();
    String confirmPassword = confirmPasswordController.text.toString().trim();
    if (password == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Password");
      // UiHelper.toastMessage("Required Field, Please Enter The Password");
    }
    if (confirmPassword == "") {
      UiHelper.flushBarErrorMessage(
          context, "Required Field, Please Enter The Password");
      // UiHelper.toastMessage("Required Field, Please Enter The Password");
    }
    if (password != confirmPassword) {
      UiHelper.flushBarErrorMessage(context,
          "Password and  Confirm Password Miss Match, Please Enter The Same Password");
      // UiHelper.toastMessage(
      //     "Password and  Confirm Password Miss Match, Please Enter The Same Password");
    } else {
      Map passwordCredential = {
        "newPassword": password,
      };

      newPasswordApi(passwordCredential, token, context);
    }
  }

  // ************************* FORGOT PASSWORD OTP FOR FORGOT PASSWORD API ************************
  void forgotPasswordOtp(String otp, String email, BuildContext context) {
    Map otpCredential = {"email": email, "OTP": otp};

    verifyOtpForgotPasswordApi(otpCredential, context);
  }

  // ************************* EMAIL VALIDATION FUNCTION ************************
  bool isEmailValid(String email) {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
        caseSensitive: false);

    return emailRegExp.hasMatch(email);
  }

  // ************************* PASSWORD VALIDATION FUNCTION ************************
  static bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[!@#\$%^&*]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    return true;
  }
}
