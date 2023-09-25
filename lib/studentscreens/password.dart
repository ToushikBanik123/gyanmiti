import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/User.dart';
import '../Provider/appProvider.dart';


class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordMatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(Icons.lock),
                SizedBox(width: 8.w),
                Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0D0D26),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MyTextField(
              icon: Icons.lock,
              hint: 'Password',
              controller: newPasswordController,
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(Icons.lock_outline),
                SizedBox(width: 8.w),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0D0D26),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MyTextField(
              icon: Icons.lock,
              hint: 'Confirm Password',
              controller: confirmPasswordController,
              isPassword: true,
            ),
            Spacer(),
            Center(
              child: Consumer<AppProvider>(builder: (context,provider,child){
                return GestureDetector(
                  onTap: () {
                    updatePassword(provider.appUser);
                  },
                  child: Container(
                    width: 327.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade800, Colors.orange.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        'Update Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
  //
  // // Function to update the password
  // void updatePassword(User appuser) async {
  //   final newPassword = newPasswordController.text;
  //   final confirmPassword = confirmPasswordController.text;
  //
  //   if (newPassword.isNotEmpty &&
  //       confirmPassword.isNotEmpty &&
  //       newPassword == confirmPassword) {
  //     final url = Uri.parse('https://gyanmeeti.in/API/change_password.php'); // Replace with your API URL
  //     final response = await http.post(
  //       url,
  //       body: {
  //         "userid": appuser.id, // Replace with the user's ID
  //         "password": newPassword,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       String message = responseData['message'];
  //
  //       // Show a success message
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Password Update Successful'),
  //             content: Text(message),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       // Show an error message if the API call fails
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Password Update Failed'),
  //             content: Text('An error occurred while updating the password.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } else {
  //     // Show an error message if passwords don't match or are empty
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Password Update Failed'),
  //           content: Text('Passwords do not match or are empty.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  void updatePassword(User appuser) async {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        newPassword == confirmPassword) {
      final url = Uri.parse('https://gyanmeeti.in/API/change_password.php'); // Replace with your API URL
      final response = await http.post(
        url,
        body: {
          "userid": appuser.id, // Replace with the user's ID
          "password": newPassword,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String message = responseData['message'];

        // Show a success message using Fluttertoast
        Fluttertoast.showToast(
          msg: 'Password Update Successful\n$message',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Clear both fields
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        // Show an error message if the API call fails using Fluttertoast
        Fluttertoast.showToast(
          msg: 'Password Update Failed\nAn error occurred while updating the password.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      // Show an error message if passwords don't match or are empty using Fluttertoast
      Fluttertoast.showToast(
        msg: 'Password Update Failed\nPasswords do not match or are empty.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

class MyTextField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;

  const MyTextField({
    Key? key,
    required this.icon,
    required this.hint,
    this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintText: widget.hint,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon:
          Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      obscureText: widget.isPassword ? _obscureText : false,
    );
  }
}
