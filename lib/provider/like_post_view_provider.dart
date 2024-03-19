import 'package:flutter/material.dart';
import 'package:instagram/provider/notification_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
import 'package:instagram/repository/post_view_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class LikePostViewModel with ChangeNotifier {
  final _myRepo = PostRepository();

// ************************* LIKE POST API ************************
  Future<void> likePostApi(
      String postId, dynamic data, BuildContext context) async {

   
    _myRepo.likePostApi(postId).then((value) async {
      UiHelper.flushBarMessage(context, "like Post SuccessFully");
      UserProfileViewModel userProfileViewModel = UserProfileViewModel();
      userProfileViewModel.fetchUserProfile();


      if (!data.isEmpty) {
        NotificationViewModel notificationViewModel = NotificationViewModel();

        notificationViewModel.notificationsApi(data, context);
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
