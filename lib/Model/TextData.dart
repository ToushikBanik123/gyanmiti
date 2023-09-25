class TextData {
  final String id;
  final String title;
  final String description;
  final String registerDate;

  TextData({
    required this.id,
    required this.title,
    required this.description,
    required this.registerDate,
  });

  factory TextData.fromJson(Map<String, dynamic> json) {
    return TextData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      registerDate: json['register_date'],
    );
  }
}
