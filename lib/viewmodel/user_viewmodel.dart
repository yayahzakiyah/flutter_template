import 'package:rxdart/rxdart.dart';
import 'package:template_flutter/data/api/service/user_service.dart';
import 'package:template_flutter/model/user_model.dart';

class UserVieModel {
  final UserService _userService = UserService();

  final _usersController = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get usersStream => _usersController.stream;

  void getUsers() async {
    try {
      List<UserModel> users = await _userService.getUsers();
      _usersController.sink.add(users);
    } catch (e) {
      throw e;
    }
  }

  void createUser(Map<String, dynamic> user) async {
    try {
      Map<String, dynamic> newUser = await _userService.createUser(user);
      print(newUser);
      // List<User> users = _usersController.value;
      // users.add(newUser);
      // _usersController.sink.add(users);
    } catch (e) {
      throw e;
    }
  }

  void updateUser(int id, Map<String, dynamic> user) async {
    try {
      Map<String, dynamic> updatedUser = await _userService.updateUser(id, user);
      print(updatedUser);
      // List<User> users = _usersController.value;
      // int index = users.indexWhere((u) => u.id == updatedUser.id);
      // users[index] = updatedUser;
      // _usersController.sink.add(users);
    } catch (e) {
      throw e;
    }
  }

  void deleteUser(int id) async {
    try {
      await _userService.deleteUser(id);
      List<UserModel> users = _usersController.value;
      users.removeWhere((u) => u.id == id);
      _usersController.sink.add(users);
    } catch (e) {
      throw e;
    }
  }

  void dispose() {
    _usersController.close();
  }
}
