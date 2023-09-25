import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/login/register.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _handleTextChanged(int index, String value) {
    if (value.isNotEmpty && index < _controllers.length - 1) {
      FocusScope.of(context).nextFocus();
    }
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
      body: Padding(
        padding:  EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'OTP has successfully sent to\nyour number',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) => Container(
                  width: 45.0.w,
                  height: 60.0.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) => _handleTextChanged(index, value),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Text(
                  'Didnot receive the code?',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(width: 5.h),
                Text(
                  'Resend',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.blue.shade500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              'Get OTP on call',
              style: TextStyle(
                fontSize: 16.sp,
                decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
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
                    'Submit',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 17.sp,
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
      ),
    );
  }
}