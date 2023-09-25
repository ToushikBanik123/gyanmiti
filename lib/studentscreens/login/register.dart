import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/login/studentLoginPage.dart';
import 'package:provider/provider.dart';

import '../../Provider/appProvider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Back',
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Text(
                        'Register Account',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D0D26),
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8.w),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D0D26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: provider.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      SizedBox(width: 8.w),
                      Text(
                        'Email Id',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0D0D26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: provider.emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'Email Id',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!value.contains('@')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Icon(Icons.password),
                      SizedBox(width: 8.w),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0D0D26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: provider.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'Password',
                    ),
                    validator: _validatePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Icon(Icons.gps_fixed),
                      SizedBox(width: 8.w),
                      Text(
                        'State',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D0D26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: provider.stateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'State',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'State is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 70.h),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final name = provider.nameController.text;
                          final email = provider.emailController.text;
                          final password = provider.passwordController.text;
                          final state = provider.stateController.text;
                          final phone = provider.mobileNumberController.text;


                          // Call the registerStudent function
                          final result = await provider.registerStudent(
                            name: provider.nameController.text,
                            phone: provider.mobileNumberController.text,
                            password: provider.passwordController.text,
                            email: provider.emailController.text,
                            state: provider.stateController.text,
                            context: context,
                          );
                          if (result == "Registration Successful") {
                            // Registration successful, navigate to the next page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => studentLoginPage()),
                            );
                            provider.clearLoginStudentTextFields();
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration failed. $result'),
                              ),
                            );
                          }

                        }
                      },
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
                              'Register Now',
                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
