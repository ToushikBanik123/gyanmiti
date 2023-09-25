// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gmeeti/studentscreens/password.dart';
//
// import '../Model/User.dart';
//
// class Settings extends StatefulWidget {
//   final User appUser; // Pass the appUser as a parameter to the widget
//
//   const Settings({Key? key, required this.appUser}) : super(key: key);
//
//   @override
//   State<Settings> createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Call the method to prepopulate controllers with appUser values
//     _prepopulateControllers(widget.appUser);
//   }
//
//   // Method to prepopulate controllers with appUser values
//   void _prepopulateControllers(User appUser) {
//     nameController.text = appUser.name;
//     phoneNumberController.text = appUser.phone;
//     emailController.text = appUser.email;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           'Settings',
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 18.sp,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 30.h),
//             _buildRowWithIconAndText(Icons.person, 'Name'),
//             SizedBox(height: 20.h),
//             _buildTextFormField('Full Name', nameController),
//             SizedBox(height: 30.h),
//             _buildRowWithIconAndText(Icons.phone, 'Phone Number'),
//             SizedBox(height: 20.h),
//             _buildTextFormField('Phone No.', phoneNumberController, TextInputType.number, 10),
//             SizedBox(height: 30.h),
//             _buildRowWithIconAndText(Icons.email, 'Email'),
//             SizedBox(height: 20.h),
//             _buildTextFormField('Email', emailController, TextInputType.emailAddress),
//             SizedBox(height: 10.h),
//             _buildChangePasswordButton(context),
//             Spacer(),
//             _buildUpdateProfileButton(),
//             SizedBox(height: 20.h),
//             SizedBox(height: 50.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRowWithIconAndText(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon),
//         SizedBox(width: 8.w),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF0D0D26),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextFormField(String hintText, TextEditingController controller, [TextInputType? keyboardType, int? maxLength]) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         hintText: hintText,
//       ),
//       keyboardType: keyboardType,
//       maxLength: maxLength,
//     );
//   }
//
//   Widget _buildChangePasswordButton(BuildContext context) {
//     return Row(
//       children: [
//         Spacer(),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Password()),
//             );
//           },
//           child: Text(
//             'Change Password',
//             style: TextStyle(
//               color: Colors.blue,
//               decoration: TextDecoration.underline,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildUpdateProfileButton() {
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => Home_Page()),
//           // );
//         },
//         child: Container(
//           width: 327.w,
//           height: 56.h,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade900, Colors.blue.shade300],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Center(
//             child: Text(
//               'Update Profile',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.sp,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/User.dart';

class Settings extends StatefulWidget {
  final User appUser; // Pass the appUser as a parameter to the widget

  const Settings({Key? key, required this.appUser}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the method to prepopulate controllers with appUser values
    _prepopulateControllers(widget.appUser);
  }

  // Method to prepopulate controllers with appUser values
  void _prepopulateControllers(User appUser) {
    nameController.text = appUser.name;
    phoneNumberController.text = appUser.phone;
    emailController.text = appUser.email;
  }

  Future<void> _updateProfile() async {
    final String name = nameController.text;
    final String phoneNumber = phoneNumberController.text;
    final String email = emailController.text;

    if (phoneNumber.length != 10) {
      Fluttertoast.showToast(
        msg: "Phone number should be 10 digits",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      Fluttertoast.showToast(
        msg: "Please enter a valid email address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      final response = await _sendUpdateProfileRequest(name, phoneNumber, email);

      if (response['message'] == "Profile Details Update Successful") {
        Fluttertoast.showToast(
          msg: "Profile details updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Profile details update failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while updating profile details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<Map<String, dynamic>> _sendUpdateProfileRequest(
      String name, String phoneNumber, String email) async {
    final apiUrl = 'https://gyanmeeti.in/API/update_profile.php'; // Replace with your API endpoint URL
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final body = {
      'userid': widget.appUser.id.toString(),
      'name': name,
      'phone': phoneNumber,
      'email': email,
    };

    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
            _buildRowWithIconAndText(Icons.person, 'Name'),
            SizedBox(height: 20.h),
            _buildTextFormField('Full Name', nameController),
            SizedBox(height: 30.h),
            _buildRowWithIconAndText(Icons.phone, 'Phone Number'),
            SizedBox(height: 20.h),
            _buildTextFormField('Phone No.', phoneNumberController, TextInputType.number, 10),
            SizedBox(height: 30.h),
            _buildRowWithIconAndText(Icons.email, 'Email'),
            SizedBox(height: 20.h),
            _buildTextFormField('Email', emailController, TextInputType.emailAddress),
            SizedBox(height: 10.h),
            _buildChangePasswordButton(context),
            Spacer(),
            _buildUpdateProfileButton(),
            SizedBox(height: 20.h),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithIconAndText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0D0D26),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(String hintText, TextEditingController controller, [TextInputType? keyboardType, int? maxLength]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Password()),
            );
          },
          child: Text(
            'Change Password',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateProfileButton() {
    return Center(
      child: GestureDetector(
        onTap: _updateProfile, // Call the _updateProfile function when tapped
        child: Container(
          width: 327.w,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              'Update Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
