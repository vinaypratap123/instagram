import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/search_model.dart';
import 'package:instagram/repository/search_repository.dart';

class SearchViewModel with ChangeNotifier {
  final SearchRepository _myRepo;
  SearchViewModel() : _myRepo = SearchRepository();
  bool _searchLoading = false;

  bool get searchLoading => _searchLoading;

  // ************************* SET SEARCH LOADING FUNCTION ************************
  void setSearchLoading(value) {
    _searchLoading = value;
    notifyListeners();
  }

  // ************************* RESET SEARCH LIST() function ************************
  void resetSearchList() {
    searchList = ApiResponse.none();
  }

  ApiResponse<SearchModel> searchList = ApiResponse.none();
  setSearchList(ApiResponse<SearchModel> response) {
    searchList = response;
    notifyListeners();
  }

  Future<void> fetchSearchList(String data, BuildContext context) async {
    setSearchList(ApiResponse.loading());
    _myRepo.searchApi(data).then((value) {
      setSearchList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setSearchList(ApiResponse.error(error.toString()));
    });
  }
}

