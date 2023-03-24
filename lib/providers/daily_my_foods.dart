import 'package:flutter/material.dart';

import '../models/user_model.dart';

class DailyMyFoods extends ChangeNotifier {
  final List<Items> _dailyMyFoods = [];
  List<Items> get dailyMyFoods => _dailyMyFoods;

  void addFood(Items food) {
    _dailyMyFoods.add(food);
    notifyListeners();
  }

  void removeFood(Items food) {
    _dailyMyFoods.remove(food);
    notifyListeners();
  }
}
