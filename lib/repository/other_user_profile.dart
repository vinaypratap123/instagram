import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/other_user_followers_model.dart';
import 'package:instagram/model/other_user_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherUserProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// **************************** GET OTHER USER PROFILE API *******************************
  Future<OtherUserProfileModel> getOtherUserProfileApi(String userId) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.userProfileEndPoint}?profileId=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);
      return response = OtherUserProfileModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// **************************** GET OTHER USER FOLLOWERS API *******************************
  Future<OtherUserFollowersModel> getOtherUserFollowersListApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.followersEndPoint, header);

      return response = OtherUserFollowersModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }
}
