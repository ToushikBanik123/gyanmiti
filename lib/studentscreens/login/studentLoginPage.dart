import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Model/User.dart';
import '../../Provider/appProvider.dart';
import '../bottom.dart';

class studentLoginPage extends StatefulWidget {
  const studentLoginPage({Key? key}) : super(key: key);

  @override
  State<studentLoginPage> createState() => _studentLoginPageState();
}

class _studentLoginPageState extends State<studentLoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapping outside of text input fields
        FocusScope.of(context).unfocus();
      },
      child: ColorfulSafeArea(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<AppProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 50.sp,
                          height: 50.sp,
                        ),
                        const Text(
                          'Gyanmeeti',
                          style: TextStyle(
                            color: Color(0xFF4682A9),
                            fontSize: 24,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300.h,
                          child: Lottie.asset(
                            'assets/animation/teaching.json',
                          ),
                        ),
                        // Image.asset(
                        //   'assets/images/logo.png',
                        //   width: 50.sp,
                        //   height: 50.sp,
                        // ),
                        // const Text(
                        //   'Gyanmeeti',
                        //   style: TextStyle(
                        //     color: Color(0xFF4682A9),
                        //     fontSize: 24,
                        //   ),
                        // ),
                        // SizedBox(height: 20.h),
                        Text(
                          'Enter your registered Mobile Number and Password',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        TextField(
                          controller: provider.mobileNumberController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: ' +91 | Mobile Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            counterText: '', // Set counterText to an empty string
                          ),
                        ),

                        SizedBox(height: 25.h),
                        TextField(
                          controller: provider.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        GestureDetector(
                          onTap: () async {
                            try {
                              final user = await provider.loginStudent(
                                  provider.mobileNumberController.text,
                                  provider.passwordController.text);
                              if (user != null) {
                                // Login successful, navigate to the next screen
                                // You can replace this with your desired navigation logic
                                print("Login successful!");
                                print("User ID: ${user.id}");
                                print("User Name: ${user.name}");
                                print("User Phone: ${user.phone}");
                                print("User Email: ${user.email}");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home_Page()),
                                );
                              } else {
                                // Handle login failure
                                print("Login failed.");
                              }
                            } catch (e) {
                              // Handle exceptions
                              print("Error: $e");
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
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
                                'Login',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
