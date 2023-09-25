class PaidCourseSubjectModel {
  final String? id;
  final String? subject;

  PaidCourseSubjectModel({required this.id, required this.subject});

  factory PaidCourseSubjectModel.fromJson(Map<String, dynamic> json) {
    return PaidCourseSubjectModel(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
    );
  }
}
