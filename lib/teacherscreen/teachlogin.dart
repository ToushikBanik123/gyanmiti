import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/teacherscreen/techhome.dart';
import 'package:lottie/lottie.dart';

class TeachLogin extends StatefulWidget {
  const TeachLogin({Key? key}) : super(key: key);

  @override
  State<TeachLogin> createState() => _TeachLoginState();
}

class _TeachLoginState extends State<TeachLogin> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350.h,
                child: Lottie.asset(
                  'assets/animation/teaching.json',
                ),
              ),
              Spacer(),
              Text(
                'Enter your registered Mobile Number and Password',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40.h),
              TextField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: ' +91 | Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              TextField(
                controller: _passwordController,
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
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TechHome()),
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
                      'Login',
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
