import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String signUpWithMailAndPasswordUrl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBhPjdCffOM86Nf9REygKeB8zfc8DKPNmM";
String signInWithMailAndPasswordUrl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBhPjdCffOM86Nf9REygKeB8zfc8DKPNmM";

class AuthService {
  Future<String> register(Map<String, dynamic> body) async {
    // print("registerEmailnameController: ${registerEmailnameController.text}");
    // print("registerPasswordController: ${registerPasswordController.text}");

    try {
      http.Response response =
          await http.post(Uri.parse(signUpWithMailAndPasswordUrl),
              headers: {
                "Content-Type": "application/json",
              },
              body: json.encode(body));
      // final response = await http.post(Uri.parse(url),
      //     body: json.encode({"token": customToken, "returnSecureToken": true}));

      final responseData = json.decode(response.body);
      print("----------------$responseData");

      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        return responseData['error']['message'];
        // İstek başarısız oldu, hata mesajını işleyin
      } else {
        print(responseData);
        return "success";
        // İstek başarılı oldu, kullanıcının bilgilerini responseData içinden alın
      }
    } catch (error) {
      // Hata oluştu, hatayı işleyin
      print(error);
      return error.toString();
    }
  }

  Future<String> login(Map<String, dynamic> body) async {
    // print("loginEmailnameController: ${loginEmailnameController.text}");
    // print("loginPasswordController: ${loginPasswordController.text}");

    try {
      http.Response response =
          await http.post(Uri.parse(signInWithMailAndPasswordUrl),
              headers: {
                "Content-Type": "application/json",
              },
              body: json.encode(body));
      // final response = await http.post(Uri.parse(url),
      //     body: json.encode({"token": customToken, "returnSecureToken": true}));

      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        return responseData['error']['message'];
        // İstek başarısız oldu, hata mesajını işleyin
      } else {
        print(responseData);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", responseData['localId']);
        return "success";

        // İstek başarılı oldu, kullanıcının bilgilerini responseData içinden alın
      }
    } catch (error) {
      // Hata oluştu, hatayı işleyin
      print(error);
      return error.toString();
    }
  }
}
