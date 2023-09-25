import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({Key? key}) : super(key: key);

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text('Notification',style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            Text('Stay tuned!',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 20.h,),
            Text('Notifications about your posts, comments and likes will show up here ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
              ),),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }
}