import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/user.dart';

class DioUserApi{
  static const String base_url = "https://63218bbbfd698dfa29f9d7c9.mockapi.io";

  static Future<List<User>> getUsers() async {
    try {
      Response response = await Dio().get("$base_url/user");
      return List.from(response.data)
          .map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users $e');
    }
  }

  static Future<User> postUser(User user) async{
    final Response response = await Dio().post('$base_url/user',
        data: {
          "id": user.id,
          "name": user.name,
          "username": user.username,
          "password": user.password,
        }
    );

    if (response.statusCode == 201){
      return User.fromJson(response.data);
    }else{
      throw Exception('Failed to post user');
    }
  }

  static Future<User> putUser(String id, User user) async{
    String url = '$base_url/user/$id';
    final response = await Dio().put(url,
        data: {
          "id": user.id,
          "name": user.name,
          "username": user.username,
          "password": user.password,
        });

    if (response.statusCode == 200){
      return User.fromJson(response.data);
    }else{
      throw Exception('Failed to put user');
    }
  }

  static Future<User> deleteUser(String id) async{
    String url = '$base_url/user/$id';
    final response = await Dio().delete(url);
    if (response.statusCode == 200){
      return User.fromJson(response.data);
    }else{
      throw Exception('Failed to put user');
    }
  }

  static Future<List<User>> getMultiUsers() async {
    try {
      List<Response> response = await Future.wait([
        Dio().get("$base_url/user"),
        Dio().get("$base_url/user")
      ]);
      return List.from(response[0].data)
          .map((json) => User.fromJson(json)).toList()..addAll(
          List.from(response[1].data)
              .map((json) => User.fromJson(json)).toList()
      );
    } catch (e) {
      throw Exception('Failed to load users $e');
    }
  }
}