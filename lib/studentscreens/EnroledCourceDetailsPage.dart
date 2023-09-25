// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import '../../Model/ExamCategoryModel.dart';
// import '../../Model/ExamListExamTileModel.dart';
// import '../../Provider/appProvider.dart';
// import '../Model/ExamCard.dart';
// import '../Model/ExamDetails.dart';
// import '../Model/ExamSession.dart';
// import 'TermsAndConditionsPage.dart';
//
//
// class EnroledCourceDetailsPage extends StatefulWidget {
//   late ExamListExamTileModel exam;
//   EnroledCourceDetailsPage({required this.exam,Key? key}) : super(key: key);
//
//   @override
//   State<EnroledCourceDetailsPage> createState() => _EnroledCourceDetailsPageState();
// }
//
// class _EnroledCourceDetailsPageState extends State<EnroledCourceDetailsPage> {
//
//   List<ExamSession> examSessions = [];
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
//   // Future<void> fetchExamSessions() async {
//   //   final apiUrl = Uri.parse("https://gyanmeeti.in/API/exam_session.php");
//   //   final response = await http.post(apiUrl, body: {"exam_id": widget.exam.id.toString()});
//   //
//   //   if (response.statusCode == 200) {
//   //     final Map<String, dynamic> data = json.decode(response.body);
//   //     if (data.containsKey("exam_session")) {
//   //       final List<dynamic> sessionList = data["exam_session"];
//   //       setState(() {
//   //         examSessions = sessionList.map((json) => ExamSession.fromJson(json)).toList();
//   //         print(examSessions.toString());
//   //       });
//   //     }
//   //   }
//   // }
//
//   Future<void> fetchExamSessions({required String userId}) async {
//     final apiUrl = Uri.parse("https://gyanmeeti.in/API/exam_session.php");
//     final response = await http.post(apiUrl, body: {"exam_id": widget.exam.id.toString(), "user_id": userId});
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       if (data.containsKey("exam_session")) {
//         final List<dynamic> sessionList = data["exam_session"];
//         setState(() {
//           examSessions = sessionList.map((json) => ExamSession.fromJson(json)).toList();
//           print(examSessions.toString());
//         });
//       }
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AppProvider>(context);
//     fetchExamSessions(userId: provider.appUser.id);
//     // final provider = Provider.of<AppProvider>(context);
//     // fetchExamSessions(uid: provider.appUser.id);
//     // fetchExamSessions();
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         // backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//         automaticallyImplyLeading: true,
//         title: Text(
//           widget.exam.examName.toString(),
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Consumer<AppProvider>(
//         builder: (context, provider, child) {
//           return FutureBuilder<List<ExamDetails>>(
//             future: fetchExamDetails(widget.exam.id.toString(), provider.appUser.id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 final examDetails = snapshot.data;
//                 return Container(
//                   margin: EdgeInsets.all(20.sp),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image.network(
//                         //   "https://gyanmeeti.in/admin/exam_image/${examDetails?.first.image}",
//                         //   width: MediaQuery.of(context).size.width * 0.9,
//                         //   fit: BoxFit.fitWidth,
//                         //   height: 220.sp,
//                         // ),
//                         // SizedBox(height: 30.h),
//                         // Text(
//                         //   'Test Name: ${examDetails?.first.examName ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(fontSize: 24.sp, fontWeight: FontWeight.bold),
//                         // ),
//                         // Text(
//                         //   'by ${examDetails?.first.createdBy ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(fontSize: 18.sp),
//                         // ),
//                         // SizedBox(height: 20.sp),
//                         // Text(
//                         //   'Session: ${examDetails?.first.session ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(fontSize: 18.sp),
//                         // ),
//                         // SizedBox(height: 20.sp),
//                         // Text(
//                         //   'Fees: ${examDetails?.first.fees ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(
//                         //     fontSize: 18.sp,
//                         //     color: Colors.green,
//                         //   ),
//                         // ),
//                         // SizedBox(height: 20.sp),
//                         // Text(
//                         //   'CreatedBy: ${examDetails?.first.createdBy ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(
//                         //     fontSize: 18.sp,
//                         //   ),
//                         // ),
//                         // SizedBox(height: 20.sp),
//                         // Text(
//                         //   'Session: ${examDetails?.first.session ?? 'N/A'}',
//                         //   style: GoogleFonts.aBeeZee(
//                         //     fontSize: 18.sp,
//                         //   ),
//                         // ),
//                         // SizedBox(height: 20.sp),
//
//                         Card(
//                           elevation: 2.0,
//                           color: Color(0xFFFFFFFF),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.sp),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15.r),
//                                     topRight: Radius.circular(15.r),
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15.r),
//                                     topRight: Radius.circular(15.r),
//                                   ),
//                                   child: Image.network(
//                                     "https://gyanmeeti.in/admin/exam_image/${examDetails?.first.image}",
//                                     fit: BoxFit.cover,
//                                     height: 200.h,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Test Name: ${examDetails?.first.examName ?? 'N/A'}',
//                                       style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(height: 8.sp),
//                                     Text(
//                                       'Created By: ${examDetails?.first.createdBy ?? 'N/A'}',
//                                       style: TextStyle(fontSize: 18.sp),
//                                     ),
//                                     SizedBox(height: 8.sp),
//                                     Text(
//                                       'Session: ${examDetails?.first.session ?? 'N/A'}',
//                                       style: TextStyle(fontSize: 18.sp),
//                                     ),
//                                     // SizedBox(height: 8.sp),
//                                     // Text(
//                                     //   'Fees: ${examDetails?.first.fees ?? 'N/A'}',
//                                     //   style: TextStyle(
//                                     //     fontSize: 18.sp,
//                                     //     color: Colors.green,
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         ListView.builder(
//                           itemCount: examSessions.length,
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final session = examSessions[index];
//                             return InkWell(
//                               onTap: (){
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => TermsAndConditionsPage(
//                                         exam: widget.exam,
//                                         session: session,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: ExamCard(
//                                 session: session,
//                                 exam: widget.exam,
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: 100.sp),
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Model/ExamCategoryModel.dart';
import '../../Model/ExamListExamTileModel.dart';
import '../../Provider/appProvider.dart';
import '../Model/ExamCard.dart';
import '../Model/ExamDetails.dart';
import '../Model/ExamSession.dart';
import 'TermsAndConditionsPage.dart';
import 'ViewResultPage.dart';

class EnroledCourceDetailsPage extends StatefulWidget {
  late ExamListExamTileModel exam;
  EnroledCourceDetailsPage({required this.exam, Key? key}) : super(key: key);

  @override
  State<EnroledCourceDetailsPage> createState() => _EnroledCourceDetailsPageState();
}

class _EnroledCourceDetailsPageState extends State<EnroledCourceDetailsPage> {
  List<ExamSession> examSessions = [];

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

  Future<void> fetchExamSessions({required String userId}) async {
    final apiUrl = Uri.parse("https://gyanmeeti.in/API/exam_session.php");
    final response = await http.post(apiUrl, body: {"exam_id": widget.exam.id.toString(), "user_id": userId});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey("exam_session")) {
        final List<dynamic> sessionList = data["exam_session"];
        setState(() {
          examSessions = sessionList.map((json) => ExamSession.fromJson(json)).toList();
          print(examSessions.toString());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    fetchExamSessions(userId: provider.appUser.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                final examDetails = snapshot.data;
                return Container(
                  margin: EdgeInsets.all(20.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2.0,
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.r),
                                    topRight: Radius.circular(15.r),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.r),
                                    topRight: Radius.circular(15.r),
                                  ),
                                  child: Image.network(
                                    "https://gyanmeeti.in/admin/exam_image/${examDetails?.first.image}",
                                    fit: BoxFit.cover,
                                    height: 200.h,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Test Name: ${examDetails?.first.examName ?? 'N/A'}',
                                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8.sp),
                                    Text(
                                      'Created By: ${examDetails?.first.createdBy ?? 'N/A'}',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 8.sp),
                                    Text(
                                      'Session: ${examDetails?.first.session ?? 'N/A'}',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: examSessions.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final session = examSessions[index];
                            return InkWell(
                              onTap: () {
                                (session.attemptStatus == "True") ?
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewResultPage(
                                      examId: widget.exam.id.toString(),
                                      sessionId: session.id.toString(),
                                      userId: provider.appUser.id,
                                    ),
                                  ),
                                )
                                    :
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TermsAndConditionsPage(
                                      exam: widget.exam,
                                      session: session,
                                    ),
                                  ),
                                );
                              },
                              child: ExamCard(
                                session: session,
                                exam: widget.exam,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 100.sp),
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
