import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExamForm extends StatefulWidget {
  @override
  _AddExamFormState createState() => _AddExamFormState();
}

class _AddExamFormState extends State<AddExamForm> {
  TextEditingController _examNameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _marksController = TextEditingController();
  List<Question> _questions = [];

  @override
  void dispose() {
    _examNameController.dispose();
    _timeController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(Question());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Add Exam Page',
          style: TextStyle(
              color: Colors.black
          ),),
      ),

      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Exam Name :',style: TextStyle(fontWeight: FontWeight.w500),)),
                  Expanded(
                    child: TextField(
                      controller: _examNameController,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(child: Text('Total Time :',style: TextStyle(fontWeight: FontWeight.w500),)),
                  Expanded(
                    child: TextField(
                      controller: _timeController,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(child: Text('Total Marks :',style: TextStyle(fontWeight: FontWeight.w500),)),
                  Expanded(
                    child: TextField(
                      controller: _marksController,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30.0),
              Column(
                children: _questions.asMap().entries.map((entry) {
                  int index = entry.key;
                  Question question = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text('Question ${index + 1} :-',style: TextStyle(fontWeight: FontWeight.w500),),
                      TextField(),
                      SizedBox(height: 8.0),
                      Column(
                        children: question.options.asMap().entries.map((entry) {
                          int optionIndex = entry.key;
                          String optionLabel = String.fromCharCode(97 + optionIndex); // i, ii, iii, iv
                          String hintText = 'Option ${optionIndex + 1}';

                          return Row(
                            children: [
                              SizedBox(width: 10.0),
                              Text('$optionLabel)',style: TextStyle(fontWeight: FontWeight.w500),),
                              SizedBox(width: 15.0),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: hintText,
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(width: 25.0),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Correct Answer',
                            hintStyle: TextStyle(
                                fontSize: 12.sp
                            )
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  );
                }).toList(),
              ),
              TextButton.icon(
                onPressed: _addQuestion,
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
                label: Text('Add Question'),
              ),
              SizedBox(height: 50.0),

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
                      'Add Exam Paper',
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

class Question {
  String question;
  List<String> options;
  String answer;

  Question({this.question = '', this.options = const ['', '', '', ''], this.answer = ''});
}


