import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/all_user_model.dart';
import 'package:instagram/model/followers_model.dart';
import 'package:instagram/model/following_model.dart';
import 'package:instagram/model/user_profile_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// **************************** GET USER PROFILE API *******************************
  Future<UserProfileModel> getUserProfileApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");
      final String? userId = sharedPreferences.getString("userId");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.userProfileEndPoint}?profileId=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);
      return response = UserProfileModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// **************************** EDIT PROFILE API *******************************
  Future<dynamic> editProfileApi(dynamic data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response = await NetworkApiServices()
          .getPostApiResponseEditProfile(
              AppUrl.editProfileEndPoint, data, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(
          "****** this is postApi inner ${error.toString()}*****");
    }
  }

// **************************** GET FOLLOWERS LIST API *******************************
  Future<FollowersModel> getFollowersListApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");
      final String? userId = sharedPreferences.getString("userId");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.followersEndPoint}?userId=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);
      return response = FollowersModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// **************************** GET OTHER USER FOLLOWERS LIST API *******************************
  Future<FollowersModel> getOtherUserFollowersListApi(String userId) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.followersEndPoint}?userId=$userId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);

      return response = FollowersModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// // **************************** GET FOLLOWING LIST API *******************************
  Future<FollowingModel> getFollowingListApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");
      final String? userId = sharedPreferences.getString("userId");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.followingEndPoint}?userId=$userId";

      dynamic response = await _apiServices.getGetApiResponse(url, header);

      return response = FollowingModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// **************************** GET OTHER USER FOLLOWING LIST API *******************************
  Future<FollowingModel> getOtherUserFollowingListApi(String userId) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.followingEndPoint}?userId=$userId";

      dynamic response = await _apiServices.getGetApiResponse(url, header);

      return response = FollowingModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

// // **************************** GET ALL USER API *******************************
  Future<AllUserModel> getAllUserApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getAllUserEndPoint, header);

      return response = AllUserModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

  // **************************** FOLLOW API *******************************
  Future<dynamic> followApi(
    String userId,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.followUserEndPoint}?followingId=$userId";
      dynamic response =
          await NetworkApiServices().getPostApiResponseHeader(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** UN FOLLOW API *******************************
  Future<dynamic> unFollowApi(
    String userId,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.unFollowUserEndPoint}?followingId=$userId";

      dynamic response = await NetworkApiServices().getDeleteApi(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** DELETE POST API *******************************
  Future<dynamic> deleteApi(
    String postId,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.deletePostEndPoint}?postId=$postId";

      dynamic response = await NetworkApiServices().getDeleteApi(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }
}
