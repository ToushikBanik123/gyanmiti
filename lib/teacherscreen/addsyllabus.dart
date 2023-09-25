import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SyllabusPage extends StatefulWidget {
  @override
  _SyllabusPageState createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  String? _filePath;

  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });
      }
    } catch (e) {
      print('Error while picking the file: $e');
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
        title: Text('Add Syllabus',
          style: TextStyle(
              color: Colors.black
          ),),
      ),

      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),

              TextButton.icon(
                onPressed: _openFilePicker,
                icon: Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                label: Text('Add pdf  '),
              ),
              SizedBox(height: 20),
              if (_filePath != null)
                SizedBox(height: 20),
              Text(
                'Selected PDF: $_filePath',
                style: TextStyle(fontSize: 16),
              ),
              // Display the PDF using a PDF viewer widget or perform other operations with the selected file.
              Spacer(),

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
                      'Add Syllabus',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
