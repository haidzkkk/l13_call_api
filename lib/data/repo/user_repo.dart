
import 'package:l13_call_api/data/network/dio_user_api.dart';

import '../model/user.dart';
import '../network/http_user_apt.dart';

class UserRepo{

  Future<List<User>> getUsers() async {
    // return await HttpUserApi.getUsers();
    return await DioUserApi.getUsers();
  }

  Future<User> addUser(User user) async {
    // return await HttpUserApi.postUser(user);
    return await DioUserApi.postUser(user);
  }

  Future<User> updateUser(User user) async {
    // return await HttpUserApi.putUser(user.id!, user);
    return await DioUserApi.putUser(user.id!, user);
  }

  Future<User> deleteUser(User user) async {
    // return await HttpUserApi.deleteUser(user.id!);
    return await DioUserApi.deleteUser(user.id!);
  }
}