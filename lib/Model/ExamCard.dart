import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Model/ExamCategoryModel.dart';
import '../../Model/ExamListExamTileModel.dart';
import '../../Provider/appProvider.dart';
import '../Model/ExamDetails.dart';
import '../Model/ExamSession.dart';
import '../studentscreens/TermsAndConditionsPage.dart';

class ExamCard extends StatelessWidget {
  late ExamListExamTileModel exam;
  final ExamSession session;

  ExamCard({
    required this.session,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2.sp,
      // color: Color(0xFFFFFFFFF),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.sp),
      // ),
      margin: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${session.sessionName}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.sp),
                Row(
                  children: [
                    Text(
                      "${session.noOfQuestions} Questions ",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      "${session.attemptStatus}",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "${session.totalMarks} Marks ",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "${session.duration} Minutes",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
                SizedBox(height: 15.sp),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.sp),
              bottomRight: Radius.circular(10.sp),
            ),
            child: Container(
              width: double.infinity,
              height: 40.sp,
              decoration: BoxDecoration(
                // color: Color(0xFF025464),
                color:  (session.attemptStatus == "True") ?Colors.green.shade800 : Colors.yellow.shade800,
              ),
              alignment: Alignment.center,
              child: (session.attemptStatus == "True") ? Text(
                "View Result",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ) : Text(
                "Attempt",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ) ,
            ),
          ),
        ],
      ),
    );
  }
}
