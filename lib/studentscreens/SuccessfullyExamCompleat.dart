import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../Model/ExamListExamTileModel.dart';
import 'TestEnrolmentPage.dart';
import 'home.dart';

class SuccessfullyExamCompleat extends StatefulWidget {
  const SuccessfullyExamCompleat({Key? key}) : super(key: key);

  @override
  State<SuccessfullyExamCompleat> createState() => _SuccessfullyExamCompleatState();
}

class _SuccessfullyExamCompleatState extends State<SuccessfullyExamCompleat> {
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChooseLevel(), // Replace 'NextPage' with your desired destination page
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E2EB),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFE0E2EB)
          ),
          child: Lottie.asset('assets/animation/examdone.json',
            repeat: false,
            height: 300.sp,
          ),
        ),
      ),
    );
  }
}
