import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/feed_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// **************************** GET FEED API *******************************
  Future<FeedModel> getFeedApi() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.feedEndPoint, header);

      return response = FeedModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
      rethrow;
    }
  }
}
