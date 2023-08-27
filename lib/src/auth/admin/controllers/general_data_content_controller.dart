import 'package:cb_project/src/server/api/users_api.dart';
import 'package:flutter/cupertino.dart';

import '../../../server/models/user.dart';

class GeneralDataContentController extends ChangeNotifier {
  //State
  //  List of users in state (Private)
  List<User> _users = [];
  //Getters & Setters
  //  Users
  List<User> get users {
    return _users;
    //return User.generateRandomUsers(10);
  }

  set users(data) {
    _users = data;
    notifyListeners();
  }

  void getUsers() async {
    final List<User> users = await UsersApi().read();
    _users = users;
    notifyListeners();
  }

  void addUser(User user) {
    UsersApi().create(user).then((value) {
      if (value.statusCode == 201) {
        users.add(user);
        debugPrint("User added");
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void deleteUser(String id) {
    UsersApi().delete(id).then((value) {
      if (value.statusCode == 204) {
        users.removeWhere(
          (element) => element.id == id,
        );
        debugPrint("User deleted");
        notifyListeners();
      }
    });
  }
  //
}
