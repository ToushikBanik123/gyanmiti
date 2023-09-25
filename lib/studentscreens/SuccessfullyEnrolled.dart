import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Model/ExamListExamTileModel.dart';
import 'TestEnrolmentPage.dart';


class SuccessfullyEnrolled extends StatefulWidget {
  late ExamListExamTileModel exam;
  SuccessfullyEnrolled({required this.exam, Key? key}) : super(key: key);

  @override
  State<SuccessfullyEnrolled> createState() => _SuccessfullyEnrolledState();
}

class _SuccessfullyEnrolledState extends State<SuccessfullyEnrolled> {
  void initState() {
    super.initState();

    // Delay navigation by 2 seconds (you can adjust this as needed)
    Timer(Duration(seconds: 2), () {
      // Navigate to the desired page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TestDetailsPage(exam: widget.exam), // Replace 'NextPage' with your desired destination page
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
          child: Lottie.asset('assets/animation/done.json',
            repeat: false,
          ),
        ),
      ),
    );
  }
}