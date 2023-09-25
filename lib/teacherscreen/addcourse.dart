import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  String courseName = '';
  String courseDetails = '';

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Add Course',
          style: TextStyle(
              color: Colors.black
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 25.h),

              Row(
                children: [
                   Text('Course Logo : ',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500),),
                   SizedBox(
                    width: 30.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                ListTile(
                                  leading:  Icon(Icons.camera),
                                  title:  Text('Camera'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading:  Icon(Icons.image),
                                  title:  Text('Gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: _imageFile != null
                        ? Container(
                      width: 150.w,
                      height: 130.h,
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      ),
                    )
                        :  Icon(Icons.add_a_photo_outlined),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Course Name',
                ),
                onChanged: (value) {
                  setState(() {
                    courseName = value;
                  });
                },
              ),
              SizedBox(height: 16.h),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Course Details',
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    courseDetails = value;
                  });
                },
              ),
              SizedBox(height: 73.h),

              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => OtpVerify()),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      'Add Course',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
