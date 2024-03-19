import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/feed_model.dart';
import 'package:instagram/repository/feed_repository.dart';

class FeedViewModel with ChangeNotifier {
  final FeedRepository myRepo;
   List<Feed> _feed = [];

  List<Feed> get feed => _feed;
  bool _isRefresh = false;
  bool get isRefersh => _isRefresh;
  void setRefresh(value){
    _isRefresh = value;
    notifyListeners();
  }
  FeedViewModel() : myRepo = FeedRepository();
  ApiResponse<FeedModel> feedList = ApiResponse.loading();
  setFeedList(ApiResponse<FeedModel> response) {
    feedList = response;

    notifyListeners();
  }

  Future<void> fetchFeedList() async {
    setFeedList(ApiResponse.loading());

    myRepo.getFeedApi().then((value) {
      setFeedList(ApiResponse.complete(value));
      print("*****feed data********");
      print(value.toJson());
      // _feed =   value.data.feed;
      // notifyListeners();
    }).onError((error, stackTrace) {
      setFeedList(ApiResponse.error(error.toString()));
    });
  }
}
