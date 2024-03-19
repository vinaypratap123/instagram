import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/data/network/network_api_services.dart';
import 'package:instagram/model/notification_model.dart';
import 'package:instagram/repository/app_url.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // **************************** NEW PASSWORD API *******************************
  Future<dynamic> notificationApi(dynamic data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    try {
      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      dynamic response = await NetworkApiServices()
          .getPostApiResponseWithHeaderForNotification(
              AppUrl.notificationEndPoint, data, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }

  // **************************** GET NOTIFICTION API *******************************
//   Future<NotificationModel> getNotificationListApi() async {
//     try {
//       final SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final String? token = sharedPreferences.getString("token");

//       dynamic header = {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token"
//       };
//  print("********************* 3 exicute ");
//       dynamic response = await _apiServices.getGetApiResponse(
//           AppUrl.notificationListEndPoint, header);

//     print("********************* 3 complete ");
//       return response = NotificationModel.fromJson(response);
//     } catch (error) {
//     print("********************* 3 error ");
//       UiHelper.toastMessage(error.toString());
//       rethrow;
//     }
//   }



  Future<NotificationModel> getNotificationListApi(int page) async {
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.notificationListEndPoint}?page=$page', header);
  print("****** ${response.toString()}");
      return NotificationModel.fromJson(response);
    } catch (error) {
    
      rethrow;
    }
  }


  //delete
  // *************************** API *******************************
  Future<dynamic> deleteNotificationApi(
    String notificationId,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("token");

      dynamic header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      String url = "${AppUrl.notificationEndPoint}?notificationId=$notificationId";

      dynamic response = await NetworkApiServices().getDeleteApi(url, header);

      return response;
    } catch (error) {
      UiHelper.toastMessage(error.toString());
    }
  }
}


