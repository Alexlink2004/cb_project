import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'api_constants.dart';

class UsersApi extends ChangeNotifier {
  final dio = Dio();
  //Add user
  Future<Response> create(User user) async {
    final response = await dio.post(
      '${ApiConstants.apiRoute}/users',
      data: user.toJson(),
    );
    notifyListeners();
    try {
      if (response.statusCode == 201) {
        print('User created successfully');
        notifyListeners();
        return response;
      } else {
        notifyListeners();
        print('Failed to create user: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      notifyListeners();
      print('Error while creating user: $e');
      return response;
    }
  }

  //Get All Users
  Future<List<User>> read() async {
    Response response = await dio.get("${ApiConstants.apiRoute}/users");
    final List<dynamic> responseData = response.data;
    final List<User> users =
        responseData.map((userJson) => User.fromJson(userJson)).toList();
    notifyListeners();
    return users;
  }

  //Get specific
  Future<User> getUserByPassword(String password) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${ApiConstants.apiRoute}/users/user',
        queryParameters: {'password': password},
      );
      debugPrint('getUserByPassword() response: ${response.data}');

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return ApiConstants.errorUser;
      }
    } catch (e) {
      debugPrint('Error on getting User');
      return ApiConstants.errorUser;
    }
  }

  //filtrar puestos
  List<User> filterUsersByPosition(List<User> users, String position) {
    return users.where((user) => user.position != position).toList();
  }

  //Update User
  void update(String id, User user) async {
    try {
      final response = await dio.put(
        '${ApiConstants.apiRoute}/users/$id',
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        print('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while updating user: $e');
    }
  }

  //Delete user
  Future<Response> delete(String id) async {
    final response = await dio.delete(
      '${ApiConstants.apiRoute}/users/$id',
    );
    try {
      if (response.statusCode == 204) {
        print('User deleted successfully');
        return response;
        notifyListeners();
      } else {
        print('Failed to delete user: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      print('Error while deleting user: $e');
      return response;
    }
    notifyListeners();
  }
}
