// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gmeeti/Provider/appProvider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import '../Model/ExamDetails.dart';
// import '../Model/ExamListExamTileModel.dart';
//
// class TestDetailsPage extends StatelessWidget {
//   late ExamListExamTileModel exam;
//   TestDetailsPage({required this.exam, Key? key}) : super(key: key);
//
//   Future<List<ExamDetails>> fetchExamDetails(String examId, String userId) async {
//     final uri = Uri.parse("https://gyanmeeti.in/API/free_exam_details.php");
//     final response = await http.post(
//       uri,
//       body: {
//         'exam_id': examId,
//         'user_id': userId,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final examList = jsonData['free_exam_list'] as List;
//       return examList.map((e) => ExamDetails.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load exam details');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//         automaticallyImplyLeading: true,
//         title: Text(
//           exam.examName.toString(),
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Consumer<AppProvider>(builder: (context,provider,child){
//         return FutureBuilder<List<ExamDetails>>(
//           future: fetchExamDetails(exam.id.toString(), provider.appUser.id),
//           builder: (context, snapshot){
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return CircularProgressIndicator();
//             }else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else{
//               final examDetails = snapshot.data;
//               print(examDetails.toString());
//               return Container(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       'assets/images/banner.png',
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       // Adjust the width as needed
//                       fit: BoxFit.fitWidth,
//                     ),
//                     SizedBox(height: 30.h),
//                     Text(
//                       'Course Name',
//                       style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 30.h),
//                     Text(
//                       'Course Details',
//                       style: TextStyle(fontSize: 18.sp),
//                     ),
//                     SizedBox(height: 30.h),
//                     Row(
//                       children: [
//                         Icon(Icons.currency_rupee, color: Colors.red),
//                         SizedBox(width: 10.w),
//                         Text(
//                           'Price: \$99.99',
//                           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 10.w),
//                         Text(
//                           '70.02% off',
//                           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.blue.shade400),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     Row(
//                       children: [
//                         Icon(Icons.ads_click_outlined, color: Colors.green),
//                         SizedBox(width: 10.w),
//                         Text('Recorded Lectures'),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Icon(Icons.ads_click_outlined, color: Colors.green),
//                         SizedBox(width: 10.w),
//                         Text('Mock Test + PDF'),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Icon(Icons.ads_click_outlined, color: Colors.green),
//                         SizedBox(width: 10.w),
//                         Text('Expert Faculty'),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Icon(Icons.ads_click_outlined, color: Colors.green),
//                         SizedBox(width: 10.w),
//                         Text('Basic to Advanced'),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Icon(Icons.ads_click_outlined, color: Colors.green),
//                         SizedBox(width: 10.w),
//                         Text('12 Months Validity'),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(builder: (context) => OtpVerify()),
//                         // );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         height: 50.h,
//                         margin: EdgeInsets.symmetric(vertical: 10.h),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Colors.blue.shade900, Colors.blue.shade300],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           borderRadius: BorderRadius.circular(20.r),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Buy Now',
//                             style: TextStyle(
//                                 decoration: TextDecoration.none,
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         );
//       },)
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import '../Model/ExamDetails.dart';
import '../Model/ExamListExamTileModel.dart';
import '../Model/User.dart';
import '../Provider/appProvider.dart';
import 'SuccessfullyEnrolled.dart';

class TestDetailsPage extends StatefulWidget {
  late ExamListExamTileModel exam;

  TestDetailsPage({required this.exam, Key? key}) : super(key: key);

  @override
  State<TestDetailsPage> createState() => _TestDetailsPageState();
}

class _TestDetailsPageState extends State<TestDetailsPage> {
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openPaymentPortal() async {
    var options = {
      'key': 'rzp_live_6lVCODFs4katch',
      // 'key': 'rzp_test_YjOu38M2dxdNJ5',
      'amount': int.parse(widget.exam.fees!) * 100,
      'name': 'Gyanmeeti',
      'description': 'Payment for ${widget.exam.examName}',
      // 'prefill': {'contact': '9800515347', 'email': 'jhon@razorpay.com'},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    enrollCourse(
        userId: appProvider.appUser.id.toString(),
        examId: widget.exam.id.toString(),
        transactionId: response.paymentId.toString(),
        amount: widget.exam.fees!,
        context: context,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  Future<List<ExamDetails>> fetchExamDetails(String examId, String userId) async {
    final uri = Uri.parse("https://gyanmeeti.in/API/free_exam_details.php");
    final response = await http.post(
      uri,
      body: {
        'exam_id': examId,
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final examList = jsonData['free_exam_list'] as List;
      return examList.map((e) => ExamDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load exam details');
    }
  }

  // Future<void> enrollCourse({required String userId, required String examId,required BuildContext context}) async {
  //   final String apiUrl = "https://gyanmeeti.in/API/enroll_course.php";
  //
  //   // Prepare the request body
  //   final Map<String, String> requestBody = {
  //     "user_id": userId,
  //     "exam_id": examId,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: requestBody,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //
  //       // Check the response message
  //       if (jsonResponse['message'] == "Enroll Successful") {
  //         // Enrollment was successful, handle accordingly
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => SuccessfullyEnrolled(exam: widget.exam,)),
  //         );
  //         print("Enrollment Successful");
  //       } else {
  //         // Enrollment failed, handle accordingly
  //         print("Enrollment failed");
  //       }
  //     } else {
  //       // Handle any other status codes here
  //       print("Request failed with status: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     // Handle any network or other errors here
  //     print("Error: $e");
  //   }
  // }


  Future<void> enrollCourse({
    required String userId,
    required String examId,
    required String transactionId,
    required String amount,
    required BuildContext context,
  }) async {
    final String apiUrl = "https://gyanmeeti.in/API/enroll_course.php";

    // Prepare the request body
    final Map<String, String> requestBody = {
      "user_id": userId,
      "exam_id": examId,
      "transaction_id": transactionId,
      "amount": amount.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check the response message
        if (jsonResponse['message'] == "Enroll Successful") {
          // Enrollment was successful, handle accordingly
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessfullyEnrolled(exam: widget.exam)),
          );
          print("Enrollment Successful");
        } else {
          // Enrollment failed, handle accordingly
          print("Enrollment failed");
        }
      } else {
        // Handle any other status codes here
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any network or other errors here
      print("Error: $e");

      // Display an error message to the user using a SnackBar or some other mechanism.
    }
  }


  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          widget.exam.examName.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<ExamDetails>>(
            future: fetchExamDetails(widget.exam.id.toString(), provider.appUser.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final  examDetails = snapshot.data;
                print( 'Fees: ${examDetails?.first.fees ?? 'N/A'}');
                return Container(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "https://gyanmeeti.in/admin/exam_image/${examDetails?.first.image}",
                          width: MediaQuery.of(context).size.width * 0.9,
                          fit: BoxFit.fitWidth,
                          height: 220.sp,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          'Test Name: ${examDetails?.first.examName ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'by ${examDetails?.first.createdBy ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(fontSize: 18.sp),
                        ),
                        SizedBox(height: 20.sp),
                        // Text(
                        //   'Test Details: ${examDetails?.first.duration ?? 'N/A'}',
                        //   style: GoogleFonts.aBeeZee(fontSize: 18.sp),
                        // ),
                        // SizedBox(height: 20.sp),
                        Text(
                          'Session: ${examDetails?.first.session ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(fontSize: 18.sp),
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          'Fees: ${examDetails?.first.fees ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18.sp,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        // Text(
                        //   'TotalMark: ${examDetails?.first.totalMark ?? 'N/A'}',
                        //   style: GoogleFonts.aBeeZee(
                        //     fontSize: 18.sp,
                        //   ),
                        // ),
                        // SizedBox(height: 20.sp),
                        // Text(
                        //   'PassMark: ${examDetails?.first.passMark ?? 'N/A'}',
                        //   style: GoogleFonts.aBeeZee(
                        //     fontSize: 18.sp,
                        //   ),
                        // ),
                        // SizedBox(height: 20.sp),
                        Text(
                          'CreatedBy: ${examDetails?.first.createdBy ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          'Session: ${examDetails?.first.session ?? 'N/A'}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (examDetails?.first.enrollStatus != null ) ? GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => OtpVerify()),
                                // );
                              },
                              child: Container(
                                // width: double.infinity,
                                height: 50.sp,
                                width: 300.sp,
                                margin: EdgeInsets.symmetric(vertical: 10.r),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.green.shade900, Colors.blue.shade300],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Text(
                                    '${examDetails?.first.enrollStatus}',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ) : GestureDetector(
                              onTap: () {
                                (examDetails?.first.fees.toString() == "Free") ? enrollCourse(
                                  userId: appProvider.appUser.id,
                                  context: context,
                                  examId: widget.exam.id.toString(),
                                  amount: examDetails!.first.fees.toString(),
                                  transactionId: examDetails!.first.fees.toString(),
                                //   examId: widget.exam.id.toString(),
                                // transactionId: response.paymentId.toString(),
                                // amount: widget.exam.fees!,
                                // context: context,
                                ) : openPaymentPortal();
                                // enrollCourse(examId: widget.exam.id.toString(),userId: provider.appUser.id.toString(),context: context);
                              },
                              child: Container(
                                // width: double.infinity,
                                height: 50.sp,
                                width: 300.sp,
                                margin: EdgeInsets.symmetric(vertical: 10.r),
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
                                    'Enroll',
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
                        SizedBox(height: 70.sp),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

