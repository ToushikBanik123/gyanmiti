import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'addjob.dart';

class TechJob extends StatefulWidget {
  const TechJob({Key? key}) : super(key: key);

  @override
  State<TechJob> createState() => _TechJobState();
}

class _TechJobState extends State<TechJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Job Page',
          style: TextStyle(
              color: Colors.black
          ),),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 150.w,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddJob(),
                ),
              );
            },
            backgroundColor: Colors.blue.shade300,
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Icon(Icons.add),
                SizedBox(width: 5.w),
                Text('Add Job'),
                SizedBox(width: 5.w),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),)
        ),
      ),
    );
  }
}
