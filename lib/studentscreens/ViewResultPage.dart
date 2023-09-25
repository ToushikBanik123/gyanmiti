import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CorectResult {
  List<Answer>? correctAnswers;

  CorectResult({
    this.correctAnswers,
  });

  factory CorectResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> correctAnswersList = json['correct_answers'];
    final List<Answer> correctAnswers = correctAnswersList.map((answer) => Answer.fromJson(answer)).toList();

    return CorectResult(
      correctAnswers: correctAnswers,
    );
  }
}
class Answer {
  String? question;
  String? question_image;
  String? answer;
  String? answer_description;
  String? answer_description_image;

  Answer({
    this.question,
    this.question_image,
    this.answer,
    this.answer_description,
    this.answer_description_image,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      question: json['question'],
      question_image: json['question_image'],
      answer: json['answer'],
      answer_description: json['answer_description'],
      answer_description_image: json['answer_description_image'],
    );
  }
}
class ResultModel {
  final String? yourScore;
  final String? percentile;
  final String? totalCorrectAnswers;
  final String? totalWrongAnswers;
  final String? unAttempted;
  final String? accuracy;

  ResultModel({
    this.yourScore,
    this.percentile,
    this.totalCorrectAnswers,
    this.totalWrongAnswers,
    this.unAttempted,
    this.accuracy,
  });
}

class IncorrectAnswerResult {
  List<IncorrectAnswer>? incorrectAnswers;

  IncorrectAnswerResult({
    this.incorrectAnswers,
  });

  factory IncorrectAnswerResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> incorrectAnswersList = json['incorrect_answers'];
    final List<IncorrectAnswer> incorrectAnswers =
    incorrectAnswersList.map((answer) => IncorrectAnswer.fromJson(answer)).toList();

    return IncorrectAnswerResult(
      incorrectAnswers: incorrectAnswers,
    );
  }
}
class IncorrectAnswer {
  String? question;
  String? questionImage;
  String? answer;
  String? answerDescription;
  String? answerDescriptionImage;

  IncorrectAnswer({
    required this.question,
    required this.questionImage,
    required this.answer,
    required this.answerDescription,
    required this.answerDescriptionImage,
  });

  factory IncorrectAnswer.fromJson(Map<String, dynamic> json) {
    return IncorrectAnswer(
      question: json['question'],
      questionImage: json['question_image'],
      answer: json['answer'],
      answerDescription: json['answer_description'],
      answerDescriptionImage: json['answer_description_image'],
    );
  }
}

class UnattemptedAnswerResult {
  List<UnattemptedAnswer>? unattemptedAnswers;

  UnattemptedAnswerResult({
    this.unattemptedAnswers,
  });

  factory UnattemptedAnswerResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> unattemptedAnswersList = json['unattempted_answers'];
    final List<UnattemptedAnswer> unattemptedAnswers =
    unattemptedAnswersList.map((answer) => UnattemptedAnswer.fromJson(answer)).toList();

    return UnattemptedAnswerResult(
      unattemptedAnswers: unattemptedAnswers,
    );
  }
}
class UnattemptedAnswer {
  String? question;
  String? questionImage;
  String? finalAnswer;
  String? answerDescription;
  String? answerDescriptionImage;

  UnattemptedAnswer({
    required this.question,
    required this.questionImage,
    required this.finalAnswer,
    required this.answerDescription,
    required this.answerDescriptionImage,
  });

  factory UnattemptedAnswer.fromJson(Map<String, dynamic> json) {
    return UnattemptedAnswer(
      question: json['question'],
      questionImage: json['question_image'],
      finalAnswer: json['final_answer'],
      answerDescription: json['answer_description'],
      answerDescriptionImage: json['answer_description_image'],
    );
  }
}



Future<ResultModel?> fetchResultData(
    String examId, String sessionId, String userId) async {
  final response = await http.post(
    Uri.parse('https://gyanmeeti.in/API/result_display.php'),
    body: {
      'exam_id': examId,
      'session_id': sessionId,
      'user_id': userId,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data.containsKey('result_display') &&
        data['result_display'].length > 0) {
      final resultData = data['result_display'][0];
      return ResultModel(
        yourScore: resultData['your_score'],
        percentile: resultData['percentile'],
        totalCorrectAnswers: resultData['total_correct_answers'],
        totalWrongAnswers: resultData['total_wrong_answers'],
        unAttempted: resultData['un_attempt'],
        accuracy: resultData['Accuracy'],
      );
    } else {
      // Handle no data or invalid response format
      return null;
    }
  } else {
    // Handle HTTP error
    return null;
  }
}

