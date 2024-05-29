import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class HttpUserApi{
  static const String base_url = "https://63218bbbfd698dfa29f9d7c9.mockapi.io";

  static List<User> _parseUsers(String responseBody){
    List<dynamic> listJson = json.decode(responseBody) ;
    List<User> users = listJson.map((json) => User.fromJson(json)).toList();
    return users;
  }

  static User _parseUser(String responseBody){
    dynamic mJson = json.decode(responseBody) ;
    User user = User.fromJson(mJson);
    return user;
  }

  static Future<List<User>> getUsers() async{
    Uri url = Uri.parse('$base_url/user');
    final response = await http.get(url);
    print("alo ${response.body.toString()}");
    if (response.statusCode == 200){
      return _parseUsers(response.body);
    }else{
      throw Exception('Failed to load users');
    }
  }

  static Future<User> postUser(User user) async{
    Map<String, String> headers = <String, String>{'Content-Type': 'application/json; charset=UTF-8',};
    Uri url = Uri.parse('$base_url/user');
    var json = user.toJson();

    final response = await http.post(url, body: json);

    if (response.statusCode == 201){
      return _parseUser(response.body);
    }else{
      throw Exception('Failed to post user');
    }
  }

  static Future<User> putUser(String id, User user) async{
    Uri url = Uri.parse('$base_url/user/$id');
    var json = user.toJson();
    final response = await http.put(url, body: json);

    if (response.statusCode == 200){
      return _parseUser(response.body);
    }else{
      throw Exception('Failed to put user');
    }
  }

  static Future<User> deleteUser(String id) async{
    Uri url = Uri.parse('$base_url/user/$id');
    final response = await http.delete(url);

    print("${response.statusCode} ${response.body}");
    if (response.statusCode == 200){
      return _parseUser(response.body);
    }else{
      throw Exception('Failed to put user');
    }
  }

}