import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController loginEmailnameController =
      TextEditingController(text: "admin@gmail.com");
  TextEditingController loginPasswordController =
      TextEditingController(text: "admin123");

  TextEditingController registerEmailnameController =
      TextEditingController(text: "asdas@gmail.com");
  TextEditingController registerPasswordController =
      TextEditingController(text: "admin123");

  String? token;
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    notifyListeners();

    return token;
  }

}
