class ExamDetails {
  final String? id;
  final String? examName;
  // final String? duration;
  // final String? totalMark;
  // final String? passMark;
  final String? createdBy;
  final String? session;
  final String? fees;
  final String? image;
  final String? enrollStatus;

  ExamDetails({
    this.id,
    this.examName,
    // this.duration,
    // this.totalMark,
    // this.passMark,
    this.createdBy,
    this.session,
    this.fees,
    this.image,
    this.enrollStatus,
  });

  factory ExamDetails.fromJson(Map<String, dynamic> json) {
    return ExamDetails(
      id: json['id'],
      examName: json['exam_name'],
      // duration: json['duration'],
      // totalMark: json['total_mark'],
      // passMark: json['pass_mark'],
      createdBy: json['created_by'],
      session: json['session'],
      fees: json['fees'],
      image: json['image'],
      enrollStatus: json['enroll_status'],
    );
  }
}
