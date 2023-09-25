import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/banner.png',
              width: MediaQuery.of(context).size.width * 0.9,
              // Adjust the width as needed
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 30.h),
            Text(
              'Course Name',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
            Text(
              'Course Details',
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(Icons.currency_rupee, color: Colors.red),
                SizedBox(width: 10.w),
                Text(
                  'Price: \$99.99',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.w),
                Text(
                  '70.02% off',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.blue.shade400),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(Icons.ads_click_outlined, color: Colors.green),
                SizedBox(width: 10.w),
                Text('Recorded Lectures'),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.ads_click_outlined, color: Colors.green),
                SizedBox(width: 10.w),
                Text('Mock Test + PDF'),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.ads_click_outlined, color: Colors.green),
                SizedBox(width: 10.w),
                Text('Expert Faculty'),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.ads_click_outlined, color: Colors.green),
                SizedBox(width: 10.w),
                Text('Basic to Advanced'),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.ads_click_outlined, color: Colors.green),
                SizedBox(width: 10.w),
                Text('12 Months Validity'),
              ],
            ),
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtpVerify()),
                // );
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                margin: EdgeInsets.symmetric(vertical: 10.h),
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
                    'Buy Now',
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
    );
  }
}