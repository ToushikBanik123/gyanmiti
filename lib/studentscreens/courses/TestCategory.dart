import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gm/studentscreens/courses/testseries.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/ExamCategoryModel.dart';
class TestCategory extends StatefulWidget {
  const TestCategory({Key? key}) : super(key: key);

  @override
  State<TestCategory> createState() => _TestCategoryState();
}

class _TestCategoryState extends State<TestCategory> {

  Future<List<ExamCategoryModel>> fetchExamCategories() async {
    final response = await http.get(Uri.parse("https://gyanmeeti.in/API/exam_category.php"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['category'];
      return jsonList.map((json) => ExamCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exam categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: const Text(
          'Test Category',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<ExamCategoryModel>>(
        future: fetchExamCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No exam categories available.'),
            );
          } else {
            final categories = snapshot.data!;
            // return ListView.builder(
            //   itemCount: categories.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(categories[index].categoryName),
            //       subtitle: Text(categories[index].id),
            //       // You can display the category image here.
            //     );
            //   },
            // );
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
                      // MaterialPageRoute(builder: (context) => TestSeries(category: category.categoryName,)),
                      MaterialPageRoute(builder: (context) => ExamTabBar(category: category.categoryName)),
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
                            "https://gyanmeeti.in/admin/exam_category_image/${category!.categoryImage}",
                            width: double.infinity, // Make the image full width
                            height: 120.sp, // Set a fixed image height
                            fit: BoxFit.cover, // Adjust this property as needed
                          ),

                        ),
                        const Spacer(),
                        // SizedBox(height: 8.sp), // Add some space between the image and text
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
                        const Spacer(),
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

