import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/login/register.dart';
import 'package:provider/provider.dart';

import '../../Provider/appProvider.dart';
import 'otp.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  bool isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text('Back',style: TextStyle(color: Colors.grey,fontSize: 18.sp),),
      ),
      body: Consumer<AppProvider>(builder: (context,provider,child){
        return Padding(
          padding:  EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Enter your Mobile Number',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.h),
              TextField(
                controller: provider.mobileNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: ' +91 | Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'By continuning, you agree to our',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Term & Conditions',
                style: TextStyle(
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  // Navigator.push(
                  //   context,
                  //   //TODO Impliment OTP
                  //   // MaterialPageRoute(builder: (context) => OtpVerify()),
                  //   MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  // );
                  if (isMobileNumberValid(provider.mobileNumberController.text)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid mobile number.'),
                      ),
                    );
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
                      'Get code',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }
}