import 'package:flutter/material.dart';
import 'package:shopify/models/user.dart';

class Authprovider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login({
    required String email,
    required String firstName,
    required String lastName,
    required String image,
    required String gender,
  }) {
    _user = User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
    );

    notifyListeners();
  }

  void loggedOut() {
    _user = null;
    notifyListeners();
  }
}
