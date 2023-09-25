class ExamListExamTileModel {
  final String? id;
  final String? examName;
  // final String? duration;
  final String? createdBy;
  final String? session;
  final String? fees;
  final String? image;
  final String? enrollStatus;

  ExamListExamTileModel({
    this.id,
    this.examName,
    // this.duration,
    this.createdBy,
    this.session,
    this.fees,
    this.image,
    this.enrollStatus,
  });

  factory ExamListExamTileModel.fromJson(Map<String, dynamic> json) {
    return ExamListExamTileModel(
      id: json['id'],
      examName: json['exam_name'],
      // duration: json['duration'],
      createdBy: json['created_by'],
      session: json['session'],
      fees: json['fees'],
      image: json['image'],
      enrollStatus: json['enroll_status'],
    );
  }
}
