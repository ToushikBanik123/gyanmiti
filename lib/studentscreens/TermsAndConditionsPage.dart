import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/ExamListExamTileModel.dart';
import '../Model/ExamSession.dart';
import 'ExamPage.dart';


class TermsAndConditionsPage extends StatefulWidget {
  late ExamListExamTileModel exam;
  late ExamSession session;
  // Add a constructor to initialize the exam field
  TermsAndConditionsPage({
    required this.exam,
    required this.session,
  });

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false; // Checkbox state
  String _termsAndConditionsText = ''; // API response text

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await http.post(
        Uri.parse('https://gyanmeeti.in/API/exam_terms_conditions.php'),
        body: {'exam_id': widget.exam.id}, // Replace with the actual exam ID
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final termsAndConditions = jsonData['terms_conditions'][0]['terms_conditions'];

        setState(() {
          _termsAndConditionsText = termsAndConditions;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _termsAndConditionsText.isNotEmpty
                        ? _termsAndConditionsText
                        : 'Loading...', // Display a loading message while fetching data
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Text('I agree to the terms and conditions'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isChecked
                        ? () {
                      // Navigate to the next page when the checkbox is checked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExamPage(
                              exam: widget.exam,
                              session: widget.session,
                          ),
                        ),
                      );
                    }
                        : null, // Disable the button if the checkbox is not checked
                    child: Text('Start Your Exam'),
                  ),
                  SizedBox(height: 70.sp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
