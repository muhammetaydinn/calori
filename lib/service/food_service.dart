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
          UserModel user = UserModel.fromJson(data[key]);
          user.uid = key;
          list.add(user);
        }
      }
    }
    return list;
  }

  Future<UserModel?> getUserById(String uid) async {
    http.Response response = await http.get(getUrl("users/$uid"));
    var data = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (data != null) {
        return UserModel(
            uid: uid,
            items: data["items"].map<Items>((e) => Items.fromJson(e)).toList());
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<UserModel?> postUser(UserModel user) async {
    http.Response response = await http.post(getUrl("users"),
        body: jsonEncode(user), headers: {"Content-Type": "application/json"});
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
        body: jsonEncode(user), headers: {"Content-Type": "application/json"});
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> updateAddUser(Items item, String uid) async {
    // update user and add new item
    var a = await getUserById(uid);
    if (a != null) {
      a.items!.add(item);
      http.Response response = await http.put(getUrl("users/$uid/"),
          body: jsonEncode(a), headers: {"Content-Type": "application/json"});
      return response.statusCode >= 200 && response.statusCode < 300;
    } else {
      http.Response res = await http.post(getUrl("users/$uid/"),
          body: {
            "items": [item.toJson()],
            "uid": uid
          }.toString(),
          headers: {"Content-Type": "application/json"});
      return res.statusCode >= 200 && res.statusCode < 300;
    }
  }

  Future<bool> deleteUser(String uid) async {
    http.Response response = await http.delete(getUrl("users/$uid"));
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
