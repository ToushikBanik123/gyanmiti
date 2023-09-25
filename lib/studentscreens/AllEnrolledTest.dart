import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Model/ExamCategoryModel.dart';
import '../../Model/ExamListExamTileModel.dart';
import '../../Provider/appProvider.dart';
import 'EnroledCourceDetailsPage.dart';
import '../Model/ExamListExamTileModel.dart';

class AllEnrolledTest extends StatefulWidget {
  const AllEnrolledTest({Key? key}) : super(key: key);

  @override
  State<AllEnrolledTest> createState() => _AllEnrolledTestState();
}

class _AllEnrolledTestState extends State<AllEnrolledTest> {
  List<ExamListExamTileModel> examList = [];
  Future<void> fetchData({required String uid}) async {
    final Uri apiUrl =
        Uri.parse("https://gyanmeeti.in/API/all_enrolled_exam_list.php");

    try {
      final response = await http.post(apiUrl, body: {
        'user_id': uid,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['free_exam'] is List<dynamic>) {
          final examData = data['free_exam'] as List<dynamic>;

          setState(() {
            examList = examData
                .map((item) => ExamListExamTileModel.fromJson(item))
                .toList();
          });
        } else {
          // Handle the case where 'free_exam' is not a list in the response.
          // You can throw an exception or set an error message here.
        }
      } else {
        // Handle HTTP error here, for example, display an error message.
      }
    } catch (e) {
      // Handle exceptions like network errors or JSON parsing errors.
    }
  }

  @override
  void initState() {
    // final provider = Provider.of<AppProvider>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    fetchData(uid: provider.appUser.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: examList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cart.png',
                    height: 200.h,
                  ),
                  Text(
                    'No Purchases Yet !!',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: examList.length,
              itemBuilder: (context, index) {
                ExamListExamTileModel exam = examList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnroledCourceDetailsPage(
                                exam: exam,
                              )),
                    );
                  },
                  child: Container(
                    height: 150.sp,
                    width: 370.w,
                    margin: EdgeInsets.all(15.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F4F4),
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                          child: Image.network(
                            "https://gyanmeeti.in/admin/exam_image/${exam.image}",
                            width: 120.sp,
                            height: 120.sp,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15.sp),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.sp),
                              Text(
                                exam.examName!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.sp),
                              Text(
                                "by ${exam.createdBy!}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Text(
                                "${exam.session!}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "Time : ${exam.duration!}",
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: GoogleFonts.aBeeZee(
                                  //     fontSize: 11.sp,
                                  //     fontWeight: FontWeight.w600,
                                  //     color: Color(0xFFEF6262),
                                  //   ),
                                  // ),
                                  Text(
                                    "Enrolled",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6F61C0)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
