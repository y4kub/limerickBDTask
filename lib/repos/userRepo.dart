import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:limeric_task/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';

class AuthRepository {
  final String apiUrl = baseURL+loginURL; // Replace with your API URL

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final user = User.fromJson(jsonResponse);

      // Save the token using SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', user.token);
      await storeToken(user.token);
      print("User token is ${user.token}");
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('authToken');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
