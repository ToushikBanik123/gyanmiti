import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Model/PaidCourseModel.dart';
import '../../Provider/appProvider.dart';
import '../../studentscreens/PaidCourseSubjectList.dart';

class PaidCourceTile extends StatefulWidget {
  final PaidCourseModel course;

  PaidCourceTile({
    required this.course,
    Key? key,
  }) : super(key: key);

  @override
  State<PaidCourceTile> createState() => _PaidCourceTileState();
}

class _PaidCourceTileState extends State<PaidCourceTile> {

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
      'amount': widget.course.price! * 100,
      'name': 'Gyanmeeti',
      'description': 'Payment for ${widget.course.courseName}',
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
        userId: appProvider.appUser.id,
        courseId: widget.course.id.toString(),
        transactionId: response.paymentId.toString(),
        amount: widget.course.price.toString(),
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



  Future<void> enrollCourse({
    required String userId,
    required String courseId,
    required String transactionId,
    required String amount,
      }
      ) async {
    final apiUrl = Uri.parse('https://gyanmeeti.in/API/paid_course_payment.php');

    final requestBody = {
      'user_id': userId,
      'course_id': courseId,
      'transaction_id': transactionId,
      'amount': amount.toString(),
    };

    try {
      final response = await http.post(
        apiUrl,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String message = responseData['message'];

        // Check the response message to determine if the enrollment was successful
        if (message == 'Payment Successful') {
          // Payment was successful, you can handle it here
          print('Payment Successful');
        } else {
          // Payment failed, handle it accordingly
          print('Payment failed');
        }
      } else {
        // Handle HTTP errors, if any
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any network or other errors that might occur
      print('Error: $error');
    }
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // openPaymentPortal();
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled:
              true, // This is important to make it 1/3 of the screen height
          builder: (BuildContext context) {
            // You can customize the content of your bottom sheet here
            return SizedBox(
              height: 400.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display the image at the top
                  Image.network(
                    "https://gyanmeeti.in/admin/course_logo/" + widget.course.logo!,
                    fit: BoxFit.fill,
                    height: 200.0,
                    width: double.infinity, // Set the desired height
                  ),
                  SizedBox(height: 10.0.sp),
                  Container(
                    width: 250.sp,
                    alignment: Alignment.center,
                    child: Text(
                      widget.course.courseName.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "₹" + widget.course.price.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0.sp),
                  (widget.course.enrollStatus == "Not Enrolled")
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.sp),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Action for Buy Now button
                              openPaymentPortal();
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.sp),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Action for Buy Now button
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text(
                              'View Courses',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(width: 80.0.sp),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
        child: Container(
          width: (MediaQuery.of(context).size.width - 10.w),
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  widget.course.logo != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://gyanmeeti.in/admin/course_logo/" +
                                  widget.course.logo!),
                          radius: 30.r,
                        )
                      : Icon(Icons.image),
                  SizedBox(width: 16.0.w),
                  Container(
                    width: 150.sp,
                    child: Text(
                      widget.course.courseName.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "₹" + widget.course.price.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 16.h),
              (widget.course.enrollStatus == "Not Enrolled")
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Action for Buy Now button
                              openPaymentPortal();
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Action for View Course button
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Action for View Demo button
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PaidCourseSubjectList(course: widget.course,)),
                              );
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text(
                              'View Demo',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaidCourseSubjectList(course: widget.course,)),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: const Text(
                          'View Courses',
                          style: TextStyle(
                            color: Colors.white,
                          ),
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



