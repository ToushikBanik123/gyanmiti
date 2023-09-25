class PaidCourseModel {
  final String? id;
  final String? courseName;
  final String? logo;
  final double? price;
  final String? enrollStatus;

  PaidCourseModel({this.id, this.courseName, this.logo, this.price, this.enrollStatus});

  factory PaidCourseModel.fromJson(Map<String, dynamic> json) {
    return PaidCourseModel(
      id: json['id'],
      courseName: json['course_name'],
      logo: json['logo'],
      price: json['price'] != null ? double.parse(json['price']) : null,
      enrollStatus: json['enroll_status'],
    );
  }
}