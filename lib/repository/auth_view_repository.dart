import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// **************************** LOGIN API *******************************
  Future<dynamic> loginApi(dynamic data,) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
       
      return response;
    } catch (error) {
     
      UiHelper.toastMessage(error.toString());
    }
  }

// **************************** NEW PASSWORD API *******************************
  Future<dynamic> newPasswordApi(dynamic data, String token) async {
    try {
      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      dynamic response = await NetworkApiServices()
          .getPostApiResponseWithHeaderFotUpadtePassword(
              AppUrl.newPasswordEndPoint, data, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

// **************************** SIGNUP API *******************************
  Future<dynamic> registerApi(
    dynamic data,
  ) async {
    try {
      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Basic YWRtaW46YWRtaW4="
      };
    
      dynamic response = await NetworkApiServices()
          .getPostApiResponseWithHeaderForSignup(AppUrl.registerEndPoint, data, header);

    
      return response;
    } catch (error) {
     
      UiHelper.toastMessage(error.toString());
    }
  }

// **************************** VERIFY OTP API *******************************
  Future<dynamic> verifyOtpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.verifyOtp, data);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

// **************************** VERIFY OTP FORGOT PASSWORD API *******************************
  Future<dynamic> verifyOtpForgotPasswordApi(Map data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.verifyForgotPasswordOtp, data);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

// **************************** FORGOT PASSWORD API *******************************
  Future<dynamic> forgotPasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.forgotPasswordEndPoint, data);

      return response;
    } catch (error) {
      UiHelper.toastMessage("${error.toString()}\nPlease Request After 2 minutes");
    }
  }
}
