class ExamCategoryModel {
  final String id;
  final String categoryName;
  final String categoryImage;

  ExamCategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory ExamCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExamCategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
    );
  }
}
