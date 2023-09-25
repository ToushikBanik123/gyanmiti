import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/Course.dart';
import '../../Model/FreeClassModel.dart';
import 'FreeClassDetailsScreen.dart';


class FreeClassListScreen extends StatelessWidget {
  final Course course;

  FreeClassListScreen({required this.course});

  Future<List<FreeClass>> fetchFreeClasses(String courseId) async {
    final apiUrl = "https://gyanmeeti.in/API/free_class_fetch.php";
    final response = await http.post(Uri.parse(apiUrl), body: {'course_id': courseId});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey("free_class")) {
        final List<FreeClass> freeClasses = (data["free_class"] as List).map((classData) {
          return FreeClass(
            id: classData["id"].toString(),
            className: classData["class_name"],
            registerDate: classData["register_date"],
          );
        }).toList();

        return freeClasses;
      } else {
        throw Exception(data["message"] ?? "No Free Class found");
      }
    } else {
      throw Exception("Failed to load free classes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course.courseName}'),
      ),
      body: FutureBuilder<List<FreeClass>>(
        future: fetchFreeClasses(course.id), // Call fetchFreeClasses here
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
                'No free classes found.',
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
              padding: EdgeInsets.all(16.sp), // Adjust padding as needed
              itemBuilder: (context, index) {
                final freeClass = snapshot.data![index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FreeClassDetailsScreen(freeClass: freeClass,)),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.sp), // Adjust padding as needed
                          child: Text(
                            freeClass.className,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          freeClass.registerDate,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
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


