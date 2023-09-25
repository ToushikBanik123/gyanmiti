// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gmeeti/Provider/appProvider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import '../Model/ExamListExamTileModel.dart';
// import '../Model/ExamSession.dart';
// import '../Model/QuestionPaper.dart';
// import 'SuccessfullyEnrolled.dart';
// import 'SuccessfullyExamCompleat.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
//
//
// class UserAnswer {
//   String questionId;
//   int? selectedOptionIndex;
//   bool isMarkedForReview; // Add this field
//
//   UserAnswer({
//     required this.questionId,
//     this.selectedOptionIndex,
//     this.isMarkedForReview = false, // Initialize as not marked for review.
//   });
// }
//
// class QuestionPaper {
//   String? id;
//   String? questionNo;
//   String? question;
//   String? questionImage;
//   String? option1;
//   String? option1Image;
//   String? option2;
//   String? option2Image;
//   String? option3;
//   String? option3Image;
//   String? option4;
//   String? option4Image;
//   String? finalAnswer;
//   String? answerDescription;
//   String? answerDescriptionImage;
//
//   QuestionPaper({
//     this.id,
//     this.questionNo,
//     this.question,
//     this.questionImage,
//     this.option1,
//     this.option1Image,
//     this.option2,
//     this.option2Image,
//     this.option3,
//     this.option3Image,
//     this.option4,
//     this.option4Image,
//     this.finalAnswer,
//     this.answerDescription,
//     this.answerDescriptionImage,
//   });
//
//   factory QuestionPaper.fromJson(Map<String, dynamic> json) {
//     return QuestionPaper(
//       id: json['id'],
//       questionNo: json['question_no'],
//       question: json['question'],
//       questionImage: json['question_image'],
//       option1: json['option1'],
//       option1Image: json['option1_image'],
//       option2: json['option2'],
//       option2Image: json['option2_image'],
//       option3: json['option3'],
//       option3Image: json['option3_image'],
//       option4: json['option4'],
//       option4Image: json['option4_image'],
//       finalAnswer: json['final_answer'],
//       answerDescription: json['answer_description'],
//       answerDescriptionImage: json['answer_description_image'],
//     );
//   }
// }
//
// class OptionWidget extends StatelessWidget {
//   final String? text;
//   final String? image;
//   final int number;
//
//   OptionWidget({required this.text, required this.image, required this.number});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (text != null)
//           Text(
//             text!,
//             style: TextStyle(fontSize: 18.0),
//           ),
//         if (image != null && image!.isNotEmpty)
//           Image.network(
//             "https://gyanmeeti.in/admin/option${number}_image/${image}",
//             height: 150.0,
//           ),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
//
// class ExamPage extends StatefulWidget {
//   late ExamListExamTileModel exam;
//   late ExamSession session;
//
//   ExamPage({
//     required this.exam,
//     required this.session,
//   });
//
//   @override
//   _ExamPageState createState() => _ExamPageState();
// }
//
// class _ExamPageState extends State<ExamPage> {
//   List<QuestionPaper> questionPapers = [];
//   List<UserAnswer> userAnswers = [];
//
//   void toggleMarkForReview(int questionIndex) {
//     setState(() {
//       userAnswers[questionIndex].isMarkedForReview =
//           !userAnswers[questionIndex].isMarkedForReview;
//     });
//   }
//
//   void clearSelectedAnswer(int questionIndex) {
//     setState(() {
//       userAnswers[questionIndex].selectedOptionIndex = null;
//     });
//   }
//
//   Color getCircleColor(UserAnswer userAnswer) {
//     if (userAnswer.isMarkedForReview) {
//       return Colors.red;
//     }
//     if (userAnswer.selectedOptionIndex == null) {
//       return Colors.blue;
//     } else {
//       return Colors.green;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<List<QuestionPaper>> fetchQuestionPapers(
//       String examId, String sessionId) async {
//     const apiUrl = 'https://gyanmeeti.in/API/question_paper.php';
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         'exam_id': examId,
//         'session_id': sessionId,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//
//       if (jsonData['question_list'] != null) {
//         final List<QuestionPaper> questionPapers = List<QuestionPaper>.from(
//           jsonData['question_list'].map((data) => QuestionPaper.fromJson(data)),
//         );
//         return questionPapers;
//       } else {
//         throw Exception('No questions found');
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   void fetchData() async {
//     try {
//       final examId = widget.exam.id; // Replace with your exam ID
//       final sessionId = widget.session.id; // Replace with your session ID
//
//       final fetchedQuestionPapers =
//           await fetchQuestionPapers(examId!, sessionId!);
//
//       setState(() {
//         questionPapers = fetchedQuestionPapers;
//         userAnswers = List.generate(
//           questionPapers.length,
//           (index) => UserAnswer(
//             questionId: questionPapers[index].id ?? '',
//             selectedOptionIndex: null,
//           ),
//         );
//       });
//     } catch (e) {
//       // Handle errors appropriately
//       print('Error: $e');
//     }
//   }
//
//   void selectOption(int optionIndex, int questionIndex) {
//     setState(() {
//       userAnswers[questionIndex].selectedOptionIndex = optionIndex;
//     });
//   }
//
//   void submitAnswers({required UserId}) async {
//     final apiUrl = 'https://gyanmeeti.in/API/submit_answer.php';
//     final userId = UserId; // Replace with the user's ID
//     final examId = widget.exam.id!; // Replace with the exam ID
//     final sessionId = widget.session.id!; // Replace with the session ID
//     final time = widget.session.duration;
//
//     for (int i = 0; i < questionPapers.length; i++) {
//       final questionPaper = questionPapers[i];
//       final userAnswer = userAnswers[i];
//
//       if (userAnswer.selectedOptionIndex != null) {
//         final questionNumber = questionPaper.questionNo!;
//         final answer = userAnswer.selectedOptionIndex! + 1;
//
//         final response = await http.post(
//           Uri.parse(apiUrl),
//           body: {
//             'exam_id': examId,
//             'session_id': sessionId,
//             'user_id': userId,
//             'question_number': questionNumber,
//             'answer': answer.toString(),
//           },
//         );
//
//         if (response.statusCode == 200) {
//           final jsonData = json.decode(response.body);
//           final message = jsonData['message'];
//           print('Question No: $questionNumber - $message');
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SuccessfullyExamCompleat()),
//           );
//         } else {
//           print('Failed to submit answer for Question No: $questionNumber');
//         }
//       }
//     }
//   }
//
//
//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView.builder(
//         itemCount: questionPapers.length,
//         itemBuilder: (context, index) {
//           final questionPaper = questionPapers[index];
//           final userAnswer = userAnswers[index];
//
//           return ListTile(
//             leading: Container(
//               width: 32.0,
//               height: 32.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: getCircleColor(userAnswer),
//               ),
//               child: Center(
//                 child: Text(
//                   questionPaper.questionNo ?? '',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             title: Text('Question ${questionPaper.questionNo}'),
//             onTap: () {
//               // Handle tapping on a question in the drawer.
//               // You can navigate to the corresponding question in the main content.
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColorfulSafeArea(
//         color: Colors.white,
//         child: Scaffold(
//           appBar: AppBar(
//             // leading: IconButton(
//             //   icon: Icon(Icons.menu), // Use the menu icon for the drawer.
//             //   onPressed: () {
//             //     Scaffold.of(context).openDrawer();
//             //   },
//             // ),
//             title: Text(widget.exam.examName.toString()),
//           ),
//           drawer: Drawer(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 50.sp,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 32.sp,
//                           height: 32.sp,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.red,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.sp,
//                         ),
//                         const Text("Marked"),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 32.sp,
//                           height: 32.sp,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.green,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.sp,
//                         ),
//                         const Text("Answered"),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           width: 32.sp,
//                           height: 32.sp,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.sp,
//                         ),
//                         const Text("Left"),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25.sp,
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: questionPapers.length,
//                   itemBuilder: (context, index) {
//                     final questionPaper = questionPapers[index];
//                     final userAnswer = userAnswers[index];
//
//                     return ListTile(
//                       leading: Container(
//                         width: 32.sp,
//                         height: 32.sp,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: getCircleColor(userAnswer),
//                         ),
//                         // child: Center(
//                         //   child: Text(
//                         //     questionPaper.questionNo ?? '',
//                         //     style: TextStyle(
//                         //       color: Colors.white,
//                         //       fontWeight: FontWeight.bold,
//                         //     ),
//                         //   ),
//                         // ),
//                       ),
//                       title: Text('Question ${questionPaper.questionNo}'),
//                       onTap: () {
//                         // Handle tapping on a question in the drawer.
//                         // You can navigate to the corresponding question in the main content.
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           body: questionPapers.isEmpty
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                         itemCount: questionPapers.length,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final questionPaper = questionPapers[index];
//
//                           return Card(
//                             margin: EdgeInsets.all(16..sp),
//                             color: userAnswers[index].isMarkedForReview
//                                 ? Colors
//                                     .red // Change tile color if marked for review.
//                                 : null, // Use default color if not marked for review.
//                             child: Padding(
//                               padding: EdgeInsets.all(16.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Question No: ${questionPaper.questionNo}',
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(height: 8.sp),
//                                   if (questionPaper.question != null)
//                                     Text(
//                                       questionPaper.question.toString(),
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                       ),
//                                     ),
//                                   if (questionPaper.questionImage != null &&
//                                       questionPaper.questionImage!.isNotEmpty)
//                                     Image.network(
//                                       'https://gyanmeeti.in/admin/question_image/${questionPaper.questionImage}',
//                                       height: 150.0,
//                                     ),
//                                   SizedBox(height: 16.sp),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       ListTile(
//                                         title: OptionWidget(
//                                           text: questionPaper.option1,
//                                           image: questionPaper.option1Image,
//                                           number: 1,
//                                         ),
//                                         leading: Radio<int>(
//                                           value: 0,
//                                           groupValue:
//                                               userAnswers[index].selectedOptionIndex,
//                                           onChanged: (int? value) {
//                                             selectOption(value!, index);
//                                           },
//                                         ),
//                                       ),
//                                       ListTile(
//                                         title: OptionWidget(
//                                           text: questionPaper.option2,
//                                           image: questionPaper.option2Image,
//                                           number: 2,
//                                         ),
//                                         leading: Radio<int>(
//                                           value: 1,
//                                           groupValue:
//                                               userAnswers[index].selectedOptionIndex,
//                                           onChanged: (int? value) {
//                                             selectOption(value!, index);
//                                           },
//                                         ),
//                                       ),
//                                       ListTile(
//                                         title: OptionWidget(
//                                           text: questionPaper.option3,
//                                           image: questionPaper.option3Image,
//                                           number: 3,
//                                         ),
//                                         leading: Radio<int>(
//                                           value: 2,
//                                           groupValue:
//                                               userAnswers[index].selectedOptionIndex,
//                                           onChanged: (int? value) {
//                                             selectOption(value!, index);
//                                           },
//                                         ),
//                                       ),
//                                       ListTile(
//                                         title: OptionWidget(
//                                           text: questionPaper.option4,
//                                           image: questionPaper.option4Image,
//                                           number: 4,
//                                         ),
//                                         leading: Radio<int>(
//                                           value: 3,
//                                           groupValue:
//                                               userAnswers[index].selectedOptionIndex,
//                                           onChanged: (int? value) {
//                                             selectOption(value!, index);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16.sp),
//                                   Center(
//                                     child: ElevatedButton.icon(
//                                       style: ElevatedButton.styleFrom(
//                                         primary: userAnswers[index].isMarkedForReview
//                                             ? Colors
//                                                 .yellow // Yellow color when marked for review.
//                                             : Colors
//                                                 .red, // Red color when not marked for review.
//                                       ),
//                                       onPressed: () {
//                                         toggleMarkForReview(index);
//                                       },
//                                       icon: Icon(
//                                         Icons.star,
//                                         color: Colors.white,
//                                       ),
//                                       label: Text(
//                                         userAnswers[index].isMarkedForReview
//                                             ? 'Marked For Review' // Text when marked for review.
//                                             : 'Mark For Review', // Text when not marked for review.
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 16.sp),
//                                   Center(
//                                     child: ElevatedButton.icon(
//                                       style: ElevatedButton.styleFrom(
//                                         primary: Colors.blue, // Blue color
//                                       ),
//                                       onPressed: () {
//                                         clearSelectedAnswer(index);
//                                       },
//                                       icon: const Icon(
//                                         Icons.clear, // Relevant clear icon
//                                         color: Colors.white,
//                                       ),
//                                       label: const Text(
//                                         'Clear Answer', // Text as "Clear Answer"
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     Consumer<AppProvider>(builder: (context, provider, child) {
//                       return GestureDetector(
//                         onTap: () {
//                           submitAnswers(UserId: provider.appUser.id);
//                         },
//                         child: Container(
//                             height: 45.sp,
//                             width: 150.sp,
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(40.sp),
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Submit",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16.sp,
//                               ),
//                             )),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//           // floatingActionButton: ,
//         )
//     );
//   }
// }

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../Model/ExamListExamTileModel.dart';
import '../Model/ExamSession.dart';
import '../Model/QuestionPaper.dart';
import '../Provider/appProvider.dart';
import 'SuccessfullyEnrolled.dart';
import 'SuccessfullyExamCompleat.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class UserAnswer {
  String questionId;
  int? selectedOptionIndex;
  bool isMarkedForReview; // Add this field

  UserAnswer({
    required this.questionId,
    this.selectedOptionIndex,
    this.isMarkedForReview = false, // Initialize as not marked for review.
  });
}

class OptionWidget extends StatelessWidget {
  final String? text;
  final String? image;
  final int number;

  OptionWidget({required this.text, required this.image, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != null)
          Text(
            text!,
            style: TextStyle(fontSize: 18.0),
          ),
        if (image != null && image!.isNotEmpty)
          Image.network(
            "https://gyanmeeti.in/admin/option${number}_image/${image}",
            height: 150.0,
          ),
      ],
    );
  }
}

