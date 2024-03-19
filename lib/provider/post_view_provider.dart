import 'package:flutter/material.dart';
import 'package:instagram/repository/post_view_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/routes/routes_name.dart';

class PostViewModel with ChangeNotifier {
  final _myRepo = PostRepository();
  bool _postLoading = false;
  bool get postLoading => _postLoading;

  void setPostLoading(value) {
    _postLoading = value;
    notifyListeners();
  }

// ************************* POST API ************************
  Future<void> postApi(dynamic postCredential, BuildContext context) async {
    setPostLoading(true);

    _myRepo.postApi(postCredential).then((value) {
      setPostLoading(false);

      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavbar,
          (route) => false,
        );
        UiHelper.flushBarMessage(context, "Post SuccessFully");
      }
    }).onError((error, stackTrace) {
      setPostLoading(false);

      UiHelper.toastMessage(error.toString());
    });
  }

// ************************* COMMENT API ************************
  Future<void> commentApi(
      String postId, String comment, BuildContext context) async {
    _myRepo.commentApi(postId, comment).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        Navigator.pushNamed(
          context,
          RoutesName.bottomNavbar,
        );
        UiHelper.flushBarMessage(context, "Comment SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }

// ************************* Edit POST API ************************
  Future<void> editPostApi(
      String postId, dynamic caption, BuildContext context) async {
    _myRepo.editPostApi(postId, caption).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        UiHelper.flushBarMessage(context, "Post Edit SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }

// ************************* Edit POST API ************************
  Future<void> editCommentApi(
      String commentId, dynamic comment, BuildContext context) async {
    _myRepo.editCommentApi(commentId, comment).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        UiHelper.flushBarMessage(context, "Comment Edit SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
