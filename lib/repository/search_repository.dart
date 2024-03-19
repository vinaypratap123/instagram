import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/search_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepository {
  // **************************** SEARCH API *******************************
  Future<dynamic> searchApi(dynamic data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    try {
      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };


      String url = "${AppUrl.searchEndPoint}?search=$data";
     
      dynamic response =
          await NetworkApiServices().getPostApiResponseForSearch(url, header);

    
      return SearchModel.fromJson(response);
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }
}
