import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/core/models/Users.dart';
import 'package:flutter_recycle_hub/features/account/services/UserService.dart';
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUser() async {
    if (_user != null) return;

    final userId = await SharedPrefsUtil.getUserId();
    if (userId == null) return;

    final fetchedUser = await UserService.getUser(userId);
    if (fetchedUser != null) {
      _user = fetchedUser;
      notifyListeners();
    }
  }

  Future<void> updateUser(User updatedUser) async {
    _user = updatedUser;
    notifyListeners();
  }
}
