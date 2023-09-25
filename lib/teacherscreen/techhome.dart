import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/teacherscreen/syllabus.dart';
import 'package:gm/teacherscreen/techdrawer.dart';
import 'course.dart';
import 'exam.dart';
import 'job.dart';

class TechHome extends StatefulWidget {
  const TechHome({Key? key}) : super(key: key);

  @override
  State<TechHome> createState() => _TechHomeState();
}

class _TechHomeState extends State<TechHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Gyanmeeti',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: TechDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      'Hello,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'user!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                child: Column(
                  children: [
                    _buildRowContainer(
                      'assets/images/paid.png',
                      'Add Course',
                      'assets/images/test.png',
                      'Add Exam',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoursePage()),
                        );
                      },
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Exam()),
                        );
                      },
                    ),
                    _buildRowContainer(
                      'assets/images/syllabus.png',
                      'Add Syllabus',
                      'assets/images/notify.png',
                      'Job',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TechSyllabus()),
                        );
                      },
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TechJob()),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowContainer(
      String image1,
      String text1,
      String image2,
      String text2,
      VoidCallback onTap1,
      VoidCallback onTap2,
      ) {
    return Row(
      children: [
        _buildContainer(image1, text1, onTap1),
        _buildContainer(image2, text2, onTap2),
      ],
    );
  }

  Widget _buildContainer(
      String imagePath,
      String text,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.sp,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: CircleAvatar(
                  radius: 45.sp,
                  backgroundColor: Colors.white,
                  child: Image.asset(imagePath),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}