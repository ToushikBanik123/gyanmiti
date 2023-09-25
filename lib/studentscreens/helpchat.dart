import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Model/User.dart';
import '../Provider/appProvider.dart';

class HelpChat extends StatefulWidget {
  const HelpChat({Key? key}) : super(key: key);

  @override
  State<HelpChat> createState() => _HelpChatState();
}

class _HelpChatState extends State<HelpChat> {
  String? selectedIssue;
  final problemDescriptionController = TextEditingController();
  Future<bool> submitIssue(User appUser) async {
    final uri = Uri.parse("https://gyanmeeti.in/API/help_and_feedback.php");

    // Prepare the request body
    final Map<String, String> requestBody = {
      "userid": appUser.id,
      "email": appUser.email,
      "phone": appUser.phone,
      "issue": selectedIssue ?? "",
      "problem": problemDescriptionController.text,
    };

    try {
      final response = await http.post(
        uri,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['message'] == "Sent Successful") {
          // Issue sent successfully
          return true;
        } else {
          // Issue sending failed
          return false;
        }
      } else {
        // Handle any other status codes here
        print("API call failed with status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Handle any exceptions here
      print("Exception occurred: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Consumer<AppProvider>(builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Text(
                  'Help Section',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D0D26),
                  ),
                ),
                SizedBox(height: 30.h),
                TextFormField(
                  controller: TextEditingController(text: provider.appUser.name),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: TextEditingController(text: provider.appUser.email),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'Email ID',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: TextEditingController(text: provider.appUser.phone),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'Phone No.',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 20.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Select Issue',
                    prefixIcon: Icon(Icons.select_all),
                  ),
                  value: selectedIssue,
                  onChanged: (newValue) {
                    setState(() {
                      selectedIssue = newValue;
                    });
                  },
                  items: <String>['Payment Help', 'Other Help']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: problemDescriptionController, // Use the controller here
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'Write about the problem',
                    prefixIcon: Icon(Icons.report_problem_outlined),
                  ),
                ),
                SizedBox(height: 35.h),
                GestureDetector(
                  onTap: () async {
                    if (selectedIssue == null || selectedIssue!.isEmpty) {
                      // Show an alert because the issue is not selected
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Please select an issue."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (problemDescriptionController.text.isEmpty) {
                      // Show an alert because the problem description is empty
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Please write about the problem."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Call the API function to submit the issue
                      final success = await submitIssue(provider.appUser);
                      if (success) {
                        // Show a success message using a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Issue submitted successfully!"),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // Clear both fields after a successful submission
                        selectedIssue = null;
                        problemDescriptionController.clear();
                        setState(() {}); // Redraw the widget to reflect changes
                      }
                    }
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
                        'Submit Issue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () async {
                    final phoneNumber = '9332523841';
                    final url = 'https://api.whatsapp.com/send?phone=${Uri.encodeFull(phoneNumber)}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      // Handle the case where WhatsApp could not be launched.
                      // You can display a message or perform some other action here.
                      print('Could not launch WhatsApp');
                    }
                  },
                  child: Container(
                    width: 327.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade900, Colors.green.shade300],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        'Whatsapp Support',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}