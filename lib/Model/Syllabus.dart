class Syllabus {
  final int id;
  final String syllabusPdf;
  final String courseName;
  final String registerDate;

  Syllabus({
    required this.id,
    required this.syllabusPdf,
    required this.courseName,
    required this.registerDate,
  });

  factory Syllabus.fromJson(Map<String, dynamic> json) {
    return Syllabus(
      id: int.parse(json['id']),
      syllabusPdf: json['syllabus_pdf'],
      courseName: json['course_name'],
      registerDate: json['register_date'],
    );
  }
}
