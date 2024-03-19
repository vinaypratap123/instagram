import 'package:flutter/material.dart';
import 'package:instagram/repository/post_view_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class ReportPostViewModel with ChangeNotifier {
  final _myRepo = PostRepository();

// ************************* REPORT POST API ************************
  Future<void> reportPostApi(String postId, BuildContext context) async {
    _myRepo.reportPostApi(postId).then((value) {
      UiHelper.flushBarMessage(context, "Report Post SuccessFully");
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
