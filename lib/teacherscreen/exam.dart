import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'addexam.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Exam Page',
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
                  builder: (context) => AddExamForm(),
                ),
              );
            },
            backgroundColor: Colors.blue.shade300,
            child: Row(
              children: [
                SizedBox(width: 15.w),
                Icon(Icons.add),
                SizedBox(width: 5.w),
                Text('Add Exam'),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),)
        ),
      ),
    );
  }
}
