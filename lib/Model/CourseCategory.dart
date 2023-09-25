class CourseCategory {
  final String id;
  final String categoryName;
  final String categoryImage;

  CourseCategory({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      id: json['id'].toString(), // Convert id to string
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
    );
  }
}
