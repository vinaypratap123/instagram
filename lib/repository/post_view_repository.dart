import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/comment_model.dart';
import 'package:instagram/model/like_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  // **************************** POST API *******************************
  Future<dynamic> postApi(dynamic data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response = await NetworkApiServices()
          .getPostApiResponseWithHeader(AppUrl.postEndPoint, data, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** REPORT POST API *******************************
  Future<dynamic> reportPostApi(String postId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.reportPostEndPoint}?postId=$postId";
      dynamic response =
          await NetworkApiServices().getPostApiResponseWithoutData(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** LIKE POST API *******************************
  Future<dynamic> likePostApi(
    String postId,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.likePostEndPoint}?postId=$postId";
      dynamic response =
          await NetworkApiServices().getPostApiResponseWithoutData(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** EDIT POST API *******************************
  Future<dynamic> editPostApi(String postId, String caption) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.editPostEndPoint}?postId=$postId";
      dynamic response = await NetworkApiServices()
          .getPostApiResponseEditPost(url, caption, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** EDIT Comment API *******************************
  Future<dynamic> editCommentApi(String commentId, String comment) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.commentEndPoint}?commentId=$commentId";
      dynamic response = await NetworkApiServices()
          .getPostApiResponseEditComment(url, comment, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** COMMENT API *******************************
  Future<dynamic> commentApi(String postId, String data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.commentEndPoint}?postId=$postId";
      dynamic response = await NetworkApiServices()
          .getPostApiResponseComment(url, data, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // *************************** DELETE COMMENT API *******************************
  Future<dynamic> deleteCommentApi(
    String commentId,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.commentEndPoint}?commentId=$commentId";

      dynamic response = await NetworkApiServices().getDeleteApi(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** UNLIKE POST API *******************************
  Future<dynamic> unlikePostApi(String postId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.likePostEndPoint}?postId=$postId";
      dynamic response = await NetworkApiServices().getDeleteApi(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // / **************************** GET LIKE LIST API *******************************
  Future<LikeModel> getLikeListApi(String postId) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.likeListPostEndPoint}?postId=$postId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);

      return response = LikeModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }

  // / **************************** GET COMMENT LIST API *******************************
  Future<CommentModel> getCommentListApi(String postId) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.commentListPostEndPoint}?postId=$postId";
      dynamic response = await _apiServices.getGetApiResponse(url, header);

      return response = CommentModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }
}
