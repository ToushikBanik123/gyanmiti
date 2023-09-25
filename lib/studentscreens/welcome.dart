import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'login/number.dart';
import 'login/studentLoginPage.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapping outside of text input fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF6F4EB),
        body: Container(
          color: Color(0xFFF6F4EB),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350.h,
                  child: Lottie.asset(
                    'assets/animation/41464-student-with-books.json',
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.sp),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerificationPage()),
                      );
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
                          'Register',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.sp),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => studentLoginPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
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
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
