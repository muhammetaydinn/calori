import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

const String _baseUrl = "https://calori-4e27d-default-rtdb.firebaseio.com";

class FoodService {
  Uri getUrl(String endpoint) => Uri.parse("$_baseUrl/$endpoint.json");

  Future<List<UserModel>> getUsers() async {
    //ApiConfig.shared.token = "asdjdashjsbfajkbh";
    http.Response response = await http.get(getUrl("users"));
    List<UserModel> list = [];
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      if (data != null) {
        for (var key in data.keys) {
          UserModel user = UserModel.fromMap(data[key]);
          user.uid = key;
          list.add(user);
        }
      }
    }
    return list;
  }

  Future<UserModel?> getUserById(String uid) async {
    http.Response response = await http.get(getUrl("users/$uid"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return UserModel.fromJson(response.body)..uid = uid;
    } else {
      return null;
    }
  }

  Future<UserModel?> postUser(UserModel user) async {
    http.Response response = await http.post(getUrl("users"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      user.uid = data["name"];
      return user;
    } else {
      return null;
    }
  }

  Future<bool> updateUser(UserModel user, String uid) async {
    http.Response response = await http.put(getUrl("users/$uid/"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> deleteUser(String uid) async {
    http.Response response = await http.delete(getUrl("users/$uid"));
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
