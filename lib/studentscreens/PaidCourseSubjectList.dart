import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/PaidCourseModel.dart';
import '../Model/PaidCourseSubjectModel.dart';
import 'PaidCourseSubjectChapterList.dart';

class PaidCourseSubjectList extends StatefulWidget {
  final PaidCourseModel course;

  PaidCourseSubjectList({required this.course, Key? key}) : super(key: key);

  @override
  _PaidCourseSubjectListState createState() => _PaidCourseSubjectListState();
}

class _PaidCourseSubjectListState extends State<PaidCourseSubjectList> {
  List<PaidCourseSubjectModel> subjectList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final uri = Uri.parse("https://gyanmeeti.in/API/paid_course_subject_list.php");
    final response = await http.post(uri, body: {"course_id": widget.course.id.toString()});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey("subject")) {
        final subjects = List<Map<String, dynamic>>.from(jsonResponse["subject"]);
        print("subjects.length :" + subjects.length.toString());
        setState(() {
          subjectList = subjects.map((subject) => PaidCourseSubjectModel.fromJson(subject)).toList();
        });
      }
    } else {
      // Handle error here
      print("Failed to load subject list");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Subjects"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
        itemCount: subjectList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        itemBuilder: (context, index) {
          final PaidCourseSubjectModel subject = subjectList[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaidCourseChapterList(course: widget.course,subject: subject,)),
              );
            },
            child: Card(
              elevation: 4, // Add elevation for a raised effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp), // Add rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      topRight: Radius.circular(10.sp),
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: double.infinity, // Make the image full width
                      height: 120.sp, // Set a fixed image height
                      fit: BoxFit.cover, // Adjust this property as needed
                    ),

                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      subject!.subject.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis, // Use ellipsis for overflow
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                  ),
                  // Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
