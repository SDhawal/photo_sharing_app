import 'package:flutter/cupertino.dart';
import 'package:photo_sharing_app/models/user.dart' as model;
import 'package:photo_sharing_app/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier{
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();

  model.User get getUser => _user!;

  Future<void> refreshUser() async {
  model.User user = await _authMethods.getUserDetails();
  _user = user;
  notifyListeners();
  //this will notify all the listeners to this user provider that data has changed so update the value

  }
}