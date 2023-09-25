import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/StudentDoubtDisplay.dart';
import 'doubts.dart';


class DisplayDoubts extends StatefulWidget {
  final String userId;

  DisplayDoubts({required this.userId});

  @override
  _DisplayDoubtsState createState() => _DisplayDoubtsState();
}

class _DisplayDoubtsState extends State<DisplayDoubts> {
  List<StudentDoubtDisplay> doubtsList = [];

  @override
  void initState() {
    super.initState();
    fetchDoubts();
  }

  Future<void> fetchDoubts() async {
    final response = await http.post(
      Uri.parse("https://gyanmeeti.in/API/doubt_fetch.php"),
      body: {
        "userid": widget.userId,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["doubt_fetch"] != null) {
        final fetchedDoubts = List<Map<String, dynamic>>.from(data["doubt_fetch"]);
        setState(() {
          doubtsList = fetchedDoubts.map((doubtData) {
            return StudentDoubtDisplay(
              teacherName: doubtData['teacher_name'],
              doubtDetails: doubtData['doubt_details'],
              doubtImage: doubtData['doubt_image'],
              registerDate: doubtData['register_date'],
              ansDetails: doubtData['ans_details'],
              ansImage: doubtData['ans_image'],
            );
          }).toList();
        });
      } else {
        // Handle the case when no doubts are found
        // You can display a message or handle it in another way
      }
    } else {
      throw Exception('Failed to load doubts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Doubts'),
      ),
      body: ListView.builder(
        itemCount: doubtsList.length,
        itemBuilder: (context, index) {
          final doubt = doubtsList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teacher Name: ${doubt.teacherName ?? "N/A"}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Doubt Details: ${doubt.doubtDetails ?? "N/A"}',
                    ),
                    if (doubt.doubtImage!.isNotEmpty)
                      Image.network(
                        'https://gyanmeeti.in/admin/doubt_image/${doubt.doubtImage}',
                        width: double.infinity,
                        height: 200.sp,
                        fit: BoxFit.cover,
                      ),
                    Text(
                      'Register Date: ${doubt.registerDate ?? "N/A"}',
                    ),
                    Text(
                      'Answer Details: ${doubt.ansDetails ?? "N/A"}',
                    ),
                    if (doubt.ansImage!.isNotEmpty)
                      Image.network(
                        'https://gyanmeeti.in/admin/doubt_solution/${doubt.ansImage}',
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostDoubtPage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Post a Doubt',
      ),
    );
  }
}
