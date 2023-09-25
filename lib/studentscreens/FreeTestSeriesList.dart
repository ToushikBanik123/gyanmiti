import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Model/ExamCategoryModel.dart';
import '../../Model/ExamListExamTileModel.dart';
import '../../Provider/appProvider.dart';
import 'TestEnrolmentPage.dart';


class FreeTestSeriesList extends StatefulWidget {
  final String category;
  FreeTestSeriesList({required this.category, Key? key}) : super(key: key);

  @override
  State<FreeTestSeriesList> createState() => _FreeTestSeriesListState();
}

class _FreeTestSeriesListState extends State<FreeTestSeriesList> {
  List<ExamListExamTileModel> examList = [];

  @override
  void initState() {
    // final provider = Provider.of<AppProvider>(context);
    super.initState();
  }

  Future<void> fetchData({required String uid}) async {
    final Uri apiUrl = Uri.parse("https://gyanmeeti.in/API/free_exam_list.php");

    final response = await http.post(apiUrl, body: {
      'category': widget.category, // Replace with the desired category
      'user_id': uid, // Replace with the user ID
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
        throw Exception('Failed to parse data from the API');
      }
    } else {
      throw Exception('Failed to load data from the API');
    }
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    fetchData(uid: provider.appUser.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: examList.isEmpty
          ? Center(child: CircularProgressIndicator())
          :ListView.builder(
            itemCount: examList.length,
            itemBuilder: (context, index) {
            ExamListExamTileModel exam = examList[index];
              return Consumer<AppProvider>(builder: (context,provider,child){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestDetailsPage(exam: examList[index],)),
                    );
                  },
                  child: Container(
                    height: 150.sp,
                    width: 370.w,
                    margin: EdgeInsets.all(15.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F4F4),
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
                                "Session : ${exam.session!}",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "Free",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF33BBC5)
                                    ),
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
              });
        },
      ),

    );
  }

  Widget _buildContainer(String text, VoidCallback onTap) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: (MediaQuery.of(context).size.width - 40),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/course.png'),
                        radius: 35,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
// Action for Buy Now button
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text('Buy Now'),
                      ),
                      ElevatedButton(
                        onPressed: () {
// Action for View Demo button
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.blue.shade700),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text('View Demo'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}