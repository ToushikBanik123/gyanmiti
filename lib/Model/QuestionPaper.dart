class QuestionPaper {
  String? id;
  String? questionNo;
  String? question;
  String? questionImage;
  String? option1;
  String? option1Image;
  String? option2;
  String? option2Image;
  String? option3;
  String? option3Image;
  String? option4;
  String? option4Image;
  String? finalAnswer;
  String? answerDescription;
  String? answerDescriptionImage;

  QuestionPaper({
    this.id,
    this.questionNo,
    this.question,
    this.questionImage,
    this.option1,
    this.option1Image,
    this.option2,
    this.option2Image,
    this.option3,
    this.option3Image,
    this.option4,
    this.option4Image,
    this.finalAnswer,
    this.answerDescription,
    this.answerDescriptionImage,
  });

  factory QuestionPaper.fromJson(Map<String, dynamic> json) {
    return QuestionPaper(
      id: json['id'],
      questionNo: json['question_no'],
      question: json['question'],
      questionImage: json['question_image'],
      option1: json['option1'],
      option1Image: json['option1_image'],
      option2: json['option2'],
      option2Image: json['option2_image'],
      option3: json['option3'],
      option3Image: json['option3_image'],
      option4: json['option4'],
      option4Image: json['option4_image'],
      finalAnswer: json['final_answer'],
      answerDescription: json['answer_description'],
      answerDescriptionImage: json['answer_description_image'],
    );
  }
}

class UserAnswer {
  String questionId; // You may use question ID or any other identifier.
  int selectedOptionIndex; // Index of the selected option (-1 if none selected).

  UserAnswer({
    required this.questionId,
    required this.selectedOptionIndex,
  });
}
