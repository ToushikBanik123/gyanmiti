import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Model/User.dart';
import '../Provider/appProvider.dart';

class PostDoubtPage extends StatefulWidget {
  @override
  _PostDoubtPageState createState() => _PostDoubtPageState();
}

class _PostDoubtPageState extends State<PostDoubtPage> {
  TextEditingController _doubtController = TextEditingController();
  List<Map<String, dynamic>> teacherList = [];
  String selectedTeacher = "";
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _doubtController = TextEditingController();
    fetchTeacherData();
  }

  @override
  void dispose() {
    _doubtController.dispose();
    super.dispose();
  }

  Future<void> fetchTeacherData() async {
    final response = await http.get(Uri.parse("https://gyanmeeti.in/API/teacher_name_fetch.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["teacher_name"] != null) {
        setState(() {
          teacherList = List<Map<String, dynamic>>.from(data["teacher_name"]);
        });
      }
    } else {
      throw Exception('Failed to load teacher data');
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void _postDoubt({required User appuser}) async {
    String doubtText = _doubtController.text;
    if (selectedTeacher.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please select a teacher.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    if (doubtText.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter your doubt text.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    final uri = Uri.parse("https://gyanmeeti.in/API/doubt_post.php");

    final request = http.MultipartRequest('POST', uri);
    request.fields['userid'] = appuser.id.toString();
    request.fields['teacher_id'] = selectedTeacher;
    request.fields['doubt_text'] = doubtText;

    if (selectedImage != null) {
      request.files.add(http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      ));
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final data = json.decode(responseString);

        if (data["message"] == "Doubt Post Successful") {
          Fluttertoast.showToast(
            msg: "Doubt posted successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Clear the input fields and selected image
          _doubtController.clear();
          setState(() {
            selectedTeacher = "";
            selectedImage = null;
          });
        } else {
          Fluttertoast.showToast(
            msg: "Doubt post failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed to post doubt. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: const Text(
          'Doubt Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Your Teacher',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  DropdownButton<String>(
                    isExpanded: true, // Makes the dropdown take full width
                    hint: Text('Select a teacher'),
                    value: selectedTeacher.isNotEmpty ? selectedTeacher : null, // Set a default value
                    onChanged: (newValue) {
                      setState(() {
                        selectedTeacher = newValue!;
                      });
                    },
                    items: teacherList.map((teacher) {
                      return DropdownMenuItem<String>(
                        value: teacher['id'].toString(),
                        child: Text(teacher['teacher_name']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                // Display selected image before the row
                if (selectedImage != null)
                  Expanded(
                    child: Image.file(
                      selectedImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _doubtController,
                    decoration: InputDecoration(
                      hintText: 'Enter your doubt',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _selectImage, // Call the image selection function
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Consumer<AppProvider>(builder: (context, provider, child) {
              return Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 50.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: () {
                        _postDoubt(appuser: provider.appUser);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Change the button color here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r), // Adjust the corner radius here
                        ),
                      ),
                      child: Text('Post Doubt'),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
