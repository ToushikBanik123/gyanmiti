class FreeClassData {
  final String id;
  final String className;

  FreeClassData({required this.id, required this.className});

  factory FreeClassData.fromJson(Map<String, dynamic> json) {
    return FreeClassData(
      id: json['id'],
      className: json['class_name'],
    );
  }
}
