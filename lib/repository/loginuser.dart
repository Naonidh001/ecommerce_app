import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/models/user.dart';
import 'package:shopify/utils/constants.dart';

Future<User> registerUser({
  required String username,
  required String password,
}) async {
  try {
    final url = Uri.parse(Api.login);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login successful!");

      final user = User(
        email: data['email'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        gender: data['gender'],
        image: data['image'],
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', data['accessToken']);

      // var tmp = prefs.getString('access_token');
      // print("Token : $tmp");

      return user;
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to login");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to login");
  }
}
