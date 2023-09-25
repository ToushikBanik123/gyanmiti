// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';


class AppProvider with ChangeNotifier {

  late User _appUser;

  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  get mobileNumberController => _mobileNumberController;
  get nameController => _nameController;
  get emailController => _emailController;
  get passwordController => _passwordController;
  get stateController => _stateController;
  get appUser => _appUser;

  Future<String> registerStudent({
    required String name,
    required String phone,
    required String password,
    required String email,
    required String state,
    required BuildContext context
  }) async {
    final uri = Uri.parse("https://gyanmeeti.in/API/student_register.php");
    final response = await http.post(
      uri,
      body: {
        "name": name,
        "phone": phone,
        "password": password,
        "email": email,
        "state": state,
      },
    );

    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData["message"];
    } else {
      final responseData = json.decode(response.body);
      return responseData["message"];
      throw Exception('Failed to register student ${responseData["message"]}');
    }
  }

  void clearLoginStudentTextFields() {
    _nameController.clear();
    _mobileNumberController.clear();
    _emailController.clear();
    _passwordController.clear();
    _stateController.clear();
  }


  Future<User?> loginStudent(String phone, String password) async {
    final Uri uri = Uri.parse("https://gyanmeeti.in/API/student_login.php");
    final response = await http.post(
      uri,
      body: {'phone': phone, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['message'] == "Login successful") {
        final userData = jsonResponse['user'][0];
        final user = User(
          id: userData['id'].toString(),
          name: userData['name'],
          phone: userData['phone'],
          email: userData['email'],
        );

        // Save user information in SharedPreferences
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('id', user.id);
        // prefs.setString('name', user.name);
        // prefs.setString('phone', user.phone);
        // prefs.setString('email', user.email);
        _appUser = user;
        notifyListeners();
        clearRegisterStudentTextFields();
        return user;
      } else if (jsonResponse['message'] == "Account has been Deactivated") {
        throw Exception("Account has been deactivated.");
      } else {
        throw Exception("Invalid username and password.");
      }
    } else {
      throw Exception("Failed to connect to the server.");
    }
  }

  void clearRegisterStudentTextFields() {
    _nameController.clear();
    _mobileNumberController.clear();
    _emailController.clear();
    _passwordController.clear();
    _stateController.clear();
  }



}
