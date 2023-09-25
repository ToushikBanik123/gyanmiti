import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/CourseCategory.dart';
import 'CourseListScreen.dart';

class CourseCategoryScreen extends StatefulWidget {
  @override
  _CourseCategoryScreenState createState() => _CourseCategoryScreenState();
}

class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  late Future<List<CourseCategory>> futureCourseCategories;

  @override
  void initState() {
    super.initState();
    futureCourseCategories = fetchCourseCategories();
  }

  Future<List<CourseCategory>> fetchCourseCategories() async {
    final response = await http.get(Uri.parse('https://gyanmeeti.in/API/course_category.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['category'];
      return data.map((json) => CourseCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load course categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Categories'),
      ),
      body: FutureBuilder<List<CourseCategory>>(
        future: futureCourseCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No categories found.');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data?.length,
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              itemBuilder: (context, index) {
                final category = snapshot.data?[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CourseListScreen(category: category)),
                    );
                  },
                  child: Card(
                    elevation: 4, // Add elevation for a raised effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp), // Add rounded corners
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            topRight: Radius.circular(10.sp),
                          ),
                          child: Image.network(
                            "https://gyanmeeti.in/admin/category_image/${category!.categoryImage}",
                            width: double.infinity, // Make the image full width
                            height: 120.sp, // Set a fixed image height
                            fit: BoxFit.cover, // Adjust this property as needed
                          ),

                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            category!.categoryName,
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
                        Spacer(),
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
