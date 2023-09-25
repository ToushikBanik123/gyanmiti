//assets/images

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:gm/studentscreens/welcome.dart';
import 'Provider/notification_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("Device Token");
      print(value.toString());
    });

    // Add a delay using Timer to navigate to the next page after 2 seconds (adjust the duration as needed)
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyScreen()), // Replace 'NextPage' with your desired page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F4EB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 200.sp,
              height: 200.sp,
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                Spacer(),
                SizedBox(
                  //width: 300.sp,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontFamily: 'Agne',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText('Gyanmeeti'),
                        TypewriterAnimatedText('Gyanmeeti'),
                        TypewriterAnimatedText('Gyanmeeti'),
                        TypewriterAnimatedText('Gyanmeeti'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20.sp),
            // Text(
            //   'Gyanmeeti',
            //   style: TextStyle(
            //     color: Color(0xFF4682A9),
            //     fontSize: 24,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
