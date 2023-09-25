import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/Course.dart';
import '../../Model/CourseCategory.dart';
import 'freeclass.dart';

class CourseListScreen extends StatelessWidget {
  final CourseCategory category;

  CourseListScreen({required this.category});

  Future<List<Course>> fetchCourses(String category) async {
    final apiUrl = "https://gyanmeeti.in/API/free_course_fetch.php";
    final response = await http.post(Uri.parse(apiUrl), body: {'category': category});

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey("free_course")) {
        final List<Course> courses = (data["free_course"] as List).map((courseData) {
          return Course(
            id: courseData["id"].toString(),
            courseName: courseData["course_name"],
            logo: courseData["logo"],
          );
        }).toList();

        return courses;
      } else {
        throw Exception(data["message"] ?? "No Free Course found");
      }
    } else {
      throw Exception("Failed to load courses");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.categoryName}'),
      ),
      body: FutureBuilder<List<Course>>(
        future: fetchCourses(category.id), // Call the fetchCourses function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No courses found.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data?.length ?? 0, // Ensure itemCount is not null
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return GestureDetector(
                  onTap: (){
                    //FreeClassListScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FreeClassListScreen(course: course,)),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
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
                          child: Image.network(
                            "https://gyanmeeti.in/admin/course_logo/${course.logo}",
                            width: double.infinity, // Make the image full width
                            height: 120.sp, // Set a fixed image height
                            fit: BoxFit.cover, // Adjust this property as needed
                          ),

                        ),
                        Column(
                          children: [
                            Text(
                              course.courseName,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          }
        },
      ),

    );
  }
}
