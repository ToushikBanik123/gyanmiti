import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'addsyllabus.dart';

class TechSyllabus extends StatefulWidget {
  const TechSyllabus({Key? key}) : super(key: key);

  @override
  State<TechSyllabus> createState() => _TechSyllabusState();
}

class _TechSyllabusState extends State<TechSyllabus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Syllabus Page',
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
                  builder: (context) => SyllabusPage(),
                ),
              );
            },
            backgroundColor: Colors.blue.shade300,
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Icon(Icons.add),
                SizedBox(width: 5.w),
                Text('Add Syllabus'),
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
