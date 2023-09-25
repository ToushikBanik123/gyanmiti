class ExamSession {
  final String? id;
  final String? sessionName;
  final String? duration;
  final String? noOfQuestions;
  final String? totalMarks;
  final String? passMarks;
  final String? attemptStatus;

  ExamSession({
    required this.id,
    required this.sessionName,
    required this.duration,
    required this.noOfQuestions,
    required this.totalMarks,
    required this.passMarks,
    required this.attemptStatus,
  });

  factory ExamSession.fromJson(Map<String, dynamic> json) {
    return ExamSession(
      id: json['id'],
      sessionName: json['session_name'],
      duration: json['duration'],
      noOfQuestions: json['no_of_questions'],
      totalMarks: json['total_marks'],
      passMarks: json['pass_marks'],
      attemptStatus: json['attempt_status'],
    );
  }
}
