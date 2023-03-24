import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../service/search_service.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<Items> searchList = [];
  Services service = Services();

  void getSearch(String query) async {
    searchList = await service.getSearch(query);
    notifyListeners();
  }

  // List<SearchModel> _searchList = [];
  // List<SearchModel> get searchList => _searchList;

  // void setSearchList(List<SearchModel> searchList) {
  //   _searchList = searchList;
  //   notifyListeners();
  // }
}
