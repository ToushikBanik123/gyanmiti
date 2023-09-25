
class PaidCourseSubjectChapterModel {
  final String? id;
  final String? chapterName;

  PaidCourseSubjectChapterModel({
    required this.id,
    required this.chapterName,
  });

  factory PaidCourseSubjectChapterModel.fromJson(Map<String, dynamic> json) {
    return PaidCourseSubjectChapterModel(
      id: json['id'] ?? '',
      chapterName: json['chapter_name'] ?? '',
    );
  }
}