class ExamPage extends StatefulWidget {
  late ExamListExamTileModel exam;
  late ExamSession session;

  ExamPage({
    required this.exam,
    required this.session,
  });

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List<QuestionPaper> questionPapers = [];
  List<UserAnswer> userAnswers = [];
  late Timer _timer;
  Duration _remainingTime = Duration();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<AppProvider>(context);
    _remainingTime =
        Duration(minutes: int.parse(widget.session.duration.toString()));
    _startCountdownTimer(provider);
  }

  // void _startCountdownTimer(AppProvider provider) {
  //   const oneSecond = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSecond, (timer) {
  //     setState(() {
  //       if (_remainingTime > Duration(seconds: 0)) {
  //         _remainingTime -= oneSecond;
  //       } else if (_remainingTime < Duration(seconds: 1)){
  //         submitAnswers(UserId: provider.appUser.id);
  //         _timer.cancel();
  //         submitAnswers(UserId: provider.appUser.id);
  //       }
  //     });
  //   });
  // }

  void _startCountdownTimer(AppProvider provider) {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_remainingTime > Duration(seconds: 0)) {
          _remainingTime -= oneSecond;
        } else {
          print("Countdown timer reached zero. Submitting answers...");
          _timer.cancel(); // Cancel the timer to prevent further execution.
          submitAnswers(UserId: provider.appUser.id);

          // Add navigation code here if needed.
          // For example, you can use Navigator to navigate to the next page.
          // Navigator.of(context).push(...);
        }
      });
    });
  }

  Future<List<QuestionPaper>> fetchQuestionPapers(
      String examId, String sessionId) async {
    const apiUrl = 'https://gyanmeeti.in/API/question_paper.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'exam_id': examId,
        'session_id': sessionId,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['question_list'] != null) {
        final List<QuestionPaper> questionPapers = List<QuestionPaper>.from(
          jsonData['question_list'].map((data) => QuestionPaper.fromJson(data)),
        );
        return questionPapers;
      } else {
        throw Exception('No questions found');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchData() async {
    try {
      final examId = widget.exam.id; // Replace with your exam ID
      final sessionId = widget.session.id; // Replace with your session ID

      final fetchedQuestionPapers =
          await fetchQuestionPapers(examId!, sessionId!);

      setState(() {
        questionPapers = fetchedQuestionPapers;
        userAnswers = List.generate(
          questionPapers.length,
          (index) => UserAnswer(
            questionId: questionPapers[index].id ?? '',
            selectedOptionIndex: null,
          ),
        );
      });
    } catch (e) {
      // Handle errors appropriately
      print('Error: $e');
    }
  }

  void selectOption(int optionIndex, int questionIndex) {
    setState(() {
      userAnswers[questionIndex].selectedOptionIndex = optionIndex;
    });
  }

  void toggleMarkForReview(int questionIndex) {
    setState(() {
      userAnswers[questionIndex].isMarkedForReview =
          !userAnswers[questionIndex].isMarkedForReview;
    });
  }

  void clearSelectedAnswer(int questionIndex) {
    setState(() {
      userAnswers[questionIndex].selectedOptionIndex = null;
    });
  }

  Color getCircleColor(UserAnswer userAnswer) {
    if (userAnswer.isMarkedForReview) {
      return Colors.red;
    }
    if (userAnswer.selectedOptionIndex == null) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  void submitAnswers({required UserId}) async {
    final apiUrl = 'https://gyanmeeti.in/API/submit_answer.php';
    final userId = UserId; // Replace with the user's ID
    final examId = widget.exam.id!; // Replace with the exam ID
    final sessionId = widget.session.id!; // Replace with the session ID
    final time = widget.session.duration;

    for (int i = 0; i < questionPapers.length; i++) {
      final questionPaper = questionPapers[i];
      final userAnswer = userAnswers[i];

      if (userAnswer.selectedOptionIndex != null) {
        final questionNumber = questionPaper.questionNo!;
        final answer = userAnswer.selectedOptionIndex! + 1;

        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'exam_id': examId,
            'session_id': sessionId,
            'user_id': userId,
            'question_number': questionNumber,
            'answer': answer.toString(),
          },
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final message = jsonData['message'];
          print(message.toString());
          print('Question No: $questionNumber - $message');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessfullyExamCompleat()),
          );
        } else {
          print('Failed to submit answer for Question No: $questionNumber');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your widget build code here

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.examName.toString()),
        backgroundColor:
            _remainingTime <= Duration(minutes: 15) ? Colors.red : Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${_remainingTime.inMinutes}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    const Text("Marked"),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    const Text("Answered"),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 32.sp,
                      height: 32.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    const Text("Left"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.sp,
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: questionPapers.length,
            //   itemBuilder: (context, index) {
            //     final questionPaper = questionPapers[index];
            //     final userAnswer = userAnswers[index];
            //
            //     return ListTile(
            //       leading: Container(
            //         width: 32.sp,
            //         height: 32.sp,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: getCircleColor(userAnswer),
            //         ),
            //         alignment: Alignment.center,
            //         child: Text('${index + 1}',
            //           style: TextStyle(
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       title: Text('Question ${index + 1}'),
            //       onTap: () {
            //         // Handle tapping on a question in the drawer.
            //         // You can navigate to the corresponding question in the main content.
            //       },
            //     );
            //   },
            // ),

            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // You can adjust the number of columns as needed
              ),
              itemCount: questionPapers.length,
              itemBuilder: (context, index) {
                final questionPaper = questionPapers[index];
                final userAnswer = userAnswers[index];

                return Container(
                  width: 32.sp,
                  height: 32.sp,
                  margin: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getCircleColor(userAnswer),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )

          ],
        ),
      ),
      body: questionPapers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: questionPapers.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final questionPaper = questionPapers[index];

                      return Card(
                        margin: EdgeInsets.all(16.sp),
                        color: userAnswers[index].isMarkedForReview
                            ? Colors
                                .red // Change tile color if marked for review.
                            : null, // Use default color if not marked for review.
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question No: ${questionPaper.questionNo}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.sp),
                              if (questionPaper.question != null)
                                Text(
                                  questionPaper.question.toString(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              if (questionPaper.questionImage != null &&
                                  questionPaper.questionImage!.isNotEmpty)
                                Image.network(
                                  'https://gyanmeeti.in/admin/question_image/${questionPaper.questionImage}',
                                  height: 150.0,
                                ),
                              SizedBox(height: 16.sp),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: OptionWidget(
                                      text: questionPaper.option1,
                                      image: questionPaper.option1Image,
                                      number: 1,
                                    ),
                                    leading: Radio<int>(
                                      value: 0,
                                      groupValue: userAnswers[index]
                                          .selectedOptionIndex,
                                      onChanged: (int? value) {
                                        selectOption(value!, index);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: OptionWidget(
                                      text: questionPaper.option2,
                                      image: questionPaper.option2Image,
                                      number: 2,
                                    ),
                                    leading: Radio<int>(
                                      value: 1,
                                      groupValue: userAnswers[index]
                                          .selectedOptionIndex,
                                      onChanged: (int? value) {
                                        selectOption(value!, index);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: OptionWidget(
                                      text: questionPaper.option3,
                                      image: questionPaper.option3Image,
                                      number: 3,
                                    ),
                                    leading: Radio<int>(
                                      value: 2,
                                      groupValue: userAnswers[index]
                                          .selectedOptionIndex,
                                      onChanged: (int? value) {
                                        selectOption(value!, index);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: OptionWidget(
                                      text: questionPaper.option4,
                                      image: questionPaper.option4Image,
                                      number: 4,
                                    ),
                                    leading: Radio<int>(
                                      value: 3,
                                      groupValue: userAnswers[index]
                                          .selectedOptionIndex,
                                      onChanged: (int? value) {
                                        selectOption(value!, index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.sp),
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: userAnswers[index]
                                            .isMarkedForReview
                                        ? Colors
                                            .yellow // Yellow color when marked for review.
                                        : Colors
                                            .red, // Red color when not marked for review.
                                  ),
                                  onPressed: () {
                                    toggleMarkForReview(index);
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    userAnswers[index].isMarkedForReview
                                        ? 'Marked For Review' // Text when marked for review.
                                        : 'Mark For Review', // Text when not marked for review.
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.sp),
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Blue color
                                  ),
                                  onPressed: () {
                                    clearSelectedAnswer(index);
                                  },
                                  icon: const Icon(
                                    Icons.clear, // Relevant clear icon
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Clear Answer', // Text as "Clear Answer"
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer<AppProvider>(builder: (context, provider, child) {
                    return GestureDetector(
                      onTap: () {
                        submitAnswers(UserId: provider.appUser.id);
                      },
                      child: Container(
                          height: 45.sp,
                          width: 150.sp,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(40.sp),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          )),
                    );
                  }),
                  SizedBox(height: 100.sp),
                ],
              ),
            ),
    );
  }
}