class ViewResultPage extends StatefulWidget {
  final String examId;
  final String sessionId;
  final String userId;

  ViewResultPage({
    required this.examId,
    required this.sessionId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> with SingleTickerProviderStateMixin {
  Future<ResultModel?>? _resultData;
  late TabController _tabController;

  Future<CorectResult?> fetchCorrectAnswer({required String examId, required String sessionId, required String userId}) async {
    final apiUrl = 'https://gyanmeeti.in/API/correct_answers.php'; // Replace with your API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'exam_id': examId,
        'session_id': sessionId,
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return CorectResult.fromJson(responseData);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load exam result');
    }
  }

  // Future<CorectResult?> fetchIncorrectAnswer({required String examId, required String sessionId, required String userId}) async {
  //   final apiUrl = 'https://gyanmeeti.in/API/incorrect_answers.php'; // Replace with your API URL
  //
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     body: {
  //       'exam_id': examId,
  //       'session_id': sessionId,
  //       'user_id': userId,
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     return CorectResult.fromJson(responseData);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // throw an exception.
  //     throw Exception('Failed to load exam result');
  //   }
  // }
  Future<IncorrectAnswerResult?> fetchIncorrectAnswers({required String examId, required String sessionId, required String userId}) async {
    final apiUrl = 'https://gyanmeeti.in/API/incorrect_answers.php'; // Replace with your new API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'exam_id': examId,
        'session_id': sessionId,
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return IncorrectAnswerResult.fromJson(responseData);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load incorrect answers');
    }
  }


  Future<UnattemptedAnswerResult?> fetchUnattemptedAnswers({
    required String examId,
    required String sessionId,
    required String userId,
  }) async {
    final apiUrl = 'https://gyanmeeti.in/API/unattempted_answers.php'; // Replace with your new API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'exam_id': examId,
        'session_id': sessionId,
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return UnattemptedAnswerResult.fromJson(responseData);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load unattempted answers');
    }
  }




  @override
  void initState() {
    super.initState();
    _resultData =
        fetchResultData(widget.examId, widget.sessionId, widget.userId);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        // actions: [
        //   // Add an icon button to refresh data if needed
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () {
        //       setState(() {
        //         _resultData = fetchResultData(
        //             widget.examId, widget.sessionId, widget.userId);
        //       });
        //     },
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      "Overview",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Correct",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Incorrect",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Unattempted",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder<ResultModel?>(
            future: _resultData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is being fetched, display a loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                // If there is an error in fetching data or no data available, display an error message
                return const Center(
                  child: Text('Error: Unable to fetch data.'),
                );
              } else {
                // If data is successfully fetched, display it
                final data = snapshot.data!;

                return Column(
                  children: [
                    SizedBox(height: 20.sp,),
                    Text("Result Overview",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Card(
                      // Wrap the ListView in a Card widget
                      margin: EdgeInsets.all(26.sp),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildResultItem(
                              title: 'Your Score',
                              value: data.yourScore ?? 'N/A',
                              image: Image.asset('assets/images/cup.png',
                                height: 30.sp,
                              ),
                            ),
                            // _buildResultItem(
                            //   value: 'Rank',
                            //   title: 'N/A',
                            //   image: Image.asset('assets/images/cup.png',
                            //     height: 30.sp,
                            //   ),
                            // ),
                            _buildResultItem(
                              title: 'Percentile',
                              value: data.percentile ?? 'N/A',
                              image: Image.asset('assets/images/Percentile.png',
                                height: 30.sp,
                              ),
                            ),
                            _buildResultItem(
                              title: 'Correct',
                              value: data.totalCorrectAnswers ?? 'N/A',
                              image: Image.asset('assets/images/Correct.png',
                                height: 30.sp,
                              ),
                            ),
                            _buildResultItem(
                              title: 'Incorrect',
                              value: data.totalWrongAnswers ?? 'N/A',
                              image: Image.asset('assets/images/Incorrect.png',
                                height: 30.sp,
                              ),
                            ),
                            _buildResultItem(
                              title: 'Unattempted',
                              value: data.unAttempted ?? 'N/A',
                              image: Image.asset('assets/images/Unattempted.png',
                                height: 30.sp,
                              ),
                            ),
                            _buildResultItem(
                              title: 'Accuracy',
                              value: data.accuracy ?? 'N/A',
                              image: Image.asset('assets/images/Accuracy.png',
                                height: 30.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          FutureBuilder<CorectResult?>(
            future: fetchCorrectAnswer(
              examId: widget.examId,
              userId: widget.userId,
              sessionId: widget.sessionId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is being fetched, display a loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                // If there is an error in fetching data or no data available, display an error message
                return const Center(
                  child: Text('Error: Unable to fetch data.'),
                );
              } else {
                // If data is successfully fetched, display it
                final data = snapshot.data!;

                // Filter the correct answers
                final correctAnswers = data.correctAnswers ?? [];

                return ListView.builder(
                  itemCount: correctAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = correctAnswers[index];
                    // return ListTile(
                    //   leading: Image.asset(
                    //     'assets/images/correct.png', // Replace with the correct image path
                    //     height: 30,
                    //   ),
                    //   title: Text(answer.question ?? 'N/A'),
                    //   subtitle: Text('Answer: ${answer.answer ?? 'N/A'}'),
                    // );
                    return Card(
                      margin: EdgeInsets.all(26.sp),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Question No ${index + 1}"),
                            Text("Question: ${answer.question}" ?? 'N/A'),
                            (answer.question_image!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/question_image/${answer.question_image}") :  SizedBox(),
                            Text('Answer: ${answer.answer ?? 'N/A'}'),
                            Text('Answer Description : ${answer.answer_description ?? 'N/A'}'),
                            (answer.answer_description_image!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/answer_des_image/${answer.answer_description_image}") :  SizedBox(),


                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder(
            future: fetchIncorrectAnswers(
              examId: widget.examId,
              userId: widget.userId,
              sessionId: widget.sessionId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is being fetched, display a loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                // If there is an error in fetching data or no data available, display an error message
                return const Center(
                  child: Text('Error: Unable to fetch data.'),
                );
              } else {
                // If data is successfully fetched, display it
                final data = snapshot.data!;

                // Filter the correct answers
                final correctAnswers = data.incorrectAnswers ?? [];

                return ListView.builder(
                  itemCount: correctAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = correctAnswers[index];
                    return Card(
                      margin: EdgeInsets.all(26.sp),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Question No ${index + 1}"),
                            Text("Question: ${answer.question}" ?? 'N/A'),
                            (answer.questionImage!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/question_image/${answer.questionImage}") :  SizedBox(),
                            Text('Answer: ${answer.answer ?? 'N/A'}'),
                            Text('Answer Description : ${answer.answerDescription ?? 'N/A'}'),
                            (answer.answerDescriptionImage!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/answer_des_image/${answer.answerDescriptionImage}") :  SizedBox(),


                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder<UnattemptedAnswerResult?>(
            future: fetchUnattemptedAnswers(
              examId: widget.examId,
              userId: widget.userId,
              sessionId: widget.sessionId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is being fetched, display a loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                // If there is an error in fetching data or no data available, display an error message
                return const Center(
                  child: Text('Error: Unable to fetch data.'),
                );
              } else {
                // If data is successfully fetched, display it
                final data = snapshot.data!;

                // Filter the correct answers
                final correctAnswers = data.unattemptedAnswers ?? [];

                return ListView.builder(
                  itemCount: correctAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = correctAnswers[index];
                    return Card(
                      margin: EdgeInsets.all(26.sp),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Question No ${index + 1}"),
                            Text("Question: ${answer.question}" ?? 'N/A'),
                            (answer.questionImage!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/question_image/${answer.questionImage}") :  SizedBox(),
                            Text('Answer: ${answer.finalAnswer ?? 'N/A'}'),
                            Text('Answer Description : ${answer.answerDescription ?? 'N/A'}'),
                            (answer.answerDescriptionImage!.isNotEmpty)? Image.network("https://gyanmeeti.in/admin/answer_des_image/${answer.answerDescriptionImage}") :  SizedBox(),


                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),

        ],
      ),
    );
  }

  Widget _buildResultItem(
      {required String title, required String value, required Image image}) {
    return ListTile(
      leading: image,
      title: Text( title +" : " + value),
      // subtitle: Text(value),
    );
  }
}